import 'package:ecardio/Routes.dart';
import 'package:ecardio/SplashScreen.dart';
import 'package:ecardio/view/AppointmentPage.dart';
import 'package:ecardio/view/BottomNavigationBar.dart';
import 'package:ecardio/view/HomePage.dart';
import 'package:ecardio/view/RegisterPage.dart';
import 'package:flutter/material.dart';
import './view/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        Routes.loginScreen:((context) => LoginPage()),
        Routes.signUpScreen:((context) => Register()),
        Routes.homePage:((context) => HomePage()),
        Routes.appointment:(context) => AppointmentPage(),
        Routes.bottomNavbar:(context) => BottomNavBar(),

      },
    );
  }
}
