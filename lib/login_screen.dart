import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/home_screen.dart';
import 'package:simple_app/sign_up_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return  Text("Login",
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w600),
        ));
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 290),
              child: Text("Name",
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                          style: BorderStyle.solid, width: 1)),
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
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                          style: BorderStyle.solid, width: 1)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.purple,
          ),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white,
                fontSize: 20),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {

      },
      child: const Text("Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUp_Screen(),));
            },
            child: const Text("Sign Up", style: TextStyle(color: Colors.purple),)
        )
      ],
    );
  }
}