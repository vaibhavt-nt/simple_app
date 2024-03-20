import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/authentication_screens/login_screen.dart';
import 'package:simple_app/services/firebase_service/firebase_authentication.dart';
import 'package:simple_app/services/image_picker_service.dart';
import 'package:simple_app/services/sq_lite_service/sqlite.dart';
import 'package:simple_app/services/validations.dart';

import '../navigation_screen/bottom_navigation_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
//for storing image in firebase storage
  final firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser;
  get data => null;

  late SharedPreferences sharedPreferences;

  File? _image;

  bool _passwordVisible = false;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  //for user already exits
  bool isUserExist = false;
  bool _isLoading = false;

  final db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 60.0),
                      Text("Signup",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.w600),
                          )),
                      const SizedBox(height: 30.0),
                      // select profile photo from gallary or camera
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select Image'),
                                content: const Text('Choose an option'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Gallery'),
                                    onPressed: () {
                                      PickImage.pickImageFromGallery((image) {
                                        if (image != null) {
                                          setState(() {
                                            _image = image;
                                          });
                                        }
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Camera'),
                                    onPressed: () {
                                      PickImage.pickImageFromCamera((image) {
                                        if (image != null) {
                                          setState(() {
                                            _image = image;
                                          });
                                        }
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Center(
                          child: _image == null
                              ? SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CircleAvatar(
                                    child: SvgPicture.asset(
                                        'assets/sign_up_images/image_picker_empty.svg'),
                                  ),
                                )
                              : ClipOval(
                                  child: Image.file(
                                    File(_image!.path),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Add your profile photo",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name",
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                            const Gap(),
                            TextFormField(
                              controller: usernameController,
                              validator: Validation.validateName,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 10.0),
                                hintText: "Enter your name",
                                hintStyle: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFEE4D86))),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        const Gap(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email",
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                            const Gap(),
                            TextFormField(
                              validator: Validation.validateEmail,
                              controller: emailController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 10.0),
                                hintText: "Enter your email",
                                hintStyle: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFEE4D86))),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        const Gap(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Password",
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                            const Gap(),
                            TextFormField(
                              validator: Validation.validatePassword,
                              obscureText: !_passwordVisible,
                              controller: passwordController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 10.0),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0xFFEE4D86),
                                  ),
                                ),
                                hintText: "Enter your password",
                                hintStyle: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFEE4D86))),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 43.5,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate() &&
                                    _image != null) {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  // Show a loading indicator while the image is being uploaded and the user is being registered

                                  var imageName = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  var storageRef = FirebaseStorage.instance
                                      .ref()
                                      .child('post_images/$imageName.jpg');
                                  var uploadTask = storageRef.putFile(_image!);
                                  var downloadUrl = await (await uploadTask)
                                      .ref
                                      .getDownloadURL();
                                  try {
                                    User? user = await FirebaseAuthentication
                                        .registerUsingEmailPassword(
                                            name: usernameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            photo: downloadUrl);
                                    if (user != null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Registration successful'),
                                            content: const Text(
                                                'User registered successfully'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BottomNavigationBarScreen(),
                                          ));
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'email-already-in-use') {
                                      // Show an AlertDialog instead of a SnackBar
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Error'),
                                            content: const Text(
                                                'The email address is already in use by another account.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }

                                  // Dismiss the loading indicator and show the AlertDialog

                                  setState(() {
                                    _isLoading = false;
                                  });
                                } else if (_image == null) {
                                  // Show an AlertDialog instead of a SnackBar
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'Please select a profile photo'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: _isLoading
                                ? Colors.grey
                                : const Color(0xFFEE4D86)),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text("Signup",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  //Message when there is a duplicate user

                  //By default we hide the message
                  isUserExist
                      ? const Center(
                          child: Text(
                          "User already exists, please enter another name",
                          style: TextStyle(color: Colors.red),
                        ))
                      : const SizedBox(),

                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?",
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            )),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ));
                          },
                          child: Text("Login",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Color(0xFFEE4D86),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
