import '../model/filter_criteria_model.dart';

class FilterState {
  final FilterCriteriaModel criteria;

  const FilterState({this.criteria = const FilterCriteriaModel()});

  FilterState copyWith({FilterCriteriaModel? criteria}) {
    return FilterState(criteria: criteria ?? this.criteria);
  }
}
