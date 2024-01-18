import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:nextgenliving/screens/signin_page.dart';
import 'package:nextgenliving/screens/welcome_page.dart';
import '../auth_service.dart';
import '../constants/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisibility = true;
  bool isPasswordVisible = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String _email = "";
  String _password = "";
  bool isSignUpHovered = false;
  bool isSignInHovered = false;

  void _submitForm() {
    if (_formkey.currentState!.validate()) {
      final result = _authService.signUp(_email, _password);
      if (result != null) {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => WelcomePage(),
            ));
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
            colors: [Color(0xFF001F3F), Color(0xFF003366)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Register",
                              style: kHeadline.copyWith(color: Colors.white),
                            ),
                            Text(
                              "Create a new account to get started.",
                              style: kBodyText2.copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: 300,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
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
                                          labelText: 'Name',
                                          prefixIcon: const Icon(Icons.person, color: Colors.white),
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
                                            return 'Name is required';
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
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
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
                                      MouseRegion(
                                        onEnter: (_) => setState(() => isSignUpHovered = true),
                                        onExit: (_) => setState(() => isSignUpHovered = false),
                                        child: GestureDetector(
                                          onTap: _submitForm,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: isSignUpHovered
                                                  ? const LinearGradient(
                                                colors: [Color(0xFF16213e), Color(0xFF1a1a2e)],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              )
                                                  : const LinearGradient(
                                                colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1.0,
                                                style: BorderStyle.solid,
                                              ),
                                              borderRadius: BorderRadius.circular(15),
                                              boxShadow: isSignUpHovered
                                                  ? [
                                                BoxShadow(
                                                  color: Colors.blue.withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ]
                                                  : [],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'SignUp',
                                                style: TextStyle(
                                                  color: isSignUpHovered
                                                      ? Colors.blueAccent
                                                      : Colors.white,
                                                ),
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
                                            "Already have an account? ",
                                            style: kBodyText,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) => SignInPage(),
                                                ),
                                              );
                                            },
                                            child: MouseRegion(
                                              onEnter: (_) => setState(() => isSignInHovered = true),
                                              onExit: (_) => setState(() => isSignInHovered = false),
                                              child: Text(
                                                'Sign In',
                                                style: kBodyText.copyWith(
                                                  color: isSignInHovered ? Colors.limeAccent : Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
