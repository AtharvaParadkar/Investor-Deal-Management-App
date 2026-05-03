import 'deal_model.dart';

class FilterCriteriaModel {
  final String searchQuery;
  final double minROI;
  final double maxROI;
  final List<RiskLevel> selectedRiskLevels;
  final List<String> selectedIndustries;

  const FilterCriteriaModel({
    this.searchQuery = '',
    this.minROI = 0,
    this.maxROI = 50,
    this.selectedRiskLevels = const [],
    this.selectedIndustries = const [],
  });

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

  bool get hasActiveFilters =>
      searchQuery.isNotEmpty ||
      minROI > 0 ||
      maxROI < 50 ||
      selectedRiskLevels.isNotEmpty ||
      selectedIndustries.isNotEmpty;

  int get activeFilterCount {
    int count = 0;
    if (minROI > 0 || maxROI < 50) count++;
    if (selectedRiskLevels.isNotEmpty) count++;
    if (selectedIndustries.isNotEmpty) count++;
    return count;
  }
}
