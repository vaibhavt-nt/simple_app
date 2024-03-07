import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/colors.dart';

class ListOfPostScreen extends StatelessWidget {
  const ListOfPostScreen({super.key});

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
            padding: const EdgeInsets.only(top: 300, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                  ),
                  child: Column(
                    children: [
                      Text('Schedule: 31 October 2021',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 110),
                        child: Text('Instagram',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black),
                            )),
                      ),
                    ],
                  ),
                ),
                Text('01:08 PM',
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
          child: SizedBox(
            width: 322,
            height: 322,
            child: Image.asset('assets/SelectImagePost/image1.png'),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 220,
              width: 237,
              child: Center(
                child: Text(
                    'Lorem ipsum dolor sit\n'
                    'amet consectetur.\n'
                    'Senectus eleifend purus\n'
                    'viverra placerat\n'
                    'pellentesque ac et\n'
                    'commodo. Viverra tellus\n'
                    'risus arcu integer justo\n'
                    'malesuada in urna\n'
                    'enim.',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    )),
              ),
            ))
      ]),
    );
  }
}
