class MyInterestModel {
  final String dealId;
  final DateTime addedAt;

  const MyInterestModel({required this.dealId, required this.addedAt});

  factory MyInterestModel.fromJson(Map<String, dynamic> json) {
    return MyInterestModel(
      dealId: json['dealId'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'dealId': dealId,
        'addedAt': addedAt.toIso8601String(),
      };
}
