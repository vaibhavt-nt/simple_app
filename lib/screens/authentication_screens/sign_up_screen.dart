import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/custom_widgets/custom_texfeild.dart';
import 'package:simple_app/screens/authentication_screens/login_screen.dart';
import 'package:simple_app/screens/navigation_screen/bottom_navigation_screen.dart';
import 'package:simple_app/services/firebase_service/firebase_authentication.dart';
import 'package:simple_app/services/image_picker_service.dart';
import 'package:simple_app/services/sq_lite_service/sqlite.dart';
import 'package:simple_app/services/validations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
//for storing image in firebase storage
  final firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser;

  File? _image;

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
            padding: EdgeInsets.all(15.0.sp),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 60.0.r),
                      Text("Signup",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 32.r,
                                fontWeight: FontWeight.w600),
                          )),
                      SizedBox(height: 30.0.w),
                      // select profile photo from gallary or camera
                      SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: GestureDetector(
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
                                    height: 100.h,
                                    width: 100.w,
                                    child: SvgPicture.asset(
                                        'assets/sign_up_images/empty_signup_image.svg'),
                                  )
                                : ClipOval(
                                    child: Image.file(
                                      File(_image!.path),
                                      width: 100.w,
                                      height: 100.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.r,
                      ),
                      Text("Add your profile photo",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16.r,
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text("Name",
                                  textAlign: TextAlign.left,
                                  textDirection: TextDirection.ltr,
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.r,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            const Gap(),
                            NameEmailInputField(
                              controller: usernameController,
                              validator: (value) =>
                                  Validation.validateName(value),
                              enterText: 'Enter your name',
                            ),
                          ],
                        ),
                        Gap(
                          height: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text("Email",
                                  textAlign: TextAlign.left,
                                  textDirection: TextDirection.ltr,
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.r,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            const Gap(),
                            NameEmailInputField(
                              controller: emailController,
                              validator: (value) =>
                                  Validation.validateEmail(value),
                              enterText: 'Enter your email',
                            ),
                          ],
                        ),
                        Gap(
                          height: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text("Password",
                                  textAlign: TextAlign.left,
                                  textDirection: TextDirection.ltr,
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.r,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            const Gap(),
                            PasswordInputField(
                              passwordController: passwordController,
                              validator: (value) =>
                                  Validation.validatePassword(value),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.w),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.r),
                    child: SizedBox(
                      height: 40.h,
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
                                    if (!context.mounted) return;
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
                                                BottomNavigationBarScreen(),
                                          ));
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'email-already-in-use') {
                                      // Show an AlertDialog instead of a SnackBar
                                    }
                                  }
                                  // Dismiss the loading indicator and show the AlertDialog

                                  setState(() {
                                    _isLoading = false;
                                  });
                                } else if (_image == null) {
                                  // Show an AlertDialog instead of a SnackBar
                                  Fluttertoast.showToast(
                                      msg: "Please Select a Profile Photo",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            backgroundColor: _isLoading
                                ? Colors.grey
                                : const Color(0xFFEE4D86)),
                        child: _isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text("Signup",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.r,
                                      fontWeight: FontWeight.w600),
                                )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account?",
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16.r,
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
                              textStyle: TextStyle(
                                  color: CustomColors.pink,
                                  fontSize: 16.r,
                                  fontWeight: FontWeight.w600),
                            )),
                      )
                    ],
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
