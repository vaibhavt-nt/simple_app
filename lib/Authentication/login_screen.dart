import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/services/firebase_service.dart';
import 'package:simple_app/Authentication/forgot_password_screen.dart';
import 'package:simple_app/Navigation/bnb_screen.dart';
import 'package:simple_app/SQLite/sqlite.dart';
import 'package:simple_app/Authentication/sign_up_screen.dart';

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

  final formkey = GlobalKey<FormState>();

  final db = DatabaseHelper();

  bool isLoginTrue = false;

  // this is for firebase login with email and password
  // logIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text, password: passwordController.text);
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const NavigationScreen(),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                ),
                _header(context),
                isLoginTrue
                    ? const Text(
                        "Username or password is incorrect",
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                _inputField(context),
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
          textStyle: const TextStyle(
              color: Colors.black, fontSize: 32, fontWeight: FontWeight.w600),
        ));
  }

  _inputField(context) {
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEE4D86))),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
              SizedBox(
                height: 70,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password is required";
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: !_passwordVisible,
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
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEE4D86))),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ));
              },
              child: Text("Forgot Password?",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )),
            ),
          ),
          const SizedBox(height: 70),
          ElevatedButton(
            onPressed: () async {
              final result = await FireBaseHelper.signInWithEmailPassword(
                  emailController.text, passwordController.text);
              if (result == 'Success') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const BNBScreen()));
              } else {
              debugPrint('Fail to login');}
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: const Color(0xFFEE4D86)),
            child: Text("Login",
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
          )
        ],
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
                    builder: (context) => const SignUpScreen(),
                  ));
            },
            child: Text("Signup",
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
    );
  }
}
