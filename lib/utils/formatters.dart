class Formatters {
  Formatters._();

  /// Formats amount to Indian Rupee format (e.g., 5000000.0 → "₹50,00,000").
  static String formatINR(double amount) {
    final intPart = amount.toInt().toString();
    if (intPart.length <= 3) return '₹$intPart';

    // Indian numbering: last 3 digits, then groups of 2
    final lastThree = intPart.substring(intPart.length - 3);
    final remaining = intPart.substring(0, intPart.length - 3);
    final remainingFormatted = _formatIndianRemaining(remaining);
    return '₹$remainingFormatted,$lastThree';
  }

  static String _formatIndianRemaining(String remaining) {
    if (remaining.isEmpty) return '';
    final reversed = remaining.split('').reversed.toList();
    final result = <String>[];
    for (int i = 0; i < reversed.length; i++) {
      if (i > 0 && i % 2 == 0) result.add(',');
      result.add(reversed[i]);
    }
    return result.reversed.join();
  }

  static String formatROI(double roi) {
    if (roi == roi.toInt().toDouble()) return '${roi.toInt()}%';
    return '${roi.toStringAsFixed(1)}%';
  }

  static String formatRiskLevel(String level) {
    switch (level.toLowerCase()) {
      case 'low':
        return 'Low';
      case 'medium':
        return 'Medium';
      case 'high':
        return 'High';
      default:
        return level;
    }
  }
}
