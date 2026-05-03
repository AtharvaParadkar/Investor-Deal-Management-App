import 'deal_model.dart';

/// Model representing the active filter criteria for deal search.
/// Used by [FilterBloc] to determine which deals to display.
class FilterCriteriaModel {
  /// Text search query for company name.
  final String searchQuery;

  /// Minimum expected ROI percentage.
  final double minROI;

  /// Maximum expected ROI percentage.
  final double maxROI;

  /// Selected risk levels to filter by. Empty means no filter.
  final List<RiskLevel> selectedRiskLevels;

  /// Selected industries to filter by. Empty means no filter.
  final List<String> selectedIndustries;

  /// Creates a [FilterCriteriaModel] with optional filter values.
  /// Defaults to no active filters.
  const FilterCriteriaModel({
    this.searchQuery = '',
    this.minROI = 0,
    this.maxROI = 50,
    this.selectedRiskLevels = const [],
    this.selectedIndustries = const [],
  });

  /// Creates a copy of this model with the given overrides.
  FilterCriteriaModel copyWith({
    String? searchQuery,
    double? minROI,
    double? maxROI,
    List<RiskLevel>? selectedRiskLevels,
    List<String>? selectedIndustries,
  }) {
    return FilterCriteriaModel(
      searchQuery: searchQuery ?? this.searchQuery,
      minROI: minROI ?? this.minROI,
      maxROI: maxROI ?? this.maxROI,
      selectedRiskLevels: selectedRiskLevels ?? this.selectedRiskLevels,
      selectedIndustries: selectedIndustries ?? this.selectedIndustries,
    );
  }

  /// Whether any filter is currently active.
  bool get hasActiveFilters =>
      searchQuery.isNotEmpty ||
      minROI > 0 ||
      maxROI < 50 ||
      selectedRiskLevels.isNotEmpty ||
      selectedIndustries.isNotEmpty;

  /// Returns the count of active filter categories.
  int get activeFilterCount {
    int count = 0;
    if (minROI > 0 || maxROI < 50) count++;
    if (selectedRiskLevels.isNotEmpty) count++;
    if (selectedIndustries.isNotEmpty) count++;
    return count;
  }
}
