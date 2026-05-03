import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../model/deal_model.dart';

/// A color-coded chip displaying the risk level of a deal.
/// Green for Low, Amber for Medium, Red for High.
class RiskChip extends StatelessWidget {
  /// The risk level to display.
  final RiskLevel riskLevel;

  /// Optional smaller size variant.
  final bool compact;

  const RiskChip({
    super.key,
    required this.riskLevel,
    this.compact = false,
  });

  /// Returns the appropriate color for the risk level.
  Color get _color {
    switch (riskLevel) {
      case RiskLevel.low:
        return AppColors.riskLow;
      case RiskLevel.medium:
        return AppColors.riskMedium;
      case RiskLevel.high:
        return AppColors.riskHigh;
    }
  }

  /// Returns the display label for the risk level.
  String get _label {
    switch (riskLevel) {
      case RiskLevel.low:
        return 'Low Risk';
      case RiskLevel.medium:
        return 'Medium Risk';
      case RiskLevel.high:
        return 'High Risk';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withOpacity(0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: compact ? 5 : 6,
            height: compact ? 5 : 6,
            decoration: BoxDecoration(
              color: _color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: compact ? 4 : 6),
          Text(
            _label,
            style: (compact ? AppTextStyles.caption : AppTextStyles.label)
                .copyWith(color: _color, fontSize: compact ? 10 : 11),
          ),
        ],
      ),
    );
  }
}
