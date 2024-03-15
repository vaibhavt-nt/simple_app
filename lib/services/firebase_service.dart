import 'package:firebase_auth/firebase_auth.dart';

class FireBaseHelper {
  static FirebaseAuth fire = FirebaseAuth.instance;
  static Future<String> signInWithEmailPassword(
      String email, String password) async {
    try{
      await fire.signInWithEmailAndPassword(email: email, password: password);
      return 'Success';
    }catch(e){
      return 'fail';
    }
  }
}
