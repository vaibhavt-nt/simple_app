import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Custom_Colors {
  static const Color pink =Color(0xFFEE4D86);
}

class CustomText_16_600 extends StatelessWidget {
  CustomText_16_600({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
        style: GoogleFonts.montserrat(
          textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        )
    );
  }
}

class CustomText_16_400 extends StatelessWidget {
  CustomText_16_400({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: GoogleFonts.montserrat(
          textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        )
    );
  }
}


class CustomText_16_500 extends StatelessWidget {
  CustomText_16_500({required this.text, required this.colors});
  final String text;
  final Color colors;
  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: GoogleFonts.montserrat(
          textStyle:  TextStyle(
              color: colors,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        )
    );
  }
}