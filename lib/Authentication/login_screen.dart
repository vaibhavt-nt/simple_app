import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/SQLite/sqlite.dart';
import 'package:simple_app/Navigation/navigation_screen.dart';
import 'package:simple_app/Authentication/sign_up_screen.dart';
import 'package:simple_app/jsonModels/users.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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

  login() async {
    var response = await db.login(Users(
        userName: emailController.text, userPassword: passwordController.text));
    if (response == true) {
      //If login is correct, then goto notes
      if (!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NavigationScreen()));
    } else {
      //If not, true the bool value to show error message
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              isLoginTrue
                  ? const Text(
                      "Username or passowrd is incorrect",
                      style: TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
              _inputField(context),
              _signup(context),
            ],
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
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 290),
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
                      return "emil is required";
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
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 260),
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
              Padding(
                padding: const EdgeInsets.only(left: 190),
                child: TextButton(
                  onPressed: () {},
                  child: Text("Forgot Password?",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              )
            ],
          ),
          const SizedBox(height: 70),
          ElevatedButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                login();
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => HomeScreen(),
                //     ));
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
        ],
      ),
    );
  }

  _signup(context) {
    return Row(
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
    );
  }
}
