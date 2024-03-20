import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/post_screens/select_date_time_screen.dart';

class SelectCaptionScreen extends StatefulWidget {
  final double containerHeight;
  final double containerWidth;
  final String imageUrl;
  const SelectCaptionScreen({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.imageUrl,
  });

  @override
  State<SelectCaptionScreen> createState() => _SelectCaptionScreenState();
}

class _SelectCaptionScreenState extends State<SelectCaptionScreen> {
  final textFieldController = TextEditingController();
  String enteredText = '';
  TextAlign? _textAlign;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.2,
              lineHeight: 8.0,
              percent: 0.75,
              barRadius: const Radius.circular(20),
              progressColor: const Color(0xffED4D86),
              backgroundColor: const Color(0xffE6E6E6),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios)),
                  Padding(
                    padding: const EdgeInsets.only(right: 150),
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
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
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
                        enteredText = value;
                      });
                    },
                    minLines: 4,
                    maxLines: 4,
                    controller: textFieldController,
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
                    Center(
                      child: widget.imageUrl.isNotEmpty
                          ? Image.file(
                              File(widget.imageUrl),
                              fit: BoxFit.cover,
                              height: widget.containerHeight,
                              width: widget.containerWidth,
                            )
                          : const Text(
                              'Container',
                              style: TextStyle(fontSize: 20),
                            ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            color: Colors.white,
                            child: Text(
                              enteredText,
                              textAlign: _textAlign,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xff1C1C1C)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                            border:
                                Border.all(width: 1, color: CustomColors.pink),
                            color: Colors.white,
                          ),
                          child: InkWell(
                            //borderRadius: BorderRadius.circular(100.0),
                            onTap: () {
                              setState(() => _textAlign = TextAlign.left);
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
                            border:
                                Border.all(width: 1, color: CustomColors.pink),
                            color: Colors.white,
                          ),
                          child: InkWell(
                            //borderRadius: BorderRadius.circular(100.0),
                            onTap: () {
                              setState(() => _textAlign = TextAlign.center);
                            },
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
                            border:
                                Border.all(width: 1, color: CustomColors.pink),
                            color: Colors.white,
                          ),
                          child: InkWell(
                            //borderRadius: BorderRadius.circular(100.0),
                            onTap: () {
                              setState(() => _textAlign = TextAlign.right);
                            },
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
                  Gap(
                    height: 30,
                  )
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectDateAndTimeScreen(
                      containerHeight: widget.containerHeight,
                      containerWidth: widget.containerWidth,
                      imageUrl: widget.imageUrl,
                      enteredText: enteredText,
                    ),
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
          ],
        ),
      ),
    );
  }
}
