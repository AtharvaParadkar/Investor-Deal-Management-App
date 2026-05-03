import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text_styles.dart';

class AppChip extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool showRemoveIcon;
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
                child: Icon(Icons.close, size: 14, color: fgColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
