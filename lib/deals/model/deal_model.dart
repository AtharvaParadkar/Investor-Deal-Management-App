enum RiskLevel { low, medium, high }

enum DealStatus { open, closed }

class DealModel {
  final String id;
  final String companyName;
  final String industry;
  final double investmentRequired;
  final double expectedROI;
  final RiskLevel riskLevel;
  final DealStatus status;
  final String description;
  final String fundingStage;
  final double minimumTicketSize;
  final List<String> riskFactors;

  const DealModel({
    required this.id,
    required this.companyName,
    required this.industry,
    required this.investmentRequired,
    required this.expectedROI,
    required this.riskLevel,
    required this.status,
    required this.description,
    required this.fundingStage,
    required this.minimumTicketSize,
    required this.riskFactors,
  });
}
