import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'dashboard_page.dart'; // Buat file ini di tahap berikutnya

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Performance Monitoring App',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(), // Placeholder
      },
    );
  }
}
