import 'package:equatable/equatable.dart';

/// Base class for all my interest events.
abstract class MyInterestEvent extends Equatable {
  const MyInterestEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered to load all saved interests.
class LoadMyInterests extends MyInterestEvent {
  const LoadMyInterests();
}

/// Triggered when the user expresses interest in a deal.
class AddInterest extends MyInterestEvent {
  /// The deal ID to add interest for.
  final String dealId;

  const AddInterest(this.dealId);

  @override
  List<Object?> get props => [dealId];
}

/// Triggered when the user removes interest from a deal.
class RemoveInterest extends MyInterestEvent {
  /// The deal ID to remove interest for.
  final String dealId;

  const RemoveInterest(this.dealId);

  @override
  List<Object?> get props => [dealId];
}

/// Triggered to check interest status for a specific deal.
class CheckInterestStatus extends MyInterestEvent {
  /// The deal ID to check.
  final String dealId;

  const CheckInterestStatus(this.dealId);

  @override
  List<Object?> get props => [dealId];
}
