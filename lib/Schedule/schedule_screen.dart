import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/Schedule/edit_post_screen.dart';
import 'package:simple_app/colors.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0, right: 15, left: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Schedule List",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: CustomColors.darkGrey,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditPostScreen(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 130,
                            width: 342,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey.shade300,
                                      offset: const Offset(0, 7))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              textDirection: TextDirection.ltr,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //row 1
                                //this is show image
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/SelectImagePost/image1.png'))),
                                  height: 110,
                                  width: 110,
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
                                            softWrap: true,
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.start,
                                            "Lorem ipsum dolor sit amet consectetur. Senectus eleifend purus viverra placerat pellentesque ac et commodo. Viverra tellus risus arcu integer justo malesuada in urna enim.",
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                  color:
                                                      CustomColors.lightBlack,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      ),
                                      //this is show date , time , caption
                                      SizedBox(
                                        height: 40,
                                        width: 204,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("25 October 2021",
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                        color: CustomColors
                                                            .lightBlack,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                              Text("10:00 AM",
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                        color: CustomColors
                                                            .lightBlack,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                              Text("Instagram",
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                        color: CustomColors
                                                            .lightBlack,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
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
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
