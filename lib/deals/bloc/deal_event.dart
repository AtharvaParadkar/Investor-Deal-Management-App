import 'package:equatable/equatable.dart';

/// Base class for all deal-related events.
abstract class DealEvent extends Equatable {
  const DealEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered to load deals for the first time.
class LoadDeals extends DealEvent {
  const LoadDeals();
}

/// Triggered to refresh the deal list (pull-to-refresh).
class RefreshDeals extends DealEvent {
  const RefreshDeals();
}

/// Triggered by FilterBloc to apply filtered results.
class ApplyFilteredDeals extends DealEvent {
  /// The filtered list of deals.
  final List<dynamic> filteredDeals;

  const ApplyFilteredDeals(this.filteredDeals);

  @override
  List<Object?> get props => [filteredDeals];
}
