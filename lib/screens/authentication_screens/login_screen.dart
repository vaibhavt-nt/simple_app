// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/authentication_screens/forgot_password_screen.dart';
import 'package:simple_app/screens/authentication_screens/sign_up_screen.dart';
import 'package:simple_app/screens/navigation_screen/bottom_navigation_screen.dart';
import 'package:simple_app/services/firebase_service/firebase_authentication.dart';
import 'package:simple_app/services/sq_lite_service/sqlite.dart';
import 'package:simple_app/services/validations.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisible = false;

  //for validation
  final _formKey = GlobalKey<FormState>();

  final db = DatabaseHelper();

  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        final result = await FirebaseAuthentication.signInUsingEmailPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (result != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const BottomNavigationBarScreen(),
            ),
          );
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text('Login successful'),
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
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text('username or password is wrong'),
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
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
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
        } else if (e.code == 'too-many-requests') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'We have blocked all requests from this device due to unusual activity. Try again later.'),
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
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 SizedBox(
                  height: 100.h,
                ),
                _header(context),
                Gap(
                  height: 50.h,
                ),
                _inputField(context),
                 Gap(
                  height: 100.h,
                ),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Text("Login",
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
              color: Colors.black, fontSize: 32.r, fontWeight: FontWeight.w600),
        ));
  }

  _inputField(context) {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.r,
                          fontWeight: FontWeight.w500),
                    )),
                const Gap(),
                CupertinoTextFormFieldRow(
                  decoration:  BoxDecoration(
                    border: Border.all(width: 1,  color: Colors.grey),
                   borderRadius: BorderRadius.circular(5)
                  ),
                  validator: (value) => Validation.validateEmail(value),
                  placeholder: 'Enter your email',
                  placeholderStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: CupertinoColors.systemGrey,
                        fontSize: 16.r, fontWeight: FontWeight.w400),
                  ),
                  autofillHints: const [AutofillHints.email],
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  padding: EdgeInsets.symmetric(
                      vertical: 4.0.h, horizontal: 10.0.w),
                ),
              ],
            ),
            Gap(
              height: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Password",
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.r,
                          fontWeight: FontWeight.w500),
                    )),
                const Gap(),
                CupertinoTextFormFieldRow(
                  decoration:  BoxDecoration(
                      border: Border.all(width: 1,  color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  validator: (value) => Validation.validateEmail(value),
                  placeholder: 'Enter your email',
                  placeholderStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 16.r, fontWeight: FontWeight.w400),
                  ),
                  autofillHints: const [AutofillHints.email],
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  padding: EdgeInsets.symmetric(
                      vertical: 4.0.h, horizontal: 10.0.w),
                ),
                TextFormField(
                  autofillHints: const [AutofillHints.password],
                  validator: Validation.validatePassword,
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    contentPadding:  EdgeInsets.symmetric(
                        vertical: 4.0.h, horizontal: 10.0.w),
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
                      textStyle: TextStyle(
                          fontSize: 16.r, fontWeight: FontWeight.w400),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEE4D86))),
                    border: const OutlineInputBorder(),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordScreen(),
                          ));
                    },
                    child: Text("Forgot Password?",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.r,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70.w),
            SizedBox(
              height: 43.h,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding:  EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor:
                        _isLoading ? Colors.grey : const Color(0xFFEE4D86)),
                child: _isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "Login",
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.r,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _signup(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account?",
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
                    builder: (context) => const SignUpScreen(),
                  ));
            },
            child: Text("Signup",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: const Color(0xFFEE4D86),
                      fontSize: 16.r,
                      fontWeight: FontWeight.w600),
                )),
          )
        ],
      ),
    );
  }
}
