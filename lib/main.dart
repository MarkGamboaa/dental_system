import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'constants/app_theme.dart';
import 'constants/app_constants.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/patients/patient_list_screen.dart';
import 'screens/appointments/appointment_list_screen.dart';
import 'screens/treatments/treatment_list_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() {
  runApp(const ToothWiseApp());
}

class ToothWiseApp extends StatelessWidget {
  const ToothWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: AppConstants.splashRoute,
  routes: [
    GoRoute(
      path: AppConstants.splashRoute,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppConstants.loginRoute,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppConstants.dashboardRoute,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: AppConstants.patientsRoute,
      builder: (context, state) => const PatientListScreen(),
    ),
    GoRoute(
      path: AppConstants.appointmentsRoute,
      builder: (context, state) => const AppointmentListScreen(),
    ),
    GoRoute(
      path: AppConstants.treatmentsRoute,
      builder: (context, state) => const TreatmentListScreen(),
    ),
    GoRoute(
      path: AppConstants.settingsRoute,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
