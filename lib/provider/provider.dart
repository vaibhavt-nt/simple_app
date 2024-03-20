import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_app/screens/authentication_screens/login_screen.dart';

class UiProvider extends ChangeNotifier {
  final bool _isChecked = false;
  bool get isChecked => _isChecked;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  late SharedPreferences storage;

  //Method to check and uncheck remember me
  // we need to do it using Provider state management

  //When login is successful, then we will true the value to remember our login session
  setRememberMe() {
    _rememberMe = true;

    //We store the value in secure storage to be remembered
    storage.setBool("rememberMe", _rememberMe);
    notifyListeners();
  }

  //Set rememberMe value to false
  logout(context) {
    FirebaseAuth.instance.signOut();
    _rememberMe = false;
    storage.setBool("rememberMe", _rememberMe);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
    notifyListeners();
  }

  //Init Secure Storage
  initStorage() async {
    storage = await SharedPreferences.getInstance();
    _rememberMe = storage.getBool("rememberMe") ?? false;
    notifyListeners();
  }

// Login is not showing now, because we checked the remember
// now we must logout
}
