import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/deal_model.dart';
import '../model/filter_criteria_model.dart';
import 'deal_bloc.dart';
import 'filter_event.dart';
import 'filter_state.dart';

/// BLoC for managing filter criteria and communicating with [DealBloc].
/// Processes filter changes and triggers deal list re-filtering.
class FilterBloc extends Bloc<FilterEvent, FilterState> {
  /// Reference to the DealBloc for applying filters.
  final DealBloc _dealBloc;

  /// Creates a [FilterBloc] linked to the given [dealBloc].
  FilterBloc({required DealBloc dealBloc})
      : _dealBloc = dealBloc,
        super(const FilterState()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<ROIRangeChanged>(_onROIRangeChanged);
    on<RiskLevelToggled>(_onRiskLevelToggled);
    on<IndustryToggled>(_onIndustryToggled);
    on<FiltersCleared>(_onFiltersCleared);
  }

  /// Handles search query changes.
  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<FilterState> emit,
  ) {
    final newCriteria = state.criteria.copyWith(searchQuery: event.query);
    emit(state.copyWith(criteria: newCriteria));
    _dealBloc.applyFilters(newCriteria);
  }

  /// Handles ROI range slider changes.
  void _onROIRangeChanged(
    ROIRangeChanged event,
    Emitter<FilterState> emit,
  ) {
    final newCriteria = state.criteria.copyWith(
      minROI: event.min,
      maxROI: event.max,
    );
    emit(state.copyWith(criteria: newCriteria));
    _dealBloc.applyFilters(newCriteria);
  }

  /// Handles risk level chip toggle.
  void _onRiskLevelToggled(
    RiskLevelToggled event,
    Emitter<FilterState> emit,
  ) {
    final currentLevels = List<RiskLevel>.from(state.criteria.selectedRiskLevels);
    if (currentLevels.contains(event.level)) {
      currentLevels.remove(event.level);
    } else {
      currentLevels.add(event.level);
    }
    final newCriteria = state.criteria.copyWith(
      selectedRiskLevels: currentLevels,
    );
    emit(state.copyWith(criteria: newCriteria));
    _dealBloc.applyFilters(newCriteria);
  }

  /// Handles industry chip toggle.
  void _onIndustryToggled(
    IndustryToggled event,
    Emitter<FilterState> emit,
  ) {
    final currentIndustries =
        List<String>.from(state.criteria.selectedIndustries);
    if (currentIndustries.contains(event.industry)) {
      currentIndustries.remove(event.industry);
    } else {
      currentIndustries.add(event.industry);
    }
    final newCriteria = state.criteria.copyWith(
      selectedIndustries: currentIndustries,
    );
    emit(state.copyWith(criteria: newCriteria));
    _dealBloc.applyFilters(newCriteria);
  }

  /// Handles clearing all filters.
  void _onFiltersCleared(
    FiltersCleared event,
    Emitter<FilterState> emit,
  ) {
    const newCriteria = FilterCriteriaModel();
    emit(const FilterState());
    _dealBloc.applyFilters(newCriteria);
  }
}
