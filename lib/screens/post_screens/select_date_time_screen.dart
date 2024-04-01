import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/post_screens/overview_screen.dart';
import 'package:simple_app/screens/post_screens/overview_screen_when_skip.dart';
import 'package:simple_app/services/provider/post_date_time_provider.dart';

class SelectDateAndTimeScreen extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final String imageUrl;
  final String enteredText;
  final Color frameColor1;
  final Color frameColor2;

  const SelectDateAndTimeScreen({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.imageUrl,
    required this.enteredText,
    required this.frameColor1,
    required this.frameColor2,
  });

  @override
  Widget build(BuildContext context) {
    final PostDateTimeProvider model = Provider.of<PostDateTimeProvider>(
      context,
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.r, 40.r, 24.r, 0),
        child: Column(
          children: [
            Gap(
              height: 20.h,
            ),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.2,
              lineHeight: 8.0,
              percent: 1,
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
                  Text(
                    'Step 5',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: const Color(0xff1C1C1C)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OverViewScreenWhenSkipButtonPressed(
                                  containerHeight: containerHeight,
                                  containerWidth: containerWidth,
                                  imageUrl: imageUrl,
                                  enteredText: enteredText,
                                  frameColor1: frameColor1,
                                  frameColor2: frameColor2),
                        ),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: const Color(0xff1C1C1C)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 24.0.r),
                              child: Text(
                                'Schedule your post.',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: const Color(0xff1C1C1C)),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select post date',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: const Color(0xff1C1C1C)),
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: ElevatedButton(
                              onPressed: () {
                                model.pickDateDialog(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.white),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                // overlayColor: MaterialStateProperty.all(Colors.white),
                                surfaceTintColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(
                                        width: 1.w, color: Colors.black12),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    model.selectedDate ==
                                            null //ternary expression to check if date is null
                                        ? 'Select Date'
                                        : DateFormat.yMMMMd()
                                            .format(model.selectedDate!),
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: const Color(0xff1C1C1C)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 35.w,
                                  ),
                                  const Icon(Icons.date_range_outlined)
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select post time',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: const Color(0xff1C1C1C)),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              model.pickTimeDialog(context);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.white),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              // overlayColor: MaterialStateProperty.all(Colors.white),
                              surfaceTintColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(
                                      width: 1.w, color: Colors.black12),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  model.selectedTime == null
                                      ? 'Select time'
                                      : model.selectedTime!.format(context),
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: const Color(0xff1C1C1C)),
                                  ),
                                ),
                                const Icon(Icons.watch_later_outlined)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select Platform',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: const Color(0xff1C1C1C)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FilterChip(
                                label: Icon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                  size: 36.r,
                                ),
                                selected: model.selectedPlatform == 'Facebook',
                                showCheckmark: false,
                                selectedColor: CustomColors.lightPink,
                                side:
                                    const BorderSide(color: CustomColors.pink),
                                onSelected: (value) {
                                  model.selectedPlatform = 'Facebook';
                                },
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              FilterChip(
                                label: SvgPicture.asset(
                                  'assets/icons_svg/instagram_outline.svg',
                                  width: 36.w,
                                  height: 36.h,
                                ),
                                selected: model.selectedPlatform == 'Instagram',
                                showCheckmark: false,
                                selectedColor: CustomColors.lightPink,
                                side:
                                    const BorderSide(color: CustomColors.pink),
                                onSelected: (value) {
                                  model.selectedPlatform = 'Instagram';
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
              width: 342.w,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r))),
                  overlayColor: MaterialStateProperty.all(CustomColors.pink),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5);
                      } else if (states.contains(MaterialState.disabled))
                        // ignore: curly_braces_in_flow_control_structures
                        return Colors.grey;
                      return CustomColors.pink; // Use the component's default.
                    },
                  ),
                ),
                onPressed: model.selectedDate != null &&
                        model.selectedTime != null &&
                        model.selectedPlatform != null
                    ? () {
                        final selectedDateString =
                            DateFormat.yMMMMd().format(model.selectedDate!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OverViewScreen(
                              containerHeight: containerHeight,
                              containerWidth: containerWidth,
                              imageUrl: imageUrl,
                              enteredText: enteredText,
                              selectedDate: selectedDateString,
                              selectedTime: model.selectedTime!.format(context),
                              selectedPlatform:
                                  model.selectedPlatform.toString(),
                              frameColor1: frameColor1,
                              frameColor2: frameColor2,
                            ),
                          ),
                        );
                      }
                    : null,
                child: Text('Next',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: const Color(0xffFFFFFC)),
                    )),
              ),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }
}
