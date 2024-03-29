import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NameEmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? enterText;

  const NameEmailInputField({
    super.key,
    required this.controller,
    this.validator,
    required this.enterText,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextFormFieldRow(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      validator: validator,
      placeholder: enterText,
      placeholderStyle: GoogleFonts.montserrat(
        textStyle: TextStyle(
            color: CupertinoColors.systemGrey,
            fontSize: 16.r,
            fontWeight: FontWeight.w400),
      ),
      autofillHints: const [AutofillHints.email],
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 10.0.w),
    );
  }
}

class PasswordInputField extends StatefulWidget {
  final TextEditingController passwordController;
  final String? Function(String?)? validator;

  const PasswordInputField({
    super.key,
    required this.passwordController,
    this.validator,
  });

  @override
  createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CupertinoTextFormFieldRow(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          validator: widget.validator,
          obscureText:
              !_passwordVisible, // Add this property to hide the input text
          placeholder: 'Enter your password',
          placeholderStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 16.r,
                fontWeight: FontWeight.w400),
          ),
          autofillHints: const [AutofillHints.password],
          controller: widget.passwordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 10.0.w),
        ),
        Positioned(
          right: 10.0,
          child: CupertinoButton(
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            child: Icon(
              _passwordVisible
                  ? CupertinoIcons.eye_solid
                  : CupertinoIcons.eye_slash_fill,
              color: const Color(0xFFEE4D86),
            ),
          ),
        ),
      ],
    );
  }
}
