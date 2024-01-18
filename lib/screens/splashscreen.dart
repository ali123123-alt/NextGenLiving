import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nextgenliving/screens/welcome_page.dart';

import '../constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => WelcomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [Color(0xFF001F3F), Color(0xFF003366)],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          color: Color(0x00018aa3)
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/logo.jpeg',
                ),
                radius: 100, //Text
              ),
              SizedBox(height: 20.0),
              Text(
                "NextGen Living.",
                style: kHeadline,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
