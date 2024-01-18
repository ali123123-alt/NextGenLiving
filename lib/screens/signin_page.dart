import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextgenliving/screens/dashboardscreen.dart';
import 'package:nextgenliving/screens/homepage.dart';
import 'package:nextgenliving/screens/register_page.dart';
import '../auth_service.dart';
import '../constants/constants.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isPasswordVisible = true;
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  bool isLoginButtonClicked = false;
  bool isRegisterButtonHovered = false;

  void _submitForm() {
    if (_formkey.currentState!.validate()) {
      final result = _authService.signIn(_email, _password);
      if (result != null) {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>
                    const DashboardScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF005b96), Color(0xFF001F3F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome back.",
                          style: kHeadline,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF000948), Color(0xFF003366)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    style: kBodyText.copyWith(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                                      labelStyle: kBodyText,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Email is required';
                                      } else if (!value.contains('@')) {
                                        return 'Enter a valid email address';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      _email = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                                      labelStyle: kBodyText,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password is required';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      _password = value;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isLoginButtonClicked = true;
                                      });
                                      _submitForm();
                                    },
                                    onHover: (hover) {
                                      setState(() {
                                        isLoginButtonClicked = hover;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: isLoginButtonClicked
                                              ? [const Color(0xFF16213e), const Color(0xFF1a1a2e)]
                                              : [const Color(0xFF1a1a2e), const Color(0xFF16213e)],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                        borderRadius: BorderRadius.circular(55),
                                        boxShadow: isLoginButtonClicked
                                            ? [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]
                                            : [],
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Don't have an account? ",
                                        style: kBodyText,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => RegisterPage(),
                                            ),
                                          );
                                        },
                                        child: MouseRegion(
                                          onEnter: (_) {
                                            setState(() {
                                              isRegisterButtonHovered = true;
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              isRegisterButtonHovered = false;
                                            });
                                          },
                                          child: Text(
                                            'Register',
                                            style: kBodyText.copyWith(
                                              color: isRegisterButtonHovered ? Colors.limeAccent : Colors.red,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
