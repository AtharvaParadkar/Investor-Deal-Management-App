/// Model representing a user's interest in a specific deal.
/// Stores the deal ID and the timestamp when interest was expressed.
class MyInterestModel {
  /// The ID of the deal the user is interested in.
  final String dealId;

  /// When the interest was added.
  final DateTime addedAt;

  /// Creates a [MyInterestModel].
  const MyInterestModel({
    required this.dealId,
    required this.addedAt,
  });

  /// Creates from JSON map.
  factory MyInterestModel.fromJson(Map<String, dynamic> json) {
    return MyInterestModel(
      dealId: json['dealId'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  /// Converts to JSON map for storage.
  Map<String, dynamic> toJson() {
    return {
      'dealId': dealId,
      'addedAt': addedAt.toIso8601String(),
    };
  }
}
