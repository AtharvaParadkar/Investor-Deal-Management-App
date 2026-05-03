import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized typography scale using Google Fonts (Inter).
/// All text styles reference [AppColors] for consistency.
class AppTextStyles {
  AppTextStyles._();

  /// Display — large headings (28px, bold)
  static TextStyle get display => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Heading — section titles (22px, semi-bold)
  static TextStyle get heading => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Subheading — subsection titles (16px, medium)
  static TextStyle get subheading => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  /// Body — regular content text (14px, regular)
  static TextStyle get body => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  /// Caption — small supporting text (12px, regular, secondary color)
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  /// Label — chips, badges, small labels (12px, semi-bold)
  static TextStyle get label => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );
}
