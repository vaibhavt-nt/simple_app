import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/Authentication/validations.dart';
import 'package:simple_app/Firebase/firebase_authentication.dart';
import 'package:simple_app/custom_widgets/gap.dart';
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

  //for validation
  final _formKey = GlobalKey<FormState>();

  final db = DatabaseHelper();

  bool isLoginTrue = false;

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
                const SizedBox(
                  height: 100,
                ),
                _header(context),
                const Gap(
                  height: 50,
                ),
                isLoginTrue
                    ? const Text(
                        "Username or password is incorrect",
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                _inputField(context),
                const Gap(
                  height: 100,
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
          textStyle: const TextStyle(
              color: Colors.black, fontSize: 32, fontWeight: FontWeight.w600),
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
                  autofillHints: const [AutofillHints.email],
                  validator: Validation.validateEmail,
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 10.0),
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
              ],
            ),
            const Gap(
              height: 10,
            ),
            SizedBox(
              height: 150,
              child: Column(
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
                    autofillHints: const [AutofillHints.password],
                    validator: Validation.validatePassword,
                    controller: passwordController,
                    obscureText: !_passwordVisible,
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
                            fontSize: 16, fontWeight: FontWeight.w400),
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
                            textStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
            SizedBox(
              height: 43,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    TextInput.finishAutofillContext();

                    try {} on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text(
                                  'No user found for that email.'),
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

                        // print('No user found for that email.');

                      } else if (e.code == 'wrong-password') {

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text(
                                  'Wrong password provided.'),
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

                        // print('Wrong password provided.');

                      }
                    }

                    final result =
                        FirebaseAuthentication.signInUsingEmailPassword(
                            email: emailController.text,
                            password: passwordController.text);

                    //this will show alert box user success
                    if (result != null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Registration successful'),
                            content: const Text('User registered successfully'),
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
                  }
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
