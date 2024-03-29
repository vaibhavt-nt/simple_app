import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/post_screens/select_image_screen.dart';
import 'package:gradient_borders/gradient_borders.dart';

class SelectColorFrameScreen extends StatefulWidget {
  final double height;
  final double width;
  SelectColorFrameScreen(
      {super.key, required this.height, required this.width});

  final List<Color> _frameColors = [
    CustomColors.teal,
    CustomColors.lightPurple,
    CustomColors.yellow,
    CustomColors.green,
    CustomColors.lightRed,
    CustomColors.lightYellow,
    CustomColors.purple,
    CustomColors.lightOrange,
    CustomColors.rose,
    CustomColors.levender,
  ];

  @override
  State<SelectColorFrameScreen> createState() => _SelectColorFrameScreenState();
}

class _SelectColorFrameScreenState extends State<SelectColorFrameScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  final List<String> _buttonTexts = [
    'Frame 1',
    'Frame 2',
    'Frame 3',
    'Frame 4',
    'Frame 5'
  ];

  Color? _selectedColor1;
  Color? _selectedColor2;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _selectedIndex = 0;
    _selectedColor1 = widget._frameColors[0];
    _selectedColor2 = widget._frameColors[1];
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.r, 40.r, 24.r, 24.r),
        child: Column(
          children: [
            Gap(
              height: 20.h,
            ),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.2,
              lineHeight: 8.0,
              percent: 0.40,
              barRadius: Radius.circular(20.r),
              progressColor: const Color(0xffED4D86),
              backgroundColor: const Color(0xffE6E6E6),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 24.r, 0, 24.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios)),
                  Padding(
                    padding: EdgeInsets.only(right: 150.r),
                    child: Text(
                      'Step 2',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: const Color(0xff1C1C1C)),
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
                      padding: EdgeInsets.only(bottom: 24.0.r),
                      child: Text(
                        'Select your post frame.',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: const Color(0xff1C1C1C)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 420.h,
                    width: 342.w,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                        _selectedColor1 = widget._frameColors[index * 2];
                        _selectedColor2 = widget._frameColors[index * 2 + 1];
                      },
                      children: [
                        buildContainer(widget.height, widget.width,
                            widget._frameColors[0], widget._frameColors[1]),
                        buildContainer(widget.height, widget.width,
                            widget._frameColors[2], widget._frameColors[3]),
                        buildContainer(widget.height, widget.width,
                            widget._frameColors[4], widget._frameColors[5]),
                        buildContainer(widget.height, widget.width,
                            widget._frameColors[6], widget._frameColors[7]),
                        buildContainer(widget.height, widget.width,
                            widget._frameColors[8], widget._frameColors[9]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 32.r, 0, 22.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xffED4D86),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                          child: Text(
                            _buttonTexts[_selectedIndex],
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: const Color(0xff1C1C1C)),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffED4D86),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20.r, 0, 10.r),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectImageScreen(
                        height: widget.height,
                        width: widget.width,
                        frameColor1: _selectedColor1!,
                        frameColor2: _selectedColor2!,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 40.h,
                  width: 342.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.r),
                    ),
                    color: const Color(0xffED4D86),
                  ),
                  child: Center(
                    child: Text('Next',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: const Color(0xffFFFFFC)),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(
      double height, double width, Color color, Color color2) {
    return Center(
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          border: GradientBoxBorder(
              width: 8.w,
              gradient: LinearGradient(
                  colors: [color, color2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        ),
      ),
    );
  }
}
