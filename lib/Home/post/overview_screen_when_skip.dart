import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/Navigation/navigation_screen.dart';
import 'package:simple_app/colors.dart';

class OverViewScreenWhenSkipButtonPressed extends StatefulWidget {
  const OverViewScreenWhenSkipButtonPressed({super.key});

  @override
  State<OverViewScreenWhenSkipButtonPressed> createState() =>
      _OverViewScreenWhenSkipButtonPressedState();
}

class _OverViewScreenWhenSkipButtonPressedState
    extends State<OverViewScreenWhenSkipButtonPressed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(0, 60, 0, 10),
        child: Center(
          child: Column(
            children: [
              Stack(alignment: Alignment.center, children: [
                const SizedBox(
                    height: 342,
                    width: 342,
                    child: Image(
                        image:
                            AssetImage('assets/SelectImagePost/image1.png'))),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  height: 237,
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
                )
              ]),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.white,
                      shadowColor: Colors.white,
                      backgroundColor:
                          Colors.white, //background color of button
                      side: const BorderSide(
                          width: 2,
                          color: CustomColors.pink), //border width and color
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {},
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.file_download_outlined,
                            size: 20,
                            color: Colors.black,
                          ),
                          Text('Download',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                          // Icon(Icons.file_download_outlined),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.white,
                      shadowColor: Colors.white,
                      backgroundColor:
                          Colors.white, //background color of button
                      side: const BorderSide(
                          width: 2,
                          color: CustomColors.pink), //border width and color
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {},
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            size: 15,
                            Icons.share_outlined,
                            color: Colors.black,
                          ),
                          Text('    Share',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                          // Icon(Icons.file_download_outlined),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                child: SizedBox(
                  width: 342,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(CustomColors.pink),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavigationScreen(),
                          ));
                    },
                    child: Text('Go to home',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xffFFFFFC)),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
