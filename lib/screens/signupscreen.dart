import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_living1/screens/signinscreen.dart';
import 'package:nextgen_living1/screens/welcomescreen.dart';
import '../auth_service.dart';
import '../constants/constants.dart';
import '../utils/utils.dart';
import '../widgets/inputfield.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passwordVisibility = true;
  bool isPasswordVisible = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String _name = "";
  String _email = "";
  String _password = "";
  String _confirmpassword = "";
  bool isSignUpHovered = false;
  bool isSignInHovered = false;

  void _submitForm() async {
    if (_formkey.currentState!.validate()) {
      // Check if email is already registered
      bool isEmailRegistered = await _authService.isEmailRegistered(_email);
      if (isEmailRegistered) {
        Utils().toastMessage('Email is already registered');
        return;
      }
      final result = _authService.signUp(_name, _email, _password);
      if (result != null) {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => WelcomeScreen(),
            ));
      } else {
        Utils().toastMessage('Incorrect Email or Password');
        return;
      }
    } else {
      Utils().toastMessage('Please fill in all fields');
      return;
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
          icon: backarrow,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: gradient,
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
                                gradient: gradient1,
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
                                      InputField(
                                        labelText: 'Name',
                                        prefixIcon: Icons.person,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Name is required';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          _name = value;
                                          // Handle change
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InputField(
                                        labelText: 'Email',
                                        prefixIcon: Icons.email,
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
                                          // Handle change
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InputField(
                                        labelText: 'Password',
                                        prefixIcon: Icons.lock,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Password is required';
                                          }
                                          return null;
                                        },
                                        obscureText: false,
                                        onChanged: (value) {
                                          _password = value;
                                          // Handle change
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      InputField(
                                        labelText: 'Confirm password',
                                        prefixIcon: Icons.lock,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Password is required';
                                          } else if (_password !=
                                              _confirmpassword) {
                                            return "password and confirm password should match";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          _confirmpassword = value;
                                          // Handle change
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      MouseRegion(
                                        onEnter: (_) => setState(
                                            () => isSignUpHovered = true),
                                        onExit: (_) => setState(
                                            () => isSignUpHovered = false),
                                        child: GestureDetector(
                                          onTap: _submitForm,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: isSignUpHovered
                                                  ? gradient2
                                                  : gradient1,
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1.0,
                                                style: BorderStyle.solid,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: isSignUpHovered
                                                  ? [
                                                      BoxShadow(
                                                        color: Colors.blue
                                                            .withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 4,
                                                        offset:
                                                            const Offset(0, 2),
                                                      ),
                                                    ]
                                                  : [],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                  builder: (context) =>
                                                      SignInScreen(),
                                                ),
                                              );
                                            },
                                            child: MouseRegion(
                                              onEnter: (_) => setState(
                                                  () => isSignInHovered = true),
                                              onExit: (_) => setState(() =>
                                                  isSignInHovered = false),
                                              child: Text(
                                                'Sign In',
                                                style: kBodyText.copyWith(
                                                  color: isSignInHovered
                                                      ? Colors.limeAccent
                                                      : Colors.red,
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
