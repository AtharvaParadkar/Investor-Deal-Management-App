/// Shared helper utilities used across the application.
class Helpers {
  Helpers._();

  /// Calculates compound ROI projection values over a number of years.
  /// Base value is 100 (representing initial investment unit).
  /// Returns a list of values: [year0, year1, ..., yearN].
  ///
  /// Formula: value = 100 * (1 + roi/100)^year
  static List<double> calculateROIProjection(double roi, int years) {
    final projections = <double>[];
    for (int year = 0; year <= years; year++) {
      final value = 100 * _pow(1 + roi / 100, year);
      projections.add(double.parse(value.toStringAsFixed(2)));
    }
    return projections;
  }

  /// Simple power function for double base and int exponent.
  static double _pow(double base, int exponent) {
    double result = 1.0;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }
}
