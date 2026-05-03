import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../utils/widgets/app_button.dart';
import '../../../utils/widgets/app_chip.dart';
import '../../bloc/filter_bloc.dart';
import '../../bloc/filter_event.dart';
import '../../bloc/filter_state.dart';
import '../../model/deal_model.dart';
import '../../repository/deal_repository.dart';

/// A bottom sheet for configuring deal filter criteria.
/// Includes ROI range slider, risk level chips, and industry chips.
class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Simple direct constructor — no DI needed
    final industries = DealRepository().getAvailableIndustries();

    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        final criteria = state.criteria;

        return Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.filterDeals, style: AppTextStyles.heading),
                  if (criteria.hasActiveFilters)
                    TextButton(
                      onPressed: () {
                        context.read<FilterBloc>().add(const FiltersCleared());
                      },
                      child: Text(
                        AppStrings.clearAll,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.riskHigh,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // ROI Range
              Text(
                '${AppStrings.roiRange}: ${criteria.minROI.toInt()}% - ${criteria.maxROI.toInt()}%',
                style: AppTextStyles.subheading.copyWith(fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.sm),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.surfaceElevated,
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.primary.withOpacity(0.2),
                  rangeThumbShape: const RoundRangeSliderThumbShape(
                    enabledThumbRadius: 8,
                  ),
                  rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
                ),
                child: RangeSlider(
                  values: RangeValues(criteria.minROI, criteria.maxROI),
                  min: 0,
                  max: 50,
                  divisions: 50,
                  onChanged: (values) {
                    context.read<FilterBloc>().add(
                          ROIRangeChanged(values.start, values.end),
                        );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Risk Level
              Text(
                AppStrings.riskLevel,
                style: AppTextStyles.subheading.copyWith(fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: RiskLevel.values.map((level) {
                  final isSelected =
                      criteria.selectedRiskLevels.contains(level);
                  final label = level.name[0].toUpperCase() +
                      level.name.substring(1);
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: AppChip(
                      label: label,
                      isSelected: isSelected,
                      backgroundColor: _riskColor(level),
                      textColor: AppColors.white,
                      onTap: () {
                        context
                            .read<FilterBloc>()
                            .add(RiskLevelToggled(level));
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Industry
              Text(
                AppStrings.industry,
                style: AppTextStyles.subheading.copyWith(fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: industries.map((industry) {
                  final isSelected =
                      criteria.selectedIndustries.contains(industry);
                  return AppChip(
                    label: industry,
                    isSelected: isSelected,
                    onTap: () {
                      context
                          .read<FilterBloc>()
                          .add(IndustryToggled(industry));
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Apply Button
              AppButton(
                label: AppStrings.applyFilters,
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        );
      },
    );
  }

  /// Returns the appropriate color for a risk level.
  Color _riskColor(RiskLevel level) {
    switch (level) {
      case RiskLevel.low:
        return AppColors.riskLow;
      case RiskLevel.medium:
        return AppColors.riskMedium;
      case RiskLevel.high:
        return AppColors.riskHigh;
    }
  }
}
