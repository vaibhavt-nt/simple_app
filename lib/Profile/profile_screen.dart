import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/Authentication/login_screen.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Profile")),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
          },
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Log Out",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )),
            Icon(Icons.exit_to_app,color: Colors.red,)
          ],
        ),


        ),
      ),
    );
  }
}

