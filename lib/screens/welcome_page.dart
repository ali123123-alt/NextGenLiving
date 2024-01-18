import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextgenliving/screens/dashboardscreen.dart';
import 'package:nextgenliving/screens/homepage.dart';
import 'package:nextgenliving/screens/register_page.dart';
import 'package:nextgenliving/screens/signin_page.dart';
import '../constants/constants.dart';
import '../widgets/my_text_button.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (user != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    const Center(
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/logo.jpeg',
                        ),
                        radius: 100, //Text
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "NextGen Living.",
                      style: kHeadline,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextButton(
                        bgColor: Colors.white,
                        buttonName: 'Register',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                        },
                        textColor: Colors.black87,
                      ),
                    ),
                    Expanded(
                      child: MyTextButton(
                        bgColor: Colors.transparent,
                        buttonName: 'Sign In',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignInPage()));
                        },
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
