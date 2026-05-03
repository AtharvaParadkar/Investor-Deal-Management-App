/// Enum representing the risk level of a deal.
enum RiskLevel {
  /// Low risk investment
  low,

  /// Medium risk investment
  medium,

  /// High risk investment
  high,
}

/// Enum representing the current status of a deal.
enum DealStatus {
  /// Deal is currently accepting investors
  open,

  /// Deal is no longer accepting investors
  closed,
}

/// Core data model for an investment deal.
/// Contains all financial and descriptive information about a deal.
class DealModel {
  /// Unique identifier for the deal.
  final String id;

  /// Name of the company offering the deal.
  final String companyName;

  /// Industry sector (e.g., FinTech, HealthTech).
  final String industry;

  /// Total investment amount required in INR.
  final double investmentRequired;

  /// Expected return on investment as a percentage.
  final double expectedROI;

  /// Risk classification of the deal.
  final RiskLevel riskLevel;

  /// Current status of the deal (open/closed).
  final DealStatus status;

  /// Detailed description of the deal.
  final String description;

  /// Current funding stage (Seed, Series A, Series B, etc.).
  final String fundingStage;

  /// Minimum investment ticket size in INR.
  final double minimumTicketSize;

  /// List of identified risk factors.
  final List<String> riskFactors;

  /// Creates a [DealModel] with the required fields.
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
