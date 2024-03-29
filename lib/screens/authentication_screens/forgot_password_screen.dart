import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/services/firebase_service/firebase_authentication.dart';

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
                padding: EdgeInsets.all(21.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Reset Password?",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: CustomColors.lightBlack,
                              fontSize: 24.r,
                              fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 11.h,
                    ),
                    Text(
                        "Enter the email so we can send reset password option to it.",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: CustomColors.grey,
                              fontSize: 16.r,
                              fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 41.h,
                    ),
                    emailField(),
                    SizedBox(
                      height: 11.h,
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
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.r)),
    );
  }

  Widget sendVerificationEmailButton(context) {
    return Padding(
      padding: EdgeInsets.only(top: 21.r, bottom: 21.r),
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
          padding: EdgeInsets.symmetric(vertical: 13.r),
          minWidth: double.infinity,
          color: CustomColors.pink,
          disabledColor: Colors.grey.shade300,
          textColor: Colors.white,
          child: showLoading
              ? SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const Text('Send Verification Email')),
    );
  }
}
