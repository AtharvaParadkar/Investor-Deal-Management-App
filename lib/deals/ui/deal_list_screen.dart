import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../login/bloc/login_bloc.dart';
import '../../login/bloc/login_event.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../my_interest/bloc/my_interest_bloc.dart';
import '../../utils/widgets/empty_state_widget.dart';
import '../../utils/widgets/loading_indicator.dart';
import '../bloc/deal_bloc.dart';
import '../bloc/deal_event.dart';
import '../bloc/deal_state.dart';
import '../bloc/filter_bloc.dart';
import '../bloc/filter_event.dart';
import '../bloc/filter_state.dart';
import '../model/deal_model.dart';
import 'deal_detail_screen.dart';
import 'widgets/deal_card.dart';
import 'widgets/filter_bottom_sheet.dart';

class DealListScreen extends StatefulWidget {
  const DealListScreen({super.key});

  @override
  State<DealListScreen> createState() => _DealListScreenState();
}

class _DealListScreenState extends State<DealListScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<FilterBloc>().add(SearchQueryChanged(query));
    });
  }

  void _openFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<FilterBloc>(),
        child: const FilterBottomSheet(),
      ),
    );
  }

  void _onDealTap(DealModel deal) {
    final interestBloc = context.read<MyInterestBloc>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: interestBloc,
          child: DealDetailScreen(deal: deal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(AppStrings.allDeals, style: AppTextStyles.heading),
        actions: [
          BlocBuilder<FilterBloc, FilterState>(
            builder: (context, filterState) {
              final hasFilters = filterState.criteria.hasActiveFilters;
              return Stack(children: [
                IconButton(
                  icon: Icon(Icons.tune_rounded,
                    color: hasFilters ? AppColors.primary : AppColors.textSecondary),
                  onPressed: _openFilters),
                if (hasFilters)
                  Positioned(right: 8, top: 8,
                    child: Container(width: 8, height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary, shape: BoxShape.circle))),
              ]);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded,
              color: AppColors.textSecondary, size: 22),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: AppColors.surface,
                  title: Text(AppStrings.logout, style: AppTextStyles.subheading),
                  content: Text(AppStrings.logoutConfirm,
                    style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(AppStrings.cancel,
                        style: AppTextStyles.label.copyWith(color: AppColors.textSecondary))),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        context.read<LoginBloc>().add(const LogoutRequested());
                      },
                      child: Text(AppStrings.confirm,
                        style: AppTextStyles.label.copyWith(color: AppColors.riskHigh))),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
              border: Border.all(color: AppColors.divider.withOpacity(0.5))),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: AppTextStyles.body,
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: AppStrings.searchDeals,
                hintStyle: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary.withOpacity(0.5)),
                prefixIcon: const Icon(Icons.search_rounded,
                  color: AppColors.textSecondary, size: 20),
                suffixIcon: BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, state) {
                    if (state.criteria.searchQuery.isNotEmpty) {
                      return IconButton(
                        icon: const Icon(Icons.close_rounded,
                          color: AppColors.textSecondary, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          context.read<FilterBloc>().add(const SearchQueryChanged(''));
                        });
                    }
                    return const SizedBox.shrink();
                  }),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg, vertical: AppSpacing.md),
              ),
            ),
          ),
        ),

        // Active filter chips
        BlocBuilder<FilterBloc, FilterState>(
          builder: (context, filterState) {
            final criteria = filterState.criteria;
            if (!criteria.hasActiveFilters) return const SizedBox.shrink();
            return SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                children: [
                  if (criteria.minROI > 0 || criteria.maxROI < 50)
                    _buildActiveChip(
                      'ROI: ${criteria.minROI.toInt()}%-${criteria.maxROI.toInt()}%',
                      () => context.read<FilterBloc>().add(const ROIRangeChanged(0, 50))),
                  ...criteria.selectedRiskLevels.map((level) {
                    final name = level.name[0].toUpperCase() + level.name.substring(1);
                    return _buildActiveChip(name,
                      () => context.read<FilterBloc>().add(RiskLevelToggled(level)));
                  }),
                  ...criteria.selectedIndustries.map((industry) =>
                    _buildActiveChip(industry,
                      () => context.read<FilterBloc>().add(IndustryToggled(industry)))),
                ],
              ),
            );
          },
        ),

        // Deal list
        Expanded(
          child: BlocBuilder<DealBloc, DealState>(
            builder: (context, state) {
              if (state is DealsInitial || state is DealsLoading) {
                return const LoadingIndicator(message: 'Loading deals...');
              }
              if (state is DealsError) {
                return EmptyStateWidget(
                  icon: Icons.error_outline_rounded,
                  message: AppStrings.errorLoadingDeals,
                  actionLabel: AppStrings.retry,
                  onAction: () => context.read<DealBloc>().add(const LoadDeals()));
              }
              if (state is DealsEmpty) {
                return const EmptyStateWidget(
                  icon: Icons.inbox_rounded, message: AppStrings.noDealFound);
              }
              if (state is DealsLoaded) {
                if (state.filteredDeals.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.filter_list_off_rounded,
                    message: AppStrings.noDealsMatchFilter,
                    actionLabel: AppStrings.clearAll,
                    onAction: () {
                      context.read<FilterBloc>().add(const FiltersCleared());
                      _searchController.clear();
                    });
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<DealBloc>().add(const RefreshDeals());
                    await context.read<DealBloc>().stream.firstWhere(
                      (s) => s is DealsLoaded || s is DealsError);
                  },
                  color: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: state.filteredDeals.length,
                    itemBuilder: (context, index) {
                      final deal = state.filteredDeals[index];
                      return DealCard(deal: deal, onTap: () => _onDealTap(deal));
                    }),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildActiveChip(String label, VoidCallback onRemove) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: Chip(
        label: Text(label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.primary, fontSize: 11)),
        deleteIcon: const Icon(Icons.close, size: 14),
        deleteIconColor: AppColors.primary,
        onDeleted: onRemove,
        backgroundColor: AppColors.primary.withOpacity(0.1),
        side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact),
    );
  }
}
