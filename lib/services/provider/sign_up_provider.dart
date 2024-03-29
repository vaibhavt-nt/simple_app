import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/screens/navigation_screen/bottom_navigation_screen.dart';

class SignUpProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signUp(String name, String email, String password, File image,
      BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Sign up with email and password
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Upload profile image to Firebase Storage
      String imagePath = '${userCredential.user!.uid}/profile_image.jpg';
      TaskSnapshot uploadTask =
          await _firebaseStorage.ref(imagePath).putFile(image);
      String downloadUrl = await uploadTask.ref.getDownloadURL();

      // Save user data to Firebase Firestore
      await _firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'profile_image_url': downloadUrl,
      });

      // Navigate to the home screen
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationBarScreen(),
        ),
      );
    } catch (e) {
      // Handle error
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          // Show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('The email address is already in use')),
          );
        }
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
