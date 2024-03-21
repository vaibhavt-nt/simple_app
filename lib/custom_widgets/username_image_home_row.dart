import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
              textStyle: const TextStyle(
                  color: CustomColors.darkGrey,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            )),
        Center(
            child: SizedBox(
          height: 50,
          width: 50,
          child: CircleAvatar(
            backgroundImage: NetworkImage("${user!.photoURL}"),
          ),
        ))
      ],
    );
  }
}
