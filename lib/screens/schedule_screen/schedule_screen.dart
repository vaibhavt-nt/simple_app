import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text("Schedule List",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: CustomColors.darkGrey,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      )),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: SvgPicture.asset('assets/home_images/empty.svg'),
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
                        textStyle: const TextStyle(
                            color: CustomColors.darkGrey,
                            fontSize: 24,
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

                          // this will fetch post image from firestore
                          var postImageFirestore =
                              snapshot.data!.docs[reversedIndex]['Image'];

                          var docIdFirestore =
                              snapshot.data!.docs[reversedIndex].id;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPostScreen(
                                    platform: platformFirestore,
                                    enteredText: captionFirestore,
                                    selectedDate: scheduleDateFirestore,
                                    selectedTime: scheduleTimeFirestore,
                                    postImage: postImageFirestore,
                                    docID: docIdFirestore,
                                  ),
                                ),
                              );
                              // Get.to(() => const EditPostScreen(), arguments: {
                              //   'Caption': captionFirestore,
                              //   'ScheduleDate': scheduleDateFirestore,
                              //   'ScheduleTime': scheduleTimeFirestore,
                              //   'Platform': platformFirestore,
                              //   'docId': docIdFirestore,
                              // });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.grey.shade300,
                                          offset: const Offset(0, 7))
                                    ]),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      postImageFirestore))),
                                          height: 110,
                                          width: 110,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        //row 2
                                        //this is show caption , date , time , platform
                                        SizedBox(
                                          height: 108,
                                          width: 204,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              //this is show caption
                                              SizedBox(
                                                height: 60,
                                                width: 204,
                                                child: Text(
                                                    //this will show caption from firestore
                                                    captionFirestore,
                                                    softWrap: true,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      textStyle: const TextStyle(
                                                          color: CustomColors
                                                              .lightBlack,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                              ),
                                              //this is show date , time , caption
                                              SizedBox(
                                                height: 40,
                                                width: 204,
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
                                                            textStyle: const TextStyle(
                                                                color: CustomColors
                                                                    .lightBlack,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),
                                                      Text(
                                                          scheduleTimeFirestore,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            textStyle: const TextStyle(
                                                                color: CustomColors
                                                                    .lightBlack,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),
                                                      Text(platformFirestore,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            textStyle: const TextStyle(
                                                                color: CustomColors
                                                                    .lightBlack,
                                                                fontSize: 10,
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
