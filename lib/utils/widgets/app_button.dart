import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text_styles.dart';

/// A styled, full-width button with loading state support.
/// Used throughout the app for primary and secondary actions.
class AppButton extends StatelessWidget {
  /// The button label text.
  final String label;

  /// Callback when the button is pressed. Null disables the button.
  final VoidCallback? onPressed;

  /// Whether the button is in a loading state (shows spinner).
  final bool isLoading;

  /// Background color of the button.
  final Color? backgroundColor;

  /// Text color of the button label.
  final Color? textColor;

  /// Optional icon to display before the label.
  final IconData? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.primary;
    final fgColor = textColor ?? AppColors.background;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          disabledBackgroundColor: bgColor.withOpacity(0.5),
          foregroundColor: fgColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 20),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Text(
                      label,
                      style: AppTextStyles.subheading.copyWith(
                        color: fgColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
