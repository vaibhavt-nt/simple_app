import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/post_screens/select_color_frame_screen.dart';
import 'package:simple_app/services/provider/post_frame_size_provider.dart';

class SelectFrameScreen extends StatelessWidget {
  const SelectFrameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostFrameSizeProvider model =
        Provider.of<PostFrameSizeProvider>(context, listen: false);
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
                        controller: model.pageController,
                        onPageChanged: (index) {
                          model.setSelectedIndex(index);
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
                              onPressed: model.previousPage,
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Color(0xffED4D86),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                            child: Text(
                              model.selectedIndex == 0
                                  ? 'square'
                                  : model.selectedIndex == 1
                                      ? 'vertical'
                                      : 'horizontal',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: const Color(0xff1C1C1C)),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: model.nextPage,
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xffED4D86),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20.r, 0, 10.r),
              child: GestureDetector(
                onTap: () {
                  double height = 0.0;
                  double width = 0.0;
                  switch (model.selectedIndex) {
                    case 0:
                      height = 342.h;
                      width = 342.w;
                      break;
                    case 1:
                      height = 420.h;
                      width = 342.w;
                      break;
                    case 2:
                      height = 200.h;
                      width = 342.w;
                      break;
                    default:
                      break;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectColorFrameScreen(
                        height: height,
                        width: width,
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
