import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/analysis_screen.dart';
import 'screens/clinical_mode_screen.dart';
import 'screens/recommendation_screen.dart';
import 'screens/analysis_result_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/progres_screen.dart';

void main() {
  runApp(const GluCareApp());
}

class GluCareApp extends StatelessWidget {
  const GluCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF007BFF);

    return MaterialApp(
      title: 'GluCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: mainBlue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: mainBlue,
          primary: mainBlue,
        ),
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/analysis': (context) => const AnalysisScreen(),
        '/clinical-mode': (context) => const ClinicalModeScreen(),
        '/recommendation': (context) => const RecommendationScreen(),
        '/analysis-result': (context) => const AnalysisResultScreen(),
        '/progres': (context) => const ProgresScreen(),
      },
    );
  }
}
