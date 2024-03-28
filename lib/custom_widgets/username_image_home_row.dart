import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/constants/colors.dart';

class UsernameImageDisplayInHomeScreen extends StatelessWidget {
  UsernameImageDisplayInHomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser;

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Good ${greeting().toString()}!\n${user!.displayName}",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  color: CustomColors.darkGrey,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500),
            )),
        Center(
            child: SizedBox(
          height: 50.h,
          width: 50.w,
          child: CircleAvatar(
            backgroundImage: NetworkImage("${user!.photoURL}"),
          ),
        ))
      ],
    );
  }
}
