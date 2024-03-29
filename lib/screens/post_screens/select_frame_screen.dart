import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/post_screens/select_color_frame_screen.dart';

class SelectFrameScreen extends StatefulWidget {
  const SelectFrameScreen({
    super.key,
  });

  @override
  State<SelectFrameScreen> createState() => _SelectFrameScreenState();
}

class _SelectFrameScreenState extends State<SelectFrameScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  final List<String> _buttonTexts = ['square', 'vertical', 'horizontal'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
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
              percent: 0.20,
              barRadius: const Radius.circular(20),
              progressColor: const Color(0xffED4D86),
              backgroundColor: const Color(0xffE6E6E6),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.r, 24.r, 0.r, 24.r),
              child: Text(
                'Step 1',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: const Color(0xff1C1C1C)),
                ),
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
                      },
                      children: [
                        buildContainer(342.h, 342.w),
                        buildContainer(420.h, 342.w),
                        buildContainer(200.h, 342.w),
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
                      builder: (context) => SelectColorFrameScreen(
                        height: _getHeight(),
                        width: _getWidth(),
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

  // Helper function to get the height of the selected container
  double _getHeight() {
    switch (_selectedIndex) {
      case 0:
        return 342.h;
      case 1:
        return 420.h;
      case 2:
        return 200.h;
      default:
        return 0; // Default height
    }
  }

// Helper function to get the width of the selected container
  double _getWidth() {
    switch (_selectedIndex) {
      case 0:
        return 342.w;
      case 1:
        return 342.w;
      case 2:
        return 342.w;
      default:
        return 0; // Default width
    }
  }

  Widget buildContainer(double height, double width) {
    return Center(
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.w),
        ),
      ),
    );
  }
}
