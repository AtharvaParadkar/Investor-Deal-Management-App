import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/deal_model.dart';
import '../model/filter_criteria_model.dart';
import '../repository/deal_repository.dart';
import 'deal_event.dart';
import 'deal_state.dart';

/// BLoC for managing deal list data and filter application.
/// Loads deals from the repository and applies filter criteria.
class DealBloc extends Bloc<DealEvent, DealState> {
  /// The deal repository for fetching deal data.
  final DealRepository _dealRepository;

  /// Stores all deals for filtering purposes.
  List<DealModel> _allDeals = [];

  /// Creates a [DealBloc] with the given [dealRepository].
  DealBloc({required DealRepository dealRepository})
      : _dealRepository = dealRepository,
        super(const DealsInitial()) {
    on<LoadDeals>(_onLoadDeals);
    on<RefreshDeals>(_onRefreshDeals);
  }

  /// Returns all loaded deals (used by FilterBloc).
  List<DealModel> get allDeals => _allDeals;

  /// Handles initial deal loading.
  Future<void> _onLoadDeals(
    LoadDeals event,
    Emitter<DealState> emit,
  ) async {
    emit(const DealsLoading());

    try {
      final deals = await _dealRepository.fetchDeals();
      _allDeals = deals;

      if (deals.isEmpty) {
        emit(const DealsEmpty());
      } else {
        emit(DealsLoaded(allDeals: deals, filteredDeals: deals));
      }
    } catch (e) {
      emit(DealsError('Failed to load deals: ${e.toString()}'));
    }
  }

  /// Handles pull-to-refresh.
  Future<void> _onRefreshDeals(
    RefreshDeals event,
    Emitter<DealState> emit,
  ) async {
    try {
      final deals = await _dealRepository.fetchDeals();
      _allDeals = deals;

      if (deals.isEmpty) {
        emit(const DealsEmpty());
      } else {
        emit(DealsLoaded(allDeals: deals, filteredDeals: deals));
      }
    } catch (e) {
      emit(DealsError('Failed to refresh deals: ${e.toString()}'));
    }
  }

  /// Applies filter criteria to the loaded deals and emits filtered state.
  void applyFilters(FilterCriteriaModel criteria) {
    if (_allDeals.isEmpty) return;

    final filtered = _applyFilters(_allDeals, criteria);
    // ignore: invalid_use_of_visible_for_testing_member
    emit(DealsLoaded(allDeals: _allDeals, filteredDeals: filtered));
  }

  /// Core filtering logic — matches deals against all active criteria.
  List<DealModel> _applyFilters(
    List<DealModel> allDeals,
    FilterCriteriaModel criteria,
  ) {
    return allDeals.where((deal) {
      final matchesSearch = deal.companyName
          .toLowerCase()
          .contains(criteria.searchQuery.toLowerCase());
      final matchesRisk = criteria.selectedRiskLevels.isEmpty ||
          criteria.selectedRiskLevels.contains(deal.riskLevel);
      final matchesROI = deal.expectedROI >= criteria.minROI &&
          deal.expectedROI <= criteria.maxROI;
      final matchesIndustry = criteria.selectedIndustries.isEmpty ||
          criteria.selectedIndustries.contains(deal.industry);
      return matchesSearch && matchesRisk && matchesROI && matchesIndustry;
    }).toList();
  }
}
