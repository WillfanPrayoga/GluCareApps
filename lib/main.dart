import 'package:flutter/material.dart';
// Import semua halaman agar bisa dikenali oleh rute
import 'package:glucare/screens/splash_screen.dart';
import 'package:glucare/screens/login_screen.dart';
import 'package:glucare/screens/register_screen.dart';
import 'package:glucare/screens/dashboard_screen.dart';
import 'package:glucare/screens/analysis_screen.dart';
import 'package:glucare/screens/clinical_mode_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GluCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        // Mengatur font default aplikasi agar lebih rapi
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // HALAMAN PERTAMA: Splash Screen yang ada logonya
      initialRoute: '/splash',

      // DAFTAR ALAMAT HALAMAN (Routes)
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/analysis': (context) => const AnalysisScreen(),
        '/clinical-mode': (context) => const ClinicalModeScreen(),
      },
    );
  }
}
