import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_living1/screens/signupscreen.dart';
import '../auth_service.dart';
import '../constants/constants.dart';
import '../utils/utils.dart';
import '../widgets/inputfield.dart';
import 'dashboardscreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // bool isPasswordVisible = true;
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
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
      } else {
        Utils().toastMessage('Incorrect Email or Password');
        return;
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
          icon: backarrow,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: gradient,
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
                                              ? [
                                                  const Color(0xFF16213e),
                                                  const Color(0xFF1a1a2e)
                                                ]
                                              : [
                                                  const Color(0xFF1a1a2e),
                                                  const Color(0xFF16213e)
                                                ],
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
                                                  color: Colors.blue
                                                      .withOpacity(0.5),
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
                                              builder: (context) =>
                                                  SignUpScreen(),
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
                                              color: isRegisterButtonHovered
                                                  ? Colors.limeAccent
                                                  : Colors.red,
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
