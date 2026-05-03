/// All user-facing strings are centralized here.
/// No inline strings should be used in UI files.
class AppStrings {
  AppStrings._();

  // General
  static const String appName = 'Investor Deal Management';
  static const String appTagline = 'Smart Investments, Simplified';

  // Login
  static const String loginTitle = 'Welcome Back';
  static const String loginSubtitle = 'Sign in to manage your deals';
  static const String emailHint = 'Email address';
  static const String passwordHint = 'Password';
  static const String loginButton = 'Sign In';
  static const String invalidCredentials = 'Invalid email or password';
  static const String emailRequired = 'Email is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordRequired = 'Password is required';
  static const String passwordTooShort = 'Password must be at least 6 characters';

  // Deals
  static const String deals = 'Deals';
  static const String searchDeals = 'Search deals...';
  static const String filterDeals = 'Filter Deals';
  static const String allDeals = 'All Deals';
  static const String noDealFound = 'No deals found';
  static const String noDealsMatchFilter = 'No deals match your filters. Try adjusting your criteria.';
  static const String errorLoadingDeals = 'Failed to load deals. Please try again.';
  static const String retry = 'Retry';
  static const String investmentRequired = 'Investment Required';
  static const String expectedROI = 'Expected ROI';
  static const String fundingStage = 'Funding Stage';
  static const String minimumTicket = 'Min. Ticket Size';
  static const String companyOverview = 'Company Overview';
  static const String financialHighlights = 'Financial Highlights';
  static const String roiProjection = 'ROI Projection (5 Years)';
  static const String riskAnalysis = 'Risk Analysis';
  static const String riskFactors = 'Risk Factors';

  // Filters
  static const String applyFilters = 'Apply';
  static const String clearAll = 'Clear All';
  static const String roiRange = 'ROI Range';
  static const String riskLevel = 'Risk Level';
  static const String industry = 'Industry';

  // My Interests
  static const String myInterests = 'My Interests';
  static const String imInterested = "I'm Interested";
  static const String removeInterest = 'Remove Interest';
  static const String dealClosed = 'Deal Closed';
  static const String noInterestsYet = 'No interests yet.\nStart exploring deals!';
  static const String interestAdded = 'Interest added successfully!';
  static const String interestRemoved = 'Interest removed';
  static const String exploreDeals = 'Explore Deals';

  // Navigation
  static const String navDeals = 'Deals';
  static const String navMyInterests = 'My Interests';

  // General
  static const String logout = 'Logout';
  static const String logoutConfirm = 'Are you sure you want to logout?';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
}
