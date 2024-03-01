import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_app/Authentication/login_screen.dart';
import 'package:simple_app/SQLite/sqlite.dart';
import 'package:simple_app/jsonModels/users.dart';
import 'package:simple_app/onboarding_screen/onboarding_screen1.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // For Image Pick From Gallery

  Future getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  bool _passwordVisible = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                    GestureDetector(
                      onTap: () {
                        getImageFromGallery();
                      },
                      child: Center(
                        child: _image == null
                            ? SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  child: Image.asset(
                                      'assets/sign_up_images/image_picker.png'),
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 300),
                            child: Text("Name",
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          SizedBox(
                            height: 70,
                            child: TextFormField(
                              controller: usernameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "username is required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 305),
                            child: Text("Email",
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          SizedBox(
                            height: 70,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "email is required";
                                }
                                return null;
                              },
                              controller: emailController,
                              decoration: InputDecoration(
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 270),
                            child: Text("Password",
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          SizedBox(
                            height: 70,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "password is required";
                                }
                                return null;
                              },
                              obscureText: !_passwordVisible,
                              controller: passwordController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          //Login method will be here

                          final db = DatabaseHelper();
                          db
                              .signup(Users(
                                  userName: emailController.text,
                                  userPassword: passwordController.text))
                              .whenComplete(() {
                            //After success user creation go to login screen
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OnboardingScreen()));
                          });
                        }
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => OnboardingScreen(),
                        //     ));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: const Color(0xFFEE4D86)),
                      child: Text("Signup",
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
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
    );
  }
}
