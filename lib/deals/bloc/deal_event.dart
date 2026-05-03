abstract class DealEvent {
  const DealEvent();
}

class LoadDeals extends DealEvent {
  const LoadDeals();
}

class RefreshDeals extends DealEvent {
  const RefreshDeals();
}

class ApplyFilteredDeals extends DealEvent {
  final List<dynamic> filteredDeals;
  const ApplyFilteredDeals(this.filteredDeals);
}
