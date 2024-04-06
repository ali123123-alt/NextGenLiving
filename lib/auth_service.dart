import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nextgen_living1/utils/utils.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isEmailRegistered(String email) async {
    QuerySnapshot query = await _firestore
        .collection('user')
        .where('email', isEqualTo: email)
        .get();

    return query.docs.isNotEmpty;
  }

  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  //sing in with email & password
  Future signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Utils().toastMessage(e.toString());
      return null;
    }
  }

  Future signUp(String name, String email, String password) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String? uid = authResult.user?.uid;
      await _firestore.collection('user').doc(uid).set({
        'name': name,
        'email': email,
        'password': password,
        'uid': uid,
      });
      return;
    } catch (e) {
      Utils().toastMessage(e.toString());
      return null;
    }
  }
}
