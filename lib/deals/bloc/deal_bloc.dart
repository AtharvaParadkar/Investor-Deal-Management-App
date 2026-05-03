import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/deal_model.dart';
import '../model/filter_criteria_model.dart';
import '../repository/deal_repository.dart';
import 'deal_event.dart';
import 'deal_state.dart';

class DealBloc extends Bloc<DealEvent, DealState> {
  final DealRepository _dealRepository;
  List<DealModel> _allDeals = [];

  DealBloc({required DealRepository dealRepository})
      : _dealRepository = dealRepository,
        super(const DealsInitial()) {
    on<LoadDeals>(_onLoadDeals);
    on<RefreshDeals>(_onRefreshDeals);
  }

  List<DealModel> get allDeals => _allDeals;

  Future<void> _onLoadDeals(LoadDeals event, Emitter<DealState> emit) async {
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

  /// Called by FilterBloc to re-emit filtered deal list.
  void applyFilters(FilterCriteriaModel criteria) {
    if (_allDeals.isEmpty) return;
    final filtered = _allDeals.where((deal) {
      final matchesSearch = deal.companyName
          .toLowerCase()
          .contains(criteria.searchQuery.toLowerCase());
      final matchesRisk = criteria.selectedRiskLevels.isEmpty ||
          criteria.selectedRiskLevels.contains(deal.riskLevel);
      final matchesROI =
          deal.expectedROI >= criteria.minROI && deal.expectedROI <= criteria.maxROI;
      final matchesIndustry = criteria.selectedIndustries.isEmpty ||
          criteria.selectedIndustries.contains(deal.industry);
      return matchesSearch && matchesRisk && matchesROI && matchesIndustry;
    }).toList();
    // ignore: invalid_use_of_visible_for_testing_member
    emit(DealsLoaded(allDeals: _allDeals, filteredDeals: filtered));
  }
}
