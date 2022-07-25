
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ده class اللي هيربط الابليكيشن ب firebase فبنقول لو هيدخل من signup احفظ كل البيانات ما عدا اتنين هستخدمهم علطول من user اللي هما email و password
class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<UserCredential> signIn(String email,String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

 /* Future<User> getUser() async{
   return await _auth.currentUser();
  }  */

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
