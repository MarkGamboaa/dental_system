class AppConstants {
  // App Info
  static const String appName = 'ToothWise';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Professional Dental Clinic Management';
  
  // Routes
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String patientsRoute = '/patients';
  static const String appointmentsRoute = '/appointments';
  static const String treatmentsRoute = '/treatments';
  static const String billingRoute = '/billing';
  static const String settingsRoute = '/settings';
  
  // Bottom Navigation
  static const List<String> bottomNavItems = [
    'Dashboard',
    'Patients',
    'Appointments',
    'Treatments',
    'Settings',
  ];
  
  // Treatment Types
  static const List<String> treatmentTypes = [
    'Consultation',
    'Cleaning',
    'Filling',
    'Root Canal',
    'Crown',
    'Bridge',
    'Extraction',
    'Implant',
    'Orthodontics',
    'Whitening',
    'Dentures',
    'Oral Surgery',
  ];
  
  // Appointment Types
  static const List<String> appointmentTypes = [
    'Consultation',
    'Check-up',
    'Treatment',
    'Follow-up',
    'Emergency',
    'Surgery',
  ];
  
  // Appointment Statuses
  static const List<String> appointmentStatuses = [
    'Scheduled',
    'Confirmed',
    'In Progress',
    'Completed',
    'Cancelled',
    'No Show',
    'Rescheduled',
  ];
  
  // Patient Priority Levels
  static const List<String> priorityLevels = [
    'Low',
    'Medium',
    'High',
    'Urgent',
  ];
  
  // Time Slots (in minutes)
  static const List<int> appointmentDurations = [
    15, 30, 45, 60, 90, 120, 180
  ];
  
  // Business Hours
  static const Map<String, Map<String, String>> businessHours = {
    'Monday': {'open': '09:00', 'close': '18:00'},
    'Tuesday': {'open': '09:00', 'close': '18:00'},
    'Wednesday': {'open': '09:00', 'close': '18:00'},
    'Thursday': {'open': '09:00', 'close': '18:00'},
    'Friday': {'open': '09:00', 'close': '17:00'},
    'Saturday': {'open': '09:00', 'close': '14:00'},
    'Sunday': {'open': 'Closed', 'close': 'Closed'},
  };
  
  // Payment Methods (Philippines)
  static const List<String> paymentMethods = [
    'Cash',
    'Credit Card',
    'Debit Card',
    'GCash',
    'PayMaya',
    'Bank Transfer',
    'Installment',
    'PhilHealth',
    'HMO',
  ];
  
  // Insurance Providers (Philippines)
  static const List<String> insuranceProviders = [
    'PhilHealth',
    'Maxicare',
    'Medicard',
    'Intellicare',
    'Caritas Health Shield',
    'Kaiser International',
    'Avega Managed Care',
    'Asian Life',
    'Other',
  ];
  
  // Tooth Numbers (International System)
  static const List<int> toothNumbers = [
    11, 12, 13, 14, 15, 16, 17, 18, // Upper right
    21, 22, 23, 24, 25, 26, 27, 28, // Upper left
    31, 32, 33, 34, 35, 36, 37, 38, // Lower left
    41, 42, 43, 44, 45, 46, 47, 48, // Lower right
  ];
  
  // Common Dental Conditions
  static const List<String> dentalConditions = [
    'Caries',
    'Gingivitis',
    'Periodontitis',
    'Tooth Sensitivity',
    'Bruxism',
    'TMJ Disorder',
    'Oral Cancer',
    'Bad Breath',
    'Tooth Loss',
    'Malocclusion',
  ];
  
  // API Endpoints (for future backend integration)
  static const String baseUrl = 'https://api.toothwise.com/v1';
  
  // SharedPreferences Keys
  static const String isLoggedInKey = 'isLoggedIn';
  static const String userDataKey = 'userData';
  static const String clinicDataKey = 'clinicData';
  static const String settingsKey = 'settings';
}