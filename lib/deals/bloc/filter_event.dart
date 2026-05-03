import '../model/deal_model.dart';

abstract class FilterEvent {
  const FilterEvent();
}

class SearchQueryChanged extends FilterEvent {
  final String query;
  const SearchQueryChanged(this.query);
}

class ROIRangeChanged extends FilterEvent {
  final double min;
  final double max;
  const ROIRangeChanged(this.min, this.max);
}

class RiskLevelToggled extends FilterEvent {
  final RiskLevel level;
  const RiskLevelToggled(this.level);
}

class IndustryToggled extends FilterEvent {
  final String industry;
  const IndustryToggled(this.industry);
}

class FiltersCleared extends FilterEvent {
  const FiltersCleared();
}
