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

/// Detail screen for a single deal with full financial information,
/// ROI projection chart, risk analysis, and interest toggle button.
class DealDetailScreen extends StatelessWidget {
  /// The deal to display in detail.
  final DealModel deal;

  const DealDetailScreen({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    // Check interest status on screen open
    context.read<MyInterestBloc>().add(CheckInterestStatus(deal.id));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: AppColors.surface,
            expandedHeight: 120,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
              color: AppColors.textPrimary,
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                left: 56,
                bottom: 16,
                right: 16,
              ),
              title: Hero(
                tag: 'deal_name_${deal.id}',
                child: Material(
                  color: AppColors.transparent,
                  child: Text(
                    deal.companyName,
                    style: AppTextStyles.subheading.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            actions: [
              StatusBadge(status: deal.status),
              const SizedBox(width: AppSpacing.lg),
            ],
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Section 1: Company Overview
                _buildSectionTitle(AppStrings.companyOverview),
                const SizedBox(height: AppSpacing.md),
                _buildOverviewSection(),
                const SizedBox(height: AppSpacing.xl),

                // Section 2: Financial Highlights
                _buildSectionTitle(AppStrings.financialHighlights),
                const SizedBox(height: AppSpacing.md),
                _buildFinancialSection(),
                const SizedBox(height: AppSpacing.xl),

                // Section 3: ROI Projection
                _buildSectionTitle(AppStrings.roiProjection),
                const SizedBox(height: AppSpacing.md),
                ROIProjectionChart(expectedROI: deal.expectedROI),
                const SizedBox(height: AppSpacing.xl),

                // Section 4: Risk Analysis
                _buildSectionTitle(AppStrings.riskAnalysis),
                const SizedBox(height: AppSpacing.md),
                _buildRiskSection(),

                // Bottom padding for sticky button
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),

      // Sticky bottom bar with interest button
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  /// Builds a section title with a green accent bar.
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(title, style: AppTextStyles.subheading),
      ],
    );
  }

  /// Builds the company overview section.
  Widget _buildOverviewSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Industry & Funding Stage chips
          Row(
            children: [
              _buildInfoChip(deal.industry, AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              _buildInfoChip(deal.fundingStage, AppColors.gold),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            deal.description,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the financial highlights grid.
  Widget _buildFinancialSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetric(
                  AppStrings.investmentRequired,
                  Formatters.formatINR(deal.investmentRequired),
                  AppColors.textPrimary,
                ),
              ),
              Expanded(
                child: _buildMetric(
                  AppStrings.expectedROI,
                  Formatters.formatROI(deal.expectedROI),
                  AppColors.gold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(height: 1, color: AppColors.divider.withOpacity(0.3)),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _buildMetric(
                  AppStrings.minimumTicket,
                  Formatters.formatINR(deal.minimumTicketSize),
                  AppColors.textPrimary,
                ),
              ),
              Expanded(
                child: _buildMetric(
                  AppStrings.fundingStage,
                  deal.fundingStage,
                  AppColors.primaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the risk analysis section.
  Widget _buildRiskSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RiskChip(riskLevel: deal.riskLevel),
          const SizedBox(height: AppSpacing.lg),
          Text(
            AppStrings.riskFactors,
            style: AppTextStyles.label.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...deal.riskFactors.map((factor) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.riskMedium,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        factor,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  /// Builds the sticky bottom bar with the interest/closed button.
  Widget _buildBottomBar(BuildContext context) {
    final isClosed = deal.status == DealStatus.closed;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.divider.withOpacity(0.5)),
        ),
      ),
      child: SafeArea(
        child: isClosed
            ? AppButton(
                label: AppStrings.dealClosed,
                backgroundColor: AppColors.statusClosed,
                textColor: AppColors.textPrimary,
                onPressed: null,
              )
            : BlocBuilder<MyInterestBloc, MyInterestState>(
                builder: (context, state) {
                  final isInterested = state is InterestToggled
                      ? state.isInterested
                      : (state is MyInterestsLoaded &&
                          state.interestedDealIds.contains(deal.id));

                  return AppButton(
                    label: isInterested
                        ? AppStrings.removeInterest
                        : AppStrings.imInterested,
                    backgroundColor: isInterested
                        ? AppColors.riskHigh.withOpacity(0.2)
                        : AppColors.primary,
                    textColor: isInterested
                        ? AppColors.riskHigh
                        : AppColors.background,
                    icon: isInterested
                        ? Icons.bookmark_remove_outlined
                        : Icons.bookmark_add_outlined,
                    onPressed: () {
                      if (isInterested) {
                        context
                            .read<MyInterestBloc>()
                            .add(RemoveInterest(deal.id));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppStrings.interestRemoved),
                            backgroundColor: AppColors.surfaceElevated,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        context
                            .read<MyInterestBloc>()
                            .add(AddInterest(deal.id));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppStrings.interestAdded),
                            backgroundColor: AppColors.primary,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
      ),
    );
  }

  /// Builds a small info chip with the given label and color.
  Widget _buildInfoChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: AppTextStyles.label.copyWith(color: color, fontSize: 11),
      ),
    );
  }

  /// Builds a labeled financial metric.
  Widget _buildMetric(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(fontSize: 11),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppTextStyles.subheading.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
