import '../model/deal_model.dart';

/// Repository for deal data operations.
/// Contains hardcoded mock deals and simulates network latency.
class DealRepository {
  /// Hardcoded list of 12 mock deals covering diverse industries and risk levels.
  static const List<DealModel> _mockDeals = [
    DealModel(
      id: 'deal_001',
      companyName: 'PayFlow Solutions',
      industry: 'FinTech',
      investmentRequired: 50000000,
      expectedROI: 22.5,
      riskLevel: RiskLevel.medium,
      status: DealStatus.open,
      description:
          'PayFlow is building a next-gen UPI-based payment gateway for SMEs. '
          'With 10,000+ merchants already onboarded and a 40% month-over-month growth, '
          'PayFlow is targeting ₹100Cr GMV by end of FY26. The platform reduces payment '
          'processing costs by 60% compared to traditional gateways.',
      fundingStage: 'Series A',
      minimumTicketSize: 5000000,
      riskFactors: [
        'Regulatory changes in UPI ecosystem',
        'High competition from established players',
        'Dependency on merchant acquisition rate',
      ],
    ),
    DealModel(
      id: 'deal_002',
      companyName: 'GreenGrid Energy',
      industry: 'CleanTech',
      investmentRequired: 120000000,
      expectedROI: 18.0,
      riskLevel: RiskLevel.low,
      status: DealStatus.open,
      description:
          'GreenGrid is deploying modular solar microgrids across Tier 2 and Tier 3 '
          'cities in India. With government subsidies and a proven technology stack, '
          'the company has installed 500+ microgrids serving 50,000 households. '
          'Revenue model includes energy sales and carbon credit monetization.',
      fundingStage: 'Series B',
      minimumTicketSize: 10000000,
      riskFactors: [
        'Weather-dependent energy generation',
        'Policy and subsidy changes',
        'Infrastructure scaling challenges',
      ],
    ),
    DealModel(
      id: 'deal_003',
      companyName: 'MediScan AI',
      industry: 'HealthTech',
      investmentRequired: 30000000,
      expectedROI: 35.0,
      riskLevel: RiskLevel.high,
      status: DealStatus.open,
      description:
          'MediScan uses deep learning to detect early-stage cancers from routine '
          'diagnostic scans with 97% accuracy. Currently partnered with 15 hospitals '
          'and processing 5,000+ scans monthly. The AI model has received provisional '
          'FDA approval for breast cancer screening.',
      fundingStage: 'Seed',
      minimumTicketSize: 2500000,
      riskFactors: [
        'Regulatory approval delays in multiple markets',
        'Data privacy and HIPAA compliance costs',
        'Model accuracy liability concerns',
        'Long sales cycles with hospitals',
      ],
    ),
    DealModel(
      id: 'deal_004',
      companyName: 'LearnVerse',
      industry: 'EdTech',
      investmentRequired: 25000000,
      expectedROI: 28.0,
      riskLevel: RiskLevel.medium,
      status: DealStatus.open,
      description:
          'LearnVerse is an immersive AR/VR learning platform for K-12 STEM education. '
          'With 200+ schools onboarded and 50,000 active students, the platform has '
          'shown 3x improvement in test scores. Revenue comes from B2B school licenses '
          'and B2C parent subscriptions.',
      fundingStage: 'Series A',
      minimumTicketSize: 2000000,
      riskFactors: [
        'Hardware dependency for VR experience',
        'School budget constraints post-pandemic',
        'Content localization costs across regions',
      ],
    ),
    DealModel(
      id: 'deal_005',
      companyName: 'AgriYield',
      industry: 'AgriTech',
      investmentRequired: 40000000,
      expectedROI: 15.0,
      riskLevel: RiskLevel.low,
      status: DealStatus.open,
      description:
          'AgriYield provides precision agriculture solutions using satellite imagery '
          'and IoT sensors to optimize crop yields. Currently serving 10,000+ farmers '
          'across Maharashtra and Karnataka. The platform has demonstrated 30% yield '
          'improvement and 20% water savings on average.',
      fundingStage: 'Series A',
      minimumTicketSize: 3000000,
      riskFactors: [
        'Farmer adoption and digital literacy',
        'Monsoon and climate variability',
        'Government policy on agri-tech subsidies',
      ],
    ),
    DealModel(
      id: 'deal_006',
      companyName: 'CryptoLedger',
      industry: 'FinTech',
      investmentRequired: 80000000,
      expectedROI: 40.0,
      riskLevel: RiskLevel.high,
      status: DealStatus.open,
      description:
          'CryptoLedger is building a compliant institutional-grade crypto custody and '
          'trading platform for the Indian market. With RBI sandbox approval and '
          'partnerships with 3 major banks, the platform handles ₹50Cr+ in daily volume. '
          'Revenue model includes trading fees and custody charges.',
      fundingStage: 'Series B',
      minimumTicketSize: 10000000,
      riskFactors: [
        'Crypto regulation uncertainty in India',
        'Market volatility and liquidity risks',
        'Cybersecurity and custody insurance costs',
        'Competition from global exchanges',
      ],
    ),
    DealModel(
      id: 'deal_007',
      companyName: 'NutriGenome',
      industry: 'HealthTech',
      investmentRequired: 18000000,
      expectedROI: 25.0,
      riskLevel: RiskLevel.medium,
      status: DealStatus.closed,
      description:
          'NutriGenome offers DNA-based personalized nutrition plans using proprietary '
          'genomic analysis. With 25,000 test kits sold and a 40% repeat rate, the company '
          'is expanding into corporate wellness programs. Partnerships with 5 major gym '
          'chains are in progress.',
      fundingStage: 'Seed',
      minimumTicketSize: 1500000,
      riskFactors: [
        'Consumer trust in genomic data sharing',
        'Regulatory framework for genomic testing',
        'High customer acquisition cost',
      ],
    ),
    DealModel(
      id: 'deal_008',
      companyName: 'SkillForge',
      industry: 'EdTech',
      investmentRequired: 15000000,
      expectedROI: 20.0,
      riskLevel: RiskLevel.low,
      status: DealStatus.open,
      description:
          'SkillForge is a B2B upskilling platform focused on AI and data science training '
          'for enterprise teams. Currently serving 50+ enterprises including 3 Fortune 500 '
          'companies. The platform features AI-generated personalized learning paths and '
          'real-time project-based assessments.',
      fundingStage: 'Series A',
      minimumTicketSize: 1000000,
      riskFactors: [
        'Enterprise sales cycle length',
        'Competition from established MOOC platforms',
        'AI content quality maintenance',
      ],
    ),
    DealModel(
      id: 'deal_009',
      companyName: 'DroneHarvest',
      industry: 'AgriTech',
      investmentRequired: 60000000,
      expectedROI: 12.0,
      riskLevel: RiskLevel.medium,
      status: DealStatus.closed,
      description:
          'DroneHarvest provides autonomous drone-based crop monitoring and spraying '
          'services. Operating in 5 states with a fleet of 200+ drones, the company '
          'serves 25,000 acres monthly. The DaaS (Drone-as-a-Service) model ensures '
          'recurring revenue with 85% gross margins.',
      fundingStage: 'Series A',
      minimumTicketSize: 5000000,
      riskFactors: [
        'DGCA drone regulation compliance',
        'Fleet maintenance and insurance costs',
        'Seasonal demand fluctuations',
      ],
    ),
    DealModel(
      id: 'deal_010',
      companyName: 'SolarVault',
      industry: 'CleanTech',
      investmentRequired: 200000000,
      expectedROI: 14.0,
      riskLevel: RiskLevel.low,
      status: DealStatus.open,
      description:
          'SolarVault is developing next-gen solid-state batteries for residential solar '
          'storage. With 2 patents filed and a pilot program in 100 homes, the technology '
          'offers 3x energy density compared to lithium-ion alternatives. Strategic '
          'partnership with Tata Power for distribution.',
      fundingStage: 'Series B',
      minimumTicketSize: 15000000,
      riskFactors: [
        'Technology commercialization timeline',
        'Raw material supply chain risks',
        'Competition from lithium-ion improvements',
      ],
    ),
    DealModel(
      id: 'deal_011',
      companyName: 'InsureBot',
      industry: 'FinTech',
      investmentRequired: 35000000,
      expectedROI: 30.0,
      riskLevel: RiskLevel.medium,
      status: DealStatus.open,
      description:
          'InsureBot is an AI-driven insurance underwriting and claims processing platform. '
          'Partnered with 8 insurance companies, the platform reduces claim settlement time '
          'from 30 days to 48 hours. Processing 10,000+ claims monthly with 95% accuracy.',
      fundingStage: 'Series A',
      minimumTicketSize: 3000000,
      riskFactors: [
        'IRDAI regulatory compliance evolution',
        'AI model bias in underwriting',
        'Insurance partner concentration risk',
      ],
    ),
    DealModel(
      id: 'deal_012',
      companyName: 'EduPlay',
      industry: 'EdTech',
      investmentRequired: 8000000,
      expectedROI: 32.0,
      riskLevel: RiskLevel.high,
      status: DealStatus.open,
      description:
          'EduPlay is a gamified early-childhood learning app targeting ages 3-8. With '
          '500,000 downloads and 100,000 monthly active users, the app uses adaptive AI '
          'to personalize learning journeys. Revenue from freemium subscriptions and '
          'in-app content packs.',
      fundingStage: 'Seed',
      minimumTicketSize: 500000,
      riskFactors: [
        'Screen time concerns from parents',
        'App store policy changes affecting discovery',
        'High user acquisition costs in competitive market',
        'Content creation and moderation at scale',
      ],
    ),
  ];

  /// Fetches all available deals with simulated network latency.
  Future<List<DealModel>> fetchDeals() async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 1500));
    return _mockDeals;
  }

  /// Fetches a single deal by its ID.
  Future<DealModel?> getDealById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockDeals.firstWhere((deal) => deal.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Returns a list of all unique industries across deals.
  List<String> getAvailableIndustries() {
    return _mockDeals.map((d) => d.industry).toSet().toList()..sort();
  }
}
