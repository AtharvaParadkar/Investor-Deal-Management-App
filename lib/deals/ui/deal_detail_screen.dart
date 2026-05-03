import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../my_interest/bloc/my_interest_bloc.dart';
import '../../my_interest/bloc/my_interest_event.dart';
import '../../my_interest/bloc/my_interest_state.dart';
import '../../utils/formatters.dart';
import '../../utils/widgets/app_button.dart';
import '../model/deal_model.dart';
import 'widgets/risk_chip.dart';
import 'widgets/roi_projection_chart.dart';
import 'widgets/status_badge.dart';

class DealDetailScreen extends StatefulWidget {
  final DealModel deal;

  const DealDetailScreen({super.key, required this.deal});

  @override
  State<DealDetailScreen> createState() => _DealDetailScreenState();
}

class _DealDetailScreenState extends State<DealDetailScreen> {
  // Local interest state for instant, reliable button updates.
  // Initialised to false; set correctly once CheckInterestStatus resolves.
  bool _isInterested = false;
  bool _statusLoaded = false;

  @override
  void initState() {
    super.initState();
    context.read<MyInterestBloc>().add(CheckInterestStatus(widget.deal.id));
  }

  void _toggle() {
    if (_isInterested) {
      context.read<MyInterestBloc>().add(RemoveInterest(widget.deal.id));
      setState(() => _isInterested = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppStrings.interestRemoved),
        backgroundColor: AppColors.surfaceElevated,
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      context.read<MyInterestBloc>().add(AddInterest(widget.deal.id));
      setState(() => _isInterested = true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppStrings.interestAdded),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyInterestBloc, MyInterestState>(
      listener: (context, state) {
        // Sync local flag once the initial status check resolves.
        if (state is InterestToggled && state.dealId == widget.deal.id && !_statusLoaded) {
          setState(() {
            _isInterested = state.isInterested;
            _statusLoaded = true;
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: AppColors.surface,
            expandedHeight: 120, pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
              color: AppColors.textPrimary,
              onPressed: () => Navigator.of(context).pop()),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 56, bottom: 16, right: 16),
              title: Material(
                color: AppColors.transparent,
                child: Text(widget.deal.companyName,
                  style: AppTextStyles.subheading.copyWith(
                    fontWeight: FontWeight.w700, fontSize: 16),
                  maxLines: 1, overflow: TextOverflow.ellipsis))),
            actions: [
              StatusBadge(status: widget.deal.status),
              const SizedBox(width: AppSpacing.lg)]),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            sliver: SliverList(delegate: SliverChildListDelegate([
              _buildSectionTitle(AppStrings.companyOverview),
              const SizedBox(height: AppSpacing.md),
              _buildOverviewSection(),
              const SizedBox(height: AppSpacing.xl),
              _buildSectionTitle(AppStrings.financialHighlights),
              const SizedBox(height: AppSpacing.md),
              _buildFinancialSection(),
              const SizedBox(height: AppSpacing.xl),
              _buildSectionTitle(AppStrings.roiProjection),
              const SizedBox(height: AppSpacing.md),
              ROIProjectionChart(expectedROI: widget.deal.expectedROI),
              const SizedBox(height: AppSpacing.xl),
              _buildSectionTitle(AppStrings.riskAnalysis),
              const SizedBox(height: AppSpacing.md),
              _buildRiskSection(),
              const SizedBox(height: 100),
            ]))),
        ]),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(children: [
      Container(width: 4, height: 20,
        decoration: BoxDecoration(
          color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: AppSpacing.sm),
      Text(title, style: AppTextStyles.subheading),
    ]);
  }

  Widget _buildOverviewSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.divider, width: 1)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          _buildInfoChip(widget.deal.industry, AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          _buildInfoChip(widget.deal.fundingStage, AppColors.gold),
        ]),
        const SizedBox(height: AppSpacing.lg),
        Text(widget.deal.description,
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondary, height: 1.6)),
      ]),
    );
  }

  Widget _buildFinancialSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.divider, width: 1)),
      child: Column(children: [
        Row(children: [
          Expanded(child: _buildMetric(AppStrings.investmentRequired,
            Formatters.formatINR(widget.deal.investmentRequired), AppColors.textPrimary)),
          Expanded(child: _buildMetric(AppStrings.expectedROI,
            Formatters.formatROI(widget.deal.expectedROI), AppColors.gold)),
        ]),
        const SizedBox(height: AppSpacing.lg),
        Container(height: 1, color: AppColors.divider.withOpacity(0.3)),
        const SizedBox(height: AppSpacing.lg),
        Row(children: [
          Expanded(child: _buildMetric(AppStrings.minimumTicket,
            Formatters.formatINR(widget.deal.minimumTicketSize), AppColors.textPrimary)),
          Expanded(child: _buildMetric(AppStrings.fundingStage,
            widget.deal.fundingStage, AppColors.primaryLight)),
        ]),
      ]),
    );
  }

  Widget _buildRiskSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.divider, width: 1)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RiskChip(riskLevel: widget.deal.riskLevel),
        const SizedBox(height: AppSpacing.lg),
        Text(AppStrings.riskFactors,
          style: AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: AppSpacing.sm),
        ...widget.deal.riskFactors.map((factor) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(margin: const EdgeInsets.only(top: 6), width: 5, height: 5,
              decoration: BoxDecoration(
                color: AppColors.riskMedium, shape: BoxShape.circle)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(factor,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary, height: 1.4))),
          ]))),
      ]),
    );
  }

  Widget _buildBottomBar() {
    final isClosed = widget.deal.status == DealStatus.closed;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider.withOpacity(0.5)))),
      child: SafeArea(
        child: isClosed
            ? AppButton(
                label: AppStrings.dealClosed,
                backgroundColor: AppColors.statusClosed,
                textColor: AppColors.textPrimary,
                onPressed: null)
            : AppButton(
                label: _isInterested ? AppStrings.removeInterest : AppStrings.imInterested,
                backgroundColor: _isInterested
                    ? AppColors.riskHigh.withOpacity(0.2)
                    : AppColors.primary,
                textColor: _isInterested ? AppColors.riskHigh : AppColors.background,
                icon: _isInterested
                    ? Icons.bookmark_remove_outlined
                    : Icons.bookmark_add_outlined,
                onPressed: _toggle),
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3))),
      child: Text(label,
        style: AppTextStyles.label.copyWith(color: color, fontSize: 11)),
    );
  }

  Widget _buildMetric(String label, String value, Color valueColor) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: AppTextStyles.caption.copyWith(fontSize: 11)),
      const SizedBox(height: AppSpacing.xs),
      Text(value, style: AppTextStyles.subheading.copyWith(
        color: valueColor, fontWeight: FontWeight.w700)),
    ]);
  }
}
