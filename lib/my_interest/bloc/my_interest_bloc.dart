import 'package:flutter_bloc/flutter_bloc.dart';
import '../../deals/repository/deal_repository.dart';
import '../repository/my_interest_repository.dart';
import 'my_interest_event.dart';
import 'my_interest_state.dart';

/// BLoC for managing user's deal interests.
/// Handles loading, adding, removing, and checking interest status.
class MyInterestBloc extends Bloc<MyInterestEvent, MyInterestState> {
  /// Repository for interest persistence.
  final MyInterestRepository _interestRepository;

  /// Repository for fetching deal data to match IDs to full models.
  final DealRepository _dealRepository;

  /// Creates a [MyInterestBloc] with the required repositories.
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

  /// Loads all interests and matches them to deal data.
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

      final allDeals = await _dealRepository.fetchDeals();
      final interestedDeals = allDeals
          .where((deal) => ids.contains(deal.id))
          .toList();

      if (interestedDeals.isEmpty) {
        emit(const MyInterestsEmpty());
      } else {
        emit(MyInterestsLoaded(
          deals: interestedDeals,
          interestedDealIds: ids,
        ));
      }
    } catch (e) {
      emit(const MyInterestsEmpty());
    }
  }

  /// Adds interest for a deal and emits toggled state.
  Future<void> _onAddInterest(
    AddInterest event,
    Emitter<MyInterestState> emit,
  ) async {
    await _interestRepository.addInterest(event.dealId);
    emit(InterestToggled(dealId: event.dealId, isInterested: true));
  }

  /// Removes interest from a deal and emits toggled state.
  Future<void> _onRemoveInterest(
    RemoveInterest event,
    Emitter<MyInterestState> emit,
  ) async {
    await _interestRepository.removeInterest(event.dealId);
    emit(InterestToggled(dealId: event.dealId, isInterested: false));
  }

  /// Checks if the user is interested in a specific deal.
  Future<void> _onCheckInterestStatus(
    CheckInterestStatus event,
    Emitter<MyInterestState> emit,
  ) async {
    final isInterested = await _interestRepository.isInterested(event.dealId);
    emit(InterestToggled(dealId: event.dealId, isInterested: isInterested));
  }
}
