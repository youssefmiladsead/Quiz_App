import 'package:flutter/material.dart';
import 'package:taskflutter/screens/category_screen.dart';
import 'package:taskflutter/screens/login_screen.dart';
import 'package:taskflutter/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'Palatino',
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/category': (context) => const CategoryScreen(),
      },
    );
  }
}
