import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text_styles.dart';

/// A reusable chip widget with color, label, onTap, and selected state.
/// Used for filter chips, industry tags, risk level indicators, etc.
class AppChip extends StatelessWidget {
  /// The label text displayed on the chip.
  final String label;

  /// Background color of the chip.
  final Color? backgroundColor;

  /// Text color of the label.
  final Color? textColor;

  /// Whether the chip is currently selected.
  final bool isSelected;

  /// Callback when the chip is tapped.
  final VoidCallback? onTap;

  /// Whether to show a close/remove icon.
  final bool showRemoveIcon;

  /// Callback when the remove icon is tapped.
  final VoidCallback? onRemove;

  const AppChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.isSelected = false,
    this.onTap,
    this.showRemoveIcon = false,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected
        ? (backgroundColor ?? AppColors.primary)
        : AppColors.surfaceElevated;
    final fgColor = isSelected
        ? (textColor ?? AppColors.background)
        : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? (backgroundColor ?? AppColors.primary)
                : AppColors.divider,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.label.copyWith(color: fgColor),
            ),
            if (showRemoveIcon) ...[
              const SizedBox(width: AppSpacing.xs),
              GestureDetector(
                onTap: onRemove ?? onTap,
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: fgColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
