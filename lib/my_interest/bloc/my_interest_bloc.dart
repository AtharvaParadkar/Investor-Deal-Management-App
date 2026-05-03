import 'package:flutter_bloc/flutter_bloc.dart';
import '../../deals/repository/deal_repository.dart';
import '../repository/my_interest_repository.dart';
import 'my_interest_event.dart';
import 'my_interest_state.dart';

class MyInterestBloc extends Bloc<MyInterestEvent, MyInterestState> {
  final MyInterestRepository _interestRepository;
  final DealRepository _dealRepository;

  MyInterestBloc({
    required MyInterestRepository interestRepository,
    required DealRepository dealRepository,
  })  : _interestRepository = interestRepository,
        _dealRepository = dealRepository,
        super(const MyInterestsInitial()) {
    on<LoadMyInterests>(_onLoadMyInterests);
    on<AddInterest>(_onAddInterest);
    on<RemoveInterest>(_onRemoveInterest);
    on<CheckInterestStatus>(_onCheckInterestStatus);
  }

  Future<void> _onLoadMyInterests(
    LoadMyInterests event,
    Emitter<MyInterestState> emit,
  ) async {
    emit(const MyInterestsLoading());
    try {
      final ids = await _interestRepository.getInterestedDealIds();
      if (ids.isEmpty) {
        emit(const MyInterestsEmpty());
        return;
      }
      // Match saved IDs to full deal models
      final allDeals = await _dealRepository.fetchDeals();
      final interestedDeals =
          allDeals.where((deal) => ids.contains(deal.id)).toList();
      if (interestedDeals.isEmpty) {
        emit(const MyInterestsEmpty());
      } else {
        emit(MyInterestsLoaded(deals: interestedDeals, interestedDealIds: ids));
      }
    } catch (e) {
      emit(const MyInterestsEmpty());
    }
  }

  Future<void> _onAddInterest(
    AddInterest event,
    Emitter<MyInterestState> emit,
  ) async {
    await _interestRepository.addInterest(event.dealId);
    emit(InterestToggled(dealId: event.dealId, isInterested: true));
  }

  Future<void> _onRemoveInterest(
    RemoveInterest event,
    Emitter<MyInterestState> emit,
  ) async {
    await _interestRepository.removeInterest(event.dealId);
    emit(InterestToggled(dealId: event.dealId, isInterested: false));
  }

  Future<void> _onCheckInterestStatus(
    CheckInterestStatus event,
    Emitter<MyInterestState> emit,
  ) async {
    final isInterested = await _interestRepository.isInterested(event.dealId);
    emit(InterestToggled(dealId: event.dealId, isInterested: isInterested));
  }
}
