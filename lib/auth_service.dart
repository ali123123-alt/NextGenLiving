import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future signInAnonymously() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    }catch(e){
      return null;
    }
  }

  //sing in with email & password
  Future signIn(String email, String password) async{
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signUp(String email, String password) async{
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}