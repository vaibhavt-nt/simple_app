import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthentication {
  // For registering a new user
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String photo,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    Completer<User?> completer = Completer<User?>();

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.updatePhotoURL(photo);
      await user.reload();

      user = auth.currentUser;
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'name': name,
        'email': email,
        'photo': photo,
      });

      completer.complete(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The email address is already in use by another account.');
        }
        Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        completer.completeError(e);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      completer.completeError(e);
    }

    return completer.future;
  }

  // For signing in an user (have already registered)
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided.');
      } else {
        debugPrint('FirebaseAuthException: ${e.code} ${e.message}');
      }
    } catch (e) {
      debugPrint('Exception: $e');
    }
    return null;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  //SIGN OUT METHOD
  static Future signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    if (kDebugMode) {
      print('sign out');
    }
  }

  Future<void> sendVerificationEmail(emailAddress) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(email: emailAddress);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<User?> updateUser({
    required String name,
    required String photo,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      try {
        // Update user information in Firebase Authentication
        await user.updateDisplayName(name);
        await user.updatePhotoURL(photo);

        // Update user information in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'name': name,
          'photo': photo,
        });

        return user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          debugPrint('No user found for that email.');
        } else if (e.code == 'email-already-in-use') {
          debugPrint('The email address is already in use by another account.');
        } else {
          debugPrint('FirebaseAuthException: ${e.code} ${e.message}');
        }
      } catch (e) {
        debugPrint('Exception: $e');
      }
    }

    return null;
  }
}
