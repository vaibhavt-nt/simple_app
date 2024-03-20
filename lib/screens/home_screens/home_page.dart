import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/empty_home_page_screen.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/custom_widgets/list_of_post_screen.dart';
import 'package:simple_app/custom_widgets/username_image_home_row.dart';
import 'package:simple_app/screens/post_screens/select_frame_screen.dart';

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
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        //username and image
                        UsernameImageDisplayInHomeScreen(),
                        const EmptyHomeScreen(
                          imagePath: 'assets/home_images/empty.svg',
                          subtitle: "You don’t have create any posts. Please\n"
                              " create new post.",
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
                        const Gap(
                          height: 50,
                        ),
                        //username and image
                        UsernameImageDisplayInHomeScreen(),
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
                            final int reversedIndex =
                                snapshot.data!.docs.length - index - 1;
                            // this will fetch caption from firestore
                            var captionFirestore =
                                snapshot.data!.docs[reversedIndex]['Caption'];

                            // this will fetch platform from firestore
                            var platformFirestore =
                                snapshot.data!.docs[reversedIndex]['Platform'];

                            // this will fetch Schedule Time from firestore
                            var scheduleTimeFirestore = snapshot
                                .data!.docs[reversedIndex]['Schedule Time'];

                            // this will fetch Schedule Date from firestore
                            var scheduleDateFirestore = snapshot
                                .data!.docs[reversedIndex]['Schedule Date'];

                            var postImageFirestore =
                                snapshot.data!.docs[reversedIndex]['Image'];

                            //thi is a post id
                            // var docIdFirestore = snapshot.data!.docs[index].id;

                            return ListOfPostScreen(
                                scheduleTime: scheduleTimeFirestore,
                                scheduleDate: scheduleDateFirestore,
                                caption: captionFirestore,
                                platform: platformFirestore,
                                postImage: postImageFirestore);
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
