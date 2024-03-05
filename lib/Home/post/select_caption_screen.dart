import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_app/Home/post/select_date_time_screen.dart';
import 'package:simple_app/colors.dart';

class SelectCaptionScreen extends StatefulWidget {
  const SelectCaptionScreen({super.key});

  @override
  State<SelectCaptionScreen> createState() => _SelectCaptionScreenState();
}

class _SelectCaptionScreenState extends State<SelectCaptionScreen> {
  String text = '';
  final textcontroller = TextEditingController();
  Widget leftAlign = const Align(
    alignment: Alignment.topLeft,
  );

  void leftAlignment() {
    setState(() {
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          '$text vaibhav',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xff1C1C1C)),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            children: [
              LinearPercentIndicator(
                width: 342.0,
                lineHeight: 8.0,
                percent: 0.75,
                barRadius: const Radius.circular(20),
                progressColor: const Color(0xffED4D86),
                backgroundColor: const Color(0xffE6E6E6),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                child: Text(
                  'Step 3',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xff1C1C1C)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    'Enter your caption.',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xff1C1C1C)),
                    ),
                  ),
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
                minLines: 4,
                maxLines: 4,
                controller: textcontroller,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFEE4D86))),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Stack(alignment: Alignment.center, children: [
                SizedBox(
                  width: 342,
                  height: 342,
                  child: SvgPicture.asset('assets/SelectImagePost/image1.svg'),
                ),
                Container(
                  color: Colors.white,
                  height: 237,
                  width: 237,
                  child: Text(
                    text,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xff1C1C1C)),
                    ),
                  ),
                )
              ]),

              const SizedBox(
                height: 20,
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Text('Select text alignment',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black),
                    )),
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: CustomColors.pink),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        //borderRadius: BorderRadius.circular(100.0),
                        onTap: () {
                          leftAlignment();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            // Icons.vertical_distribute,
                            Icons.format_align_left_outlined,
                            size: 20.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: CustomColors.pink),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        //borderRadius: BorderRadius.circular(100.0),
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            // Icons.vertical_distribute,
                            Icons.format_align_center_outlined,
                            size: 20.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: CustomColors.pink),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        //borderRadius: BorderRadius.circular(100.0),
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            // Icons.vertical_distribute,
                            Icons.format_align_right_outlined,
                            size: 20.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Center(
              //   child: _image == null
              //       ? widget.selectedFrame.frameContainer
              //       : _image!.path.startsWith('assets/')
              //       ? Image.asset(_image!.path, fit: BoxFit.fill,)
              //       : Image.file(File(_image!.path)),
              // ),

              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectDateAndTimeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 342,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color: Color(0xffED4D86),
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
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _getImage,
      //   tooltip: 'Pick Image',
      //   child: const Icon(Icons.add_a_photo),
      // ),
    );
  }
}
