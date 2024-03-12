import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/Firebase/firebase_authentication.dart';
import 'package:simple_app/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String email = '';

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(21),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Reset Password?",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: CustomColors.lightBlack,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        )),
                    const SizedBox(
                      height: 11,
                    ),
                    Text(
                        "Enter the email so we can send reset password option to it.",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: CustomColors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                    const SizedBox(
                      height: 41,
                    ),
                    emailField(),
                    const SizedBox(
                      height: 11,
                    ),
                    sendVerificationEmailButton(context)
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget emailField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      cursorColor: CustomColors.pink,
      decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: CustomColors.pink)),
          hintText: 'Enter email...',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
    );
  }

  Widget sendVerificationEmailButton(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 21, bottom: 21),
      child: MaterialButton(
          onPressed: email.isEmpty
              ? null
              : () async {
                  showLoading = true;
                  FirebaseAuthentication()
                      .sendVerificationEmail(email)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Email sent'),
                      backgroundColor: CustomColors.pink,
                    ));
                  });
                },
          padding: const EdgeInsets.symmetric(vertical: 13),
          minWidth: double.infinity,
          color: CustomColors.pink,
          disabledColor: Colors.grey.shade300,
          textColor: Colors.white,
          child: showLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const Text('Send Verification Email')),
    );
  }
}
