import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text_styles.dart';

/// A styled text input field with label, hint, error, and suffix icon support.
/// Used throughout the app for form inputs.
class AppTextField extends StatelessWidget {
  /// Controller for the text field.
  final TextEditingController? controller;

  /// Hint text displayed when the field is empty.
  final String? hintText;

  /// Label text displayed above the field.
  final String? labelText;

  /// Error text displayed below the field.
  final String? errorText;

  /// Whether to obscure the text (for passwords).
  final bool obscureText;

  /// Suffix icon widget (e.g., visibility toggle).
  final Widget? suffixIcon;

  /// Prefix icon.
  final IconData? prefixIcon;

  /// Keyboard type.
  final TextInputType? keyboardType;

  /// Callback when text changes.
  final ValueChanged<String>? onChanged;

  /// Form field validator.
  final String? Function(String?)? validator;

  /// Text input action.
  final TextInputAction? textInputAction;

  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(labelText!, style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.xs),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
          textInputAction: textInputAction,
          style: AppTextStyles.body,
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            errorText: errorText,
            errorStyle: AppTextStyles.caption.copyWith(color: AppColors.error),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.textSecondary, size: 20)
                : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.surfaceElevated,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.lg,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
              borderSide: BorderSide(
                color: AppColors.divider.withOpacity(0.5),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
