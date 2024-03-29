import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/custom_widgets/snack_bar.dart';
import 'package:simple_app/screens/navigation_screen/bottom_navigation_screen.dart';

class EditPostScreen extends StatefulWidget {
  final String platform;
  final String enteredText;
  final String selectedDate;
  final String selectedTime;
  final String postImage;
  final String docID;
  final double imageHeight, imageWidth;
  final Color frameColor1;
  final Color frameColor2;

  const EditPostScreen(
      {super.key,
      required this.platform,
      required this.enteredText,
      required this.selectedDate,
      required this.selectedTime,
      required this.docID,
      required this.postImage,
      required this.imageHeight,
      required this.imageWidth,
      required this.frameColor1,
      required this.frameColor2});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  //textfield for update caption
  final captionText = TextEditingController();
//for platform select
  String? selectedPlatform;

// For Date Pick Method
  static DateTime? _selectedDate;
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime.now(),
            //what will be the previous supported year in picker
            lastDate: DateTime(
                2025)) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  //for time pick method
  TimeOfDay? selectedTime;
  void _pickTimeDialog() {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        selectedTime = pickedDate;
      });
    });
  }

  //for plateform select

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(15.r, 60.r, 10.r, 15.r),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back)),
                  Text("Edit Post",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: CustomColors.darkGrey,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500),
                      )),
                  SizedBox(
                    width: 50.w,
                  )
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),

                      Stack(alignment: Alignment.center, children: [
                        Container(
                            height: widget.imageHeight.h,
                            width: widget.imageWidth.w,
                            decoration: BoxDecoration(
                              border: GradientBoxBorder(
                                  width: 8.w,
                                  gradient: LinearGradient(
                                      colors: [
                                        widget.frameColor1,
                                        widget.frameColor2
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                            ),
                            child: Image(
                              image: NetworkImage(widget.postImage),
                              fit: BoxFit.cover,
                              width: widget.imageWidth,
                              height: widget.imageHeight,
                            )),
                        Positioned.fill(
                          left: 40.r,
                          right: 40.r,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0.r),
                              child: Container(
                                color: Colors.white,
                                child: TextField(
                                    controller: captionText
                                      ..text = widget.enteredText,
                                    // Get.arguments['Caption'].toString(),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          color: Colors.black),
                                    )),
                              ),
                            ),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 20.h,
                        width: 342.w,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Edit Post Schedule',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.r,
                                    color: Colors.black),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // this is to change date
                      GestureDetector(
                        onTap: () {
                          _pickDateDialog();
                        },
                        child: Container(
                          height: 40.h,
                          width: 342.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: CustomColors.pink)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedDate ==
                                          null //ternary expression to check if date is null
                                      ? widget.selectedDate
                                      : DateFormat.yMMMMd()
                                          .format(_selectedDate!),
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.r,
                                        color: const Color(0xff1C1C1C)),
                                  ),
                                ),
                                Icon(
                                  Icons.date_range_outlined,
                                  size: 25.r,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // this is to change time
                      GestureDetector(
                        onTap: () {
                          _pickTimeDialog();
                        },
                        child: Container(
                          height: 40.h,
                          width: 342.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: CustomColors.pink)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedTime == null
                                      ? widget.selectedTime
                                      : selectedTime!.format(context),
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.r,
                                        color: const Color(0xff1C1C1C)),
                                  ),
                                ),
                                Icon(
                                  Icons.watch_later_outlined,
                                  size: 25.r,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      // this is to change platform
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                alignment: Alignment.center,
                                title: Text('Select Platform',
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: Colors.black),
                                    )),
                                actions: [
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FilterChip(
                                          label: Icon(
                                            Icons.facebook,
                                            color: Colors.blue,
                                            size: 36.r,
                                          ),
                                          selected:
                                              selectedPlatform == 'Facebook',
                                          showCheckmark: false,
                                          selectedColor: CustomColors.lightPink,
                                          side: const BorderSide(
                                              color: CustomColors.pink),
                                          onSelected: (value) {
                                            setState(() {
                                              selectedPlatform = 'Facebook';
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                        SizedBox(
                                          width: 40.w,
                                        ),
                                        FilterChip(
                                          label: SvgPicture.asset(
                                            'assets/icons_svg/instagram_outline.svg',
                                            width: 25.w,
                                            height: 25.h,
                                          ),
                                          selected:
                                              selectedPlatform == 'Instagram',
                                          showCheckmark: false,
                                          selectedColor: CustomColors.lightPink,
                                          side: const BorderSide(
                                              color: CustomColors.pink),
                                          onSelected: (value) {
                                            setState(() {
                                              selectedPlatform = 'Instagram';
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 40.h,
                          width: 342.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: CustomColors.pink)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    selectedPlatform == null
                                        ? widget.platform
                                        : selectedPlatform.toString(),
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.r,
                                          color: Colors.black),
                                    )),
                                Icon(
                                  Icons.facebook,
                                  size: 25.r,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //for update data in firestore
              SizedBox(
                width: 342.w,
                height: 40.h,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(CustomColors.pink),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r))),
                  ),
                  onPressed: () {
                    if (captionText.text.isNotEmpty &&
                        _selectedDate != null &&
                        selectedTime != null &&
                        selectedPlatform != null) {
                      FirebaseFirestore.instance
                          .collection('post_data')
                          .doc(widget.docID)
                          .update({
                        'caption': captionText.text.trim(),
                        'schedule_date':
                            DateFormat.yMMMMd().format(_selectedDate!),
                        'schedule_time': selectedTime!.format(context),
                        'platform': selectedPlatform
                      });
                      Navigator.pop(context);
                    } else {
                      CustomSnackBar.showErrorSnackBar(
                          context, 'Please fill in all the required fields');
                    }
                  },
                  child: Text('Save',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: const Color(0xffFFFFFC)),
                      )),
                ),
              ),
              Gap(
                height: 20.h,
              ),
              // for delete data from firestore and ui
              SizedBox(
                width: 342.w,
                height: 40.h,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r))),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Are you sure you want to delete?',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: Colors.black),
                              )),
                          content: TextButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('post_data')
                                  .doc(widget.docID)
                                  .delete();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomNavigationBarScreen(),
                                  ));
                            },
                            child: Text('Delete',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      color: Colors.red),
                                )),
                          ),
                        );
                      },
                    );
                  },
                  child: Text('Delete',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: const Color(0xffFFFFFC)),
                      )),
                ),
              ),
              Gap(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
