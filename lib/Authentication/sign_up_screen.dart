import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  // shared preference for store users data and show them to multiple screen

  late SharedPreferences sharedPreferences;

  Future<void> _saveUser(Users user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user.toJson()));
  }

  // For Image Pick From Gallery

  // Future getImageFromGallery() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     _image = image;
  //   });
  // }

  void _pickImageBase64() async {
    try {
      // pick image from gallery, change ImageSource.camera if you want to capture image from camera.
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      // read picked image byte data.
      Uint8List imagebytes = await image.readAsBytes();
      // using base64 encoder convert image into base64 string.
      String base64String = base64.encode(imagebytes);
      if (kDebugMode) {
        print(base64String);
      }

      final imageTemp = File(image.path);
      setState(() {
        _image =
            imageTemp; // setState to image the UI and show picked image on screen.
      });
    } on PlatformException {
      if (kDebugMode) {
        print('error');
      }
    }
  }

  final ImagePicker _picker = ImagePicker();
  File? _image;

  bool _passwordVisible = false;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  //for user already exits
  bool isUserExist = false;

  final db = DatabaseHelper();

  signUp() async {
    //to check if user exits
    bool usrExist = await db.checkUserExist(emailController.text);
    //If user exists, show the message
    if (usrExist) {
      setState(() {
        isUserExist = true;
      });
    } else {
      //otherwise create account
      var res = await db.signup(Users(
          userName: usernameController.text,
          userPassword: passwordController.text,
          userEmail: emailController.text,
          userPhoto: _image!.path));
      if (res > 0) {
        _pickImageBase64();
        await _saveUser(Users(
          userPassword: passwordController.text,
          userEmail: emailController.text,
          userName: usernameController.text,
          userPhoto: _image!.path,
        ));
        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()));
      }
    }
  }

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
                        _pickImageBase64();
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
                      signUp();
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
                  ),
                ),
                const SizedBox(
                  height: 15,
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
    );
  }
}
