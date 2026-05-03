import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_text_styles.dart';
import '../../../utils/formatters.dart';
import '../../model/deal_model.dart';
import 'risk_chip.dart';
import 'status_badge.dart';

class DealCard extends StatelessWidget {
  final DealModel deal;
  final VoidCallback? onTap;
  final Widget? trailing;

  const DealCard({
    super.key,
    required this.deal,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isClosed = deal.status == DealStatus.closed;

    return Opacity(
      opacity: isClosed ? 0.55 : 1.0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(
              color: AppColors.divider.withOpacity(0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deal.companyName,
                          style: AppTextStyles.subheading.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            deal.industry,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      StatusBadge(status: deal.status),
                      if (trailing != null) ...[
                        const SizedBox(height: AppSpacing.sm),
                        trailing!,
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(height: 1, color: AppColors.divider.withOpacity(0.3)),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _MetricItem(
                      label: 'Investment',
                      value: Formatters.formatINR(deal.investmentRequired),
                      valueColor: AppColors.textPrimary,
                    ),
                  ),
                  Expanded(
                    child: _MetricItem(
                      label: 'ROI',
                      value: Formatters.formatROI(deal.expectedROI),
                      valueColor: AppColors.gold,
                    ),
                  ),
                  RiskChip(riskLevel: deal.riskLevel, compact: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _MetricItem({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption.copyWith(fontSize: 10)),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.label.copyWith(
            color: valueColor,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
