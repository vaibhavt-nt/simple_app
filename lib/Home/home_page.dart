import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/Home/empty_home_page_screen.dart';
import 'package:simple_app/Home/list_of_post_screen.dart';
import 'package:simple_app/Home/post/select_frame_screen.dart';
import 'package:simple_app/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // for showing data from firestore you need stream builder
        child: StreamBuilder(
          //this is for getting data from firestore with userId found
          stream: FirebaseFirestore.instance
              .collection("Post Data")
              .where("userId", isEqualTo: user?.uid)
              .snapshots(),

          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong!');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            //This will return empty data screen
            if (snapshot.data!.docs.isEmpty) {
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
                              Text("Good Morning!\n${user!.displayName}",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: CustomColors.darkGrey,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  )),
                              CircleAvatar(
                                child: SvgPicture.asset(
                                    'assets/home_images/empty.svg'),
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
            }

            //This will return Screen with post data screen
            if (snapshot.data != null) {
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
                            Text("Good Morning!\n${user!.displayName}",
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: CustomColors.darkGrey,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                )),
                            const SizedBox(
                              height: 60,
                              width: 60,
                              child: ClipOval(
                                  child: CircleAvatar(
                                backgroundColor: Colors.pink,
                              )),
                            ),
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
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            // this will fetch caption from firestore
                            var captionFirestore =
                                snapshot.data!.docs[index]['Caption'];

                            // this will fetch platform from firestore
                            var platformFirestore =
                                snapshot.data!.docs[index]['Platform'];

                            // this will fetch Schedule Time from firestore
                            var scheduleTimeFirestore =
                                snapshot.data!.docs[index]['Schedule Time'];

                            // this will fetch Schedule Date from firestore
                            var scheduleDateFirestore =
                                snapshot.data!.docs[index]['Schedule Date'];

                            var postImageLocal =
                                'assets/SelectImagePost/image1.png';

                            return ListOfPostScreen(
                                scheduleTime: scheduleTimeFirestore,
                                scheduleDate:
                                    'Schedule: $scheduleDateFirestore',
                                caption: captionFirestore,
                                platform: platformFirestore,
                                postImage: postImageLocal);
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
            return Container();
          },
        ),
      ),
    );
  }
}
