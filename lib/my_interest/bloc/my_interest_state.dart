import '../../deals/model/deal_model.dart';

abstract class MyInterestState {
  const MyInterestState();
}

class MyInterestsInitial extends MyInterestState {
  const MyInterestsInitial();
}

class MyInterestsLoading extends MyInterestState {
  const MyInterestsLoading();
}

class MyInterestsLoaded extends MyInterestState {
  final List<DealModel> deals;
  final List<String> interestedDealIds;

  const MyInterestsLoaded({
    required this.deals,
    required this.interestedDealIds,
  });
}

class MyInterestsEmpty extends MyInterestState {
  const MyInterestsEmpty();
}

class InterestToggled extends MyInterestState {
  final String dealId;
  final bool isInterested;

  const InterestToggled({required this.dealId, required this.isInterested});
}
