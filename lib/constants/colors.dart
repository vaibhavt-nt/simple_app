import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomColors {
  static const Color pink = Color(0xFFEE4D86);
  static const Color lightPink = Color(0xFFFCE6EE);
  static const Color grey = Color(0xffb3b3b3);
  static const Color lightGrey = Color(0xffd9d9d9);
  static const Color darkGrey = Color(0xff4e4e4e);
  static const Color lightBlack = Color(0xff1c1c1c);

  static const Color teal = Color(0xff33f2f2);
  static const Color lightPurple = Color(0xffe47ce7);

  static const Color yellow = Color(0xfff2c833);
  static const Color green = Color(0xff7ce7a0);

  static const Color lightRed = Color(0xfff23333);
  static const Color lightYellow = Color(0xffe7bc7c);

  static const Color purple = Color(0xffd833f2);
  static const Color lightOrange = Color(0xffe7967c);

  static const Color rose = Color(0xfff23361);
  static const Color levender = Color(0xff847ce7);
}

class CustomText16600 extends StatelessWidget {
  const CustomText16600({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.montserrat(
          textStyle: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ));
  }
}

class CustomText16400 extends StatelessWidget {
  const CustomText16400({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.montserrat(
          textStyle: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        ));
  }
}

class CustomText16500 extends StatelessWidget {
  const CustomText16500({super.key, required this.text, required this.colors});
  final String text;
  final Color colors;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
              color: colors, fontSize: 16, fontWeight: FontWeight.w500),
        ));
  }
}
