import 'package:equatable/equatable.dart';
import '../model/filter_criteria_model.dart';

/// State for the filter BLoC, wrapping the current filter criteria.
class FilterState extends Equatable {
  /// The current filter criteria.
  final FilterCriteriaModel criteria;

  /// Creates a [FilterState] with the given [criteria].
  const FilterState({
    this.criteria = const FilterCriteriaModel(),
  });

  /// Creates a copy of this state with updated criteria.
  FilterState copyWith({FilterCriteriaModel? criteria}) {
    return FilterState(criteria: criteria ?? this.criteria);
  }

  @override
  List<Object?> get props => [criteria.searchQuery, criteria.minROI,
    criteria.maxROI, criteria.selectedRiskLevels, criteria.selectedIndustries];
}
