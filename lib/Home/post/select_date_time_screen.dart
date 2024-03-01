import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_app/colors.dart';

class SelectDateAndTimeScreen extends StatefulWidget {
  const SelectDateAndTimeScreen({super.key});

  @override
  State<SelectDateAndTimeScreen> createState() =>
      _SelectDateAndTimeScreenState();
}

class _SelectDateAndTimeScreenState extends State<SelectDateAndTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          children: [
            LinearPercentIndicator(
              width: 342.0,
              lineHeight: 8.0,
              percent: 1,
              barRadius: const Radius.circular(20),
              progressColor: const Color(0xffED4D86),
              backgroundColor: const Color(0xffE6E6E6),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: Text(
                'Step 4',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xff1C1C1C)),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Text(
                          'Schedule your post.',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xff1C1C1C)),
                          ),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select post date',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xff1C1C1C)),
                        ),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shadowColor: MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        // overlayColor: MaterialStateProperty.all(Colors.white),
                        surfaceTintColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(width: 1, color: Colors.black12),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select date',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff1C1C1C)),
                            ),
                          ),
                          const Icon(Icons.date_range_outlined)
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select post time',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xff1C1C1C)),
                        ),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shadowColor: MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        // overlayColor: MaterialStateProperty.all(Colors.white),
                        surfaceTintColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(width: 1, color: Colors.black12),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select time',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff1C1C1C)),
                            ),
                          ),
                          const Icon(Icons.watch_later_outlined)
                        ],
                      ),
                    ),

                    // Center(
                    //   child: _image == null
                    //       ? widget.selectedFrame.frameContainer
                    //       : _image!.path.startsWith('assets/')
                    //       ? Image.asset(_image!.path, fit: BoxFit.fill,)
                    //       : Image.file(File(_image!.path)),
                    // ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SelectCaptionScreen(),
                    //   ),
                    // );
                  },
                  child: Container(
                    height: 40,
                    width: 342,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color: CustomColors.grey,
                    ),
                    child: Center(
                      child: Text('Next',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xffFFFFFC)),
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
