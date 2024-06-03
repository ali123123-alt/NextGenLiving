import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_living1/screens/signinscreen.dart';
import 'package:nextgen_living1/screens/welcomescreen.dart';
import '../auth_service.dart';
import '../constants/constants.dart';
import '../utils/utils.dart';
import '../widgets/appbar.dart';
import '../widgets/inputfield.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _name = "";
  String _password = "";
  bool isSignUpHovered = false;
  bool isSignInHovered = false;
  Map<String, dynamic>? userData;
  final AuthService _authService = AuthService();
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    fetchUserDetails(user!.uid);
  }

  Future<void> fetchUserDetails(String uid) async {
    final userRef = FirebaseFirestore.instance.collection('user').doc(uid);
    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      setState(() {
        userData = userSnapshot.data();
        _password = userData?['password'];
        _name = userData?['name'];
      });
      print(userData);
      print(_password);
      print(_name);
    } else {
      print('User document does not exist');
    }
  }

  void _submitForm() async {
    // if (_formkey.currentState!.validate()) {
    // Check if email is already registered
    // bool isEmailRegistered = await _authService.isEmailRegistered(_email);
    // if (isEmailRegistered) {
    //   Utils().toastMessage('Email is already registered');
    //   return;
    // }
    // final result = _authService.signUp(_name, _email, _password);
    //   if (result != null) {
    //     Navigator.push(
    //         context,
    //         CupertinoPageRoute(
    //           builder: (context) => WelcomeScreen(),
    //         ));
    //   } else {
    //     Utils().toastMessage('Incorrect Email or Password');
    //     return;
    //   }
    // } else {
    //   Utils().toastMessage('Please fill in all fields');
    //   return;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComp(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: gradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 165, 255, 137),
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ), //Text
              ),
              const SizedBox(height: 20),
              Padding(
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
                      MouseRegion(
                        onEnter: (_) => setState(() => isSignUpHovered = true),
                        onExit: (_) => setState(() => isSignUpHovered = false),
                        child: GestureDetector(
                          onTap: _submitForm,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: isSignUpHovered ? gradient2 : gradient1,
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
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                            child: MouseRegion(
                              onEnter: (_) =>
                                  setState(() => isSignInHovered = true),
                              onExit: (_) =>
                                  setState(() => isSignInHovered = false),
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
            ],
          ),
        ),
      ),
    );
  }
}
