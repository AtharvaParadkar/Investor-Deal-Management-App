import 'package:flutter/material.dart';

/// Centralized color palette for the entire application.
/// Uses a dark fintech theme with accent greens and golds.
class AppColors {
  AppColors._();

  /// Main background color — deep dark
  static const Color background = Color(0xFF0D1117);

  /// Card / surface color
  static const Color surface = Color(0xFF161B22);

  /// Elevated surface (modals, bottom sheets)
  static const Color surfaceElevated = Color(0xFF21262D);

  /// Primary brand color — vibrant green
  static const Color primary = Color(0xFF00C896);

  /// Lighter variant of primary
  static const Color primaryLight = Color(0xFF00E5A8);

  /// Gold accent for highlights
  static const Color gold = Color(0xFFFFD700);

  /// Primary text color on dark backgrounds
  static const Color textPrimary = Color(0xFFE6EDF3);

  /// Secondary / muted text
  static const Color textSecondary = Color(0xFF8B949E);

  /// Divider / border color
  static const Color divider = Color(0xFF21262D);

  /// Risk level: Low — green
  static const Color riskLow = Color(0xFF3FB950);

  /// Risk level: Medium — amber
  static const Color riskMedium = Color(0xFFD29922);

  /// Risk level: High — red
  static const Color riskHigh = Color(0xFFF85149);

  /// Deal status: Open — green
  static const Color statusOpen = Color(0xFF238636);

  /// Deal status: Closed — grey
  static const Color statusClosed = Color(0xFF6E7681);

  /// Error / destructive actions
  static const Color error = Color(0xFFF85149);

  /// White for contrast
  static const Color white = Color(0xFFFFFFFF);

  /// Transparent
  static const Color transparent = Colors.transparent;
}
