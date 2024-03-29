import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/screens/schedule_screen/edit_post_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
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
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text("Schedule List",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: CustomColors.darkGrey,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500),
                      )),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: EdgeInsets.all(15.0.r),
                  child: Center(
                    child: SizedBox(
                        width: 335.w,
                        height: 247.h,
                        child:
                            SvgPicture.asset('assets/home_images/empty.svg')),
                  ),
                ),
              );
            }

            //This will return Screen with post data screen
            if (snapshot.data != null) {
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text("Schedule List",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: CustomColors.darkGrey,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500),
                      )),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
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

                          // this will fetch post image from firestore
                          var postImageFirestore =
                              snapshot.data!.docs[reversedIndex]['image'];

                          var imageHeightFirestore = snapshot
                              .data!.docs[reversedIndex]['image_height'];

                          var imageWidthFirestore =
                              snapshot.data!.docs[reversedIndex]['image_width'];

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

                          Color frameColor1 = hexToColor(frameColor1Firestore);
                          Color frameColor2 = hexToColor(frameColor2Firestore);

                          var docIdFirestore =
                              snapshot.data!.docs[reversedIndex].id;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPostScreen(
                                    imageHeight: imageHeightFirestore,
                                    imageWidth: imageWidthFirestore,
                                    platform: platformFirestore,
                                    enteredText: captionFirestore,
                                    selectedDate: scheduleDateFirestore,
                                    selectedTime: scheduleTimeFirestore,
                                    postImage: postImageFirestore,
                                    docID: docIdFirestore,
                                    frameColor1: frameColor1,
                                    frameColor2: frameColor2,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 8.0.r,
                                  bottom: 8.r,
                                  right: 20.r,
                                  left: 20.r),
                              child: Container(
                                height: 130.h,
                                width: 342.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.r),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 5.r,
                                          color: Colors.grey.shade300,
                                          offset: Offset(0.r, 7.r))
                                    ]),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.r),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      textDirection: TextDirection.ltr,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        //row 1
                                        //this is show image
                                        Container(
                                          decoration: BoxDecoration(
                                              border: GradientBoxBorder(
                                                  width: 8.w,
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        frameColor1,
                                                        frameColor2,
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter)),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              color: Colors.black,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      postImageFirestore))),
                                          height: 110.h,
                                          width: 110.w,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        //row 2
                                        //this is show caption , date , time , platform
                                        SizedBox(
                                          height: 108.h,
                                          width: 204.w,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              //this is show caption
                                              SizedBox(
                                                height: 60.h,
                                                width: 204.w,
                                                child: Text(
                                                    //this will show caption from firestore
                                                    captionFirestore,
                                                    softWrap: true,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          color: CustomColors
                                                              .lightBlack,
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                              ),
                                              //this is show date , time , caption
                                              SizedBox(
                                                height: 40.h,
                                                width: 204.w,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          scheduleDateFirestore,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            textStyle: TextStyle(
                                                                color: CustomColors
                                                                    .lightBlack,
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),
                                                      Text(
                                                          scheduleTimeFirestore,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            textStyle: TextStyle(
                                                                color: CustomColors
                                                                    .lightBlack,
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),
                                                      Text(platformFirestore,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            textStyle: TextStyle(
                                                                color: CustomColors
                                                                    .lightBlack,
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
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
