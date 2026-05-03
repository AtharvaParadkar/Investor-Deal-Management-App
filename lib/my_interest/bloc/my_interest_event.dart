abstract class MyInterestEvent {
  const MyInterestEvent();
}

class LoadMyInterests extends MyInterestEvent {
  const LoadMyInterests();
}

class AddInterest extends MyInterestEvent {
  final String dealId;
  const AddInterest(this.dealId);
}

class RemoveInterest extends MyInterestEvent {
  final String dealId;
  const RemoveInterest(this.dealId);
}

class CheckInterestStatus extends MyInterestEvent {
  final String dealId;
  const CheckInterestStatus(this.dealId);
}
