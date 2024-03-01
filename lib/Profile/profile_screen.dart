import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/Authentication/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Profile")),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
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
              const Icon(
                Icons.exit_to_app,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
