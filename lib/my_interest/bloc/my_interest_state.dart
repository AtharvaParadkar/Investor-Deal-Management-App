import 'package:equatable/equatable.dart';
import '../../deals/model/deal_model.dart';

/// Base class for all my interest states.
abstract class MyInterestState extends Equatable {
  const MyInterestState();

  @override
  List<Object?> get props => [];
}

/// Default initial state.
class MyInterestsInitial extends MyInterestState {
  const MyInterestsInitial();
}

/// State while interests are being loaded.
class MyInterestsLoading extends MyInterestState {
  const MyInterestsLoading();
}

/// State when interests are successfully loaded.
class MyInterestsLoaded extends MyInterestState {
  /// The list of deal models the user is interested in.
  final List<DealModel> deals;

  /// The raw list of interested deal IDs for quick lookup.
  final List<String> interestedDealIds;

  const MyInterestsLoaded({
    required this.deals,
    required this.interestedDealIds,
  });

  @override
  List<Object?> get props => [deals, interestedDealIds];
}

/// State when the user has no interests saved.
class MyInterestsEmpty extends MyInterestState {
  const MyInterestsEmpty();
}

/// State after toggling interest on a specific deal.
class InterestToggled extends MyInterestState {
  /// The deal ID that was toggled.
  final String dealId;

  /// Whether the deal is now interested (true) or not (false).
  final bool isInterested;

  const InterestToggled({
    required this.dealId,
    required this.isInterested,
  });

  @override
  List<Object?> get props => [dealId, isInterested];
}
