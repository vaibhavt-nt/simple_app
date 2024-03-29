import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              .collection("post_data")
              .where("user_id", isEqualTo: user?.uid)
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
                    padding: EdgeInsets.all(20.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        //username and image
                        UsernameImageDisplayInHomeScreen(),
                        Gap(
                          height: 30.h,
                        ),
                        const Center(
                          child: EmptyHomeScreen(
                            imagePath: 'assets/home_images/empty.svg',
                            subtitle:
                                "You don’t have create any posts. Please\n"
                                " create new post.",
                            buttonText: "Create Post",
                          ),
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
                    padding: EdgeInsets.all(25.0.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(
                          height: 50.h,
                        ),
                        //username and image
                        UsernameImageDisplayInHomeScreen(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text('Your Created Posts',
                            // "Create Post",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: CustomColors.darkGrey,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            )),
                        ListView.builder(
                          reverse: true,
                          addSemanticIndexes: true,
                          addAutomaticKeepAlives: true,
                          addRepaintBoundaries: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final int reversedIndex =
                                snapshot.data!.docs.length - index - 1;
                            // this will fetch caption from firestore
                            var captionFirestore =
                                snapshot.data!.docs[reversedIndex]['caption'];

                            // this will fetch platform from firestore
                            var platformFirestore =
                                snapshot.data!.docs[reversedIndex]['platform'];

                            // this will fetch Schedule Time from firestore
                            var scheduleTimeFirestore = snapshot
                                .data!.docs[reversedIndex]['schedule_time'];

                            // this will fetch Schedule Date from firestore
                            var scheduleDateFirestore = snapshot
                                .data!.docs[reversedIndex]['schedule_date'];

                            var postImageFirestore =
                                snapshot.data!.docs[reversedIndex]['image'];

                            var imageHeightFirestore = snapshot
                                .data!.docs[reversedIndex]['image_height'];

                            var imageWidthFirestore = snapshot
                                .data!.docs[reversedIndex]['image_width'];

                            //for converting firestore string to color
                            Color hexToColor(String hexString) {
                              int colorValue = int.parse(
                                  hexString.replaceFirst('#', ''),
                                  radix: 16);
                              return Color(colorValue);
                            }

                            var frameColor1Firestore = snapshot
                                .data!.docs[reversedIndex]['frame_color1'];
                            var frameColor2Firestore = snapshot
                                .data!.docs[reversedIndex]['frame_color2'];

                            Color frameColor1 =
                                hexToColor(frameColor1Firestore);
                            Color frameColor2 =
                                hexToColor(frameColor2Firestore);

                            //thi is a post id
                            // var docIdFirestore = snapshot.data!.docs[index].id;

                            return ListOfPostScreen(
                              scheduleTime: scheduleTimeFirestore,
                              scheduleDate: scheduleDateFirestore,
                              caption: captionFirestore,
                              platform: platformFirestore,
                              postImage: postImageFirestore,
                              containerHeight: imageHeightFirestore,
                              containerWidth: imageWidthFirestore,
                              frameColor1: frameColor1,
                              frameColor2: frameColor2,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: SizedBox(
                  height: 60.h,
                  width: 60.w,
                  child: FloatingActionButton(
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
