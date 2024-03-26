import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_app/constants/colors.dart';

class ListOfPostScreen extends StatelessWidget {
  final String scheduleTime, scheduleDate, caption, platform, postImage;
  final double containerHeight;
  final double containerWidth;
  final Color frameColor1;
  final Color frameColor2;
  const ListOfPostScreen(
      {super.key,
      required this.scheduleTime,
      required this.scheduleDate,
      required this.caption,
      required this.platform,
      required this.postImage,
      required this.containerHeight,
      required this.containerWidth,
      required this.frameColor1,
      required this.frameColor2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(alignment: Alignment.topCenter, children: [
        Container(
          height: containerHeight + 70,
          width: containerWidth,
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
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                border: GradientBoxBorder(
                    width: 8,
                    gradient: LinearGradient(
                        colors: [frameColor1, frameColor2],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              ),
              child: Image.network(
                postImage,
                fit: BoxFit.cover,
                width: containerWidth,
                height: containerHeight,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(caption,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
