import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/constants/colors.dart';

class ListOfPostScreen extends StatelessWidget {
  final String scheduleTime, scheduleDate, caption, platform, postImage;
  const ListOfPostScreen(
      {super.key,
      required this.scheduleTime,
      required this.scheduleDate,
      required this.caption,
      required this.platform,
      required this.postImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(alignment: Alignment.topCenter, children: [
        Container(
          height: 390,
          width: 342,
          decoration: BoxDecoration(
              color: CustomColors.lightPink,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Schedule: $scheduleDate",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black),
                        )),
                    Text(platform,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black),
                        )),
                  ],
                ),
                Text(scheduleTime,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 322,
              height: 322,
              child: Image.network(postImage),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.white,
                child: Text(
                  caption,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
