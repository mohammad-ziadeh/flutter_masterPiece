import 'package:flutter/material.dart';
import 'pages/login.dart';
// import 'pages/signup.dart';
import 'pages/attendance.dart';
import 'pages/students.dart';
import 'splash_screen.dart';
import 'pages/mainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMC (Learning Management Center)',

      // ----- {{ Light Theme }} ----- //
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3B1E54),
          iconTheme: IconThemeData(color: Color(0xFFeeeeee)),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF3B1E54),
          selectedItemColor: Color(0xFFeeeeee),
          unselectedItemColor: Colors.white70,
        ),
        iconTheme: const IconThemeData(color: Color(0xFF3B1E54)),
        primaryIconTheme: const IconThemeData(color: Color(0xFF3B1E54)),
      ),
      // ----- {{ End Light Theme }} ----- //

      // ----- {{ Dark Theme }} ----- //
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 24, 12, 33),
          iconTheme: IconThemeData(color: Color(0xFFeeeeee)),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 10, 5, 13),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 24, 12, 33),
          selectedItemColor: Color(0xFFeeeeee),
          unselectedItemColor: Colors.white70,
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 121, 60, 174),
        ),
        primaryIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 121, 60, 174),
        ),
        cardColor: const Color(0xFF3B1E54),
      ),

      // ----- {{ End Dark Theme }} ----- //
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => Login(),
        '/home': (context) => MainPage(onToggleTheme: _toggleTheme),
        '/attendance': (context) => Attendance(),
        '/students': (context) => StudentsPage(onToggleTheme: _toggleTheme),
      },
    );
  }
}
