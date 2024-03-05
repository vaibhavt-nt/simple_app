import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_app/Home/post/select_frame_screen.dart';
import 'package:simple_app/jsonModels/users.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({
    super.key,
  });

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  Users? _user;

  Future<Users?> _loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');
    if (userJson == null) return null;
    return Users.fromJson(json.decode(userJson));
  }

  @override
  void initState() {
    super.initState();
    _loadUser().then((user) {
      if (user != null) {
        setState(() {
          _user = user;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Good Morning!\n${_user?.userName ?? ''}",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        )),
                    CircleAvatar(
                      child: SvgPicture.asset('assets/home_images/empty.svg'),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SvgPicture.asset('assets/home_images/empty.svg'),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                    "You don’t have create any posts. Please\n"
                    "                     create new post.",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectFrameScreen(),
                        ));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFEE4D86)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))))),
                  child: Text("Create Post",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
