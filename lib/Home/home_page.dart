import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_app/Home/empty_home_page_screen.dart';
import 'package:simple_app/Home/list_of_post_screen.dart';
import 'package:simple_app/Home/post/select_frame_screen.dart';
import 'package:simple_app/colors.dart';
import 'package:simple_app/jsonModels/users.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({
    super.key,
  });

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  //for check if post is empty
  final bool isPostEmpty = false;
  //for showing username and image
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
    //if not created post then show create post page
    if (isPostEmpty) {
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
                                color: CustomColors.darkGrey,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          )),
                      CircleAvatar(
                        child: SvgPicture.asset('assets/home_images/empty.svg'),
                      )
                    ],
                  ),
                ),
                const EmptyHomeScreen(
                  imagePath: 'assets/home_images/empty.svg',
                  subtitle: "You don’t have create any posts. Please\n"
                      "                     create new post.",
                  buttonText: "Create Post",
                ),
              ],
            ),
          ),
        ),
      );
      //if created post then show create post page
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Good Morning!\n${_user?.userName ?? ''}",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: CustomColors.darkGrey,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        )),
                    CircleAvatar(
                      child: SvgPicture.asset('assets/home_images/empty.svg'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Your Created Posts',
                    // "Create Post",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: CustomColors.darkGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return const ListOfPostScreen();
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectFrameScreen(),
                ));
          },
          backgroundColor: CustomColors.pink,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
