import 'package:equatable/equatable.dart';
import '../model/deal_model.dart';

/// Base class for all deal-related states.
abstract class DealState extends Equatable {
  const DealState();

  @override
  List<Object?> get props => [];
}

/// Default state before first load.
class DealsInitial extends DealState {
  const DealsInitial();
}

/// State while deals are being fetched.
class DealsLoading extends DealState {
  const DealsLoading();
}

/// State when deals are successfully loaded.
class DealsLoaded extends DealState {
  /// The complete unfiltered list of deals.
  final List<DealModel> allDeals;

  /// The currently displayed (filtered) list of deals.
  final List<DealModel> filteredDeals;

  const DealsLoaded({
    required this.allDeals,
    required this.filteredDeals,
  });

  @override
  List<Object?> get props => [allDeals, filteredDeals];
}

/// State when deal fetching fails.
class DealsError extends DealState {
  /// Error message.
  final String message;

  const DealsError(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when the data source returned no deals.
class DealsEmpty extends DealState {
  const DealsEmpty();
}
