import '../model/deal_model.dart';

abstract class DealState {
  const DealState();
}

class DealsInitial extends DealState {
  const DealsInitial();
}

class DealsLoading extends DealState {
  const DealsLoading();
}

class DealsLoaded extends DealState {
  final List<DealModel> allDeals;
  final List<DealModel> filteredDeals;

  const DealsLoaded({required this.allDeals, required this.filteredDeals});
}

class DealsError extends DealState {
  final String message;
  const DealsError(this.message);
}

class DealsEmpty extends DealState {
  const DealsEmpty();
}
