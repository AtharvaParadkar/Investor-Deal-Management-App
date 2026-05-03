import 'package:equatable/equatable.dart';
import '../model/deal_model.dart';

/// Base class for all filter-related events.
abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when the search query text changes (debounced 300ms).
class SearchQueryChanged extends FilterEvent {
  /// The new search query string.
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

/// Triggered when the ROI range slider is moved.
class ROIRangeChanged extends FilterEvent {
  /// Minimum ROI percentage.
  final double min;

  /// Maximum ROI percentage.
  final double max;

  const ROIRangeChanged(this.min, this.max);

  @override
  List<Object?> get props => [min, max];
}

/// Triggered when a risk level chip is toggled.
class RiskLevelToggled extends FilterEvent {
  /// The risk level being toggled.
  final RiskLevel level;

  const RiskLevelToggled(this.level);

  @override
  List<Object?> get props => [level];
}

/// Triggered when an industry chip is selected/deselected.
class IndustryToggled extends FilterEvent {
  /// The industry name being toggled.
  final String industry;

  const IndustryToggled(this.industry);

  @override
  List<Object?> get props => [industry];
}

/// Triggered to reset all filters to defaults.
class FiltersCleared extends FilterEvent {
  const FiltersCleared();
}
