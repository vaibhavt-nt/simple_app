import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_app/colors.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  //textfield for update caption
  final captionText = TextEditingController();

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
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.fromLTRB(15, 60, 10, 15),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back)),
                      Text("Edit Post",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: CustomColors.darkGrey,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          )),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

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
                      child: TextField(
                          controller: captionText
                            ..text = Get.arguments['Caption'].toString(),
                          // Get.arguments['Caption'].toString(),
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('Post Schedule',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                // this is to change date
                GestureDetector(
                  onTap: () {
                    _pickDateDialog();
                  },
                  child: Container(
                    height: 40,
                    width: 342,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: CustomColors.pink)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate ==
                                    null //ternary expression to check if date is null
                                ? Get.arguments['ScheduleDate'].toString()
                                : DateFormat.yMMMMEEEEd()
                                    .format(_selectedDate!),
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff1C1C1C)),
                            ),
                          ),
                          // Text(Get.arguments['ScheduleDate'].toString(),
                          //     style: GoogleFonts.montserrat(
                          //       textStyle: const TextStyle(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 16,
                          //           color: Colors.black),
                          //     )),
                          const Icon(Icons.date_range_outlined)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // this is to change time
                GestureDetector(
                  onTap: () {
                    _pickTimeDialog();
                  },
                  child: Container(
                    height: 40,
                    width: 342,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: CustomColors.pink)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedTime == null
                                ? Get.arguments['ScheduleTime'].toString()
                                : selectedTime!.format(context),
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff1C1C1C)),
                            ),
                          ),
                          // Text(
                          //     // Get.arguments['ScheduleTime'].toString(),
                          //     style: GoogleFonts.montserrat(
                          //       textStyle: const TextStyle(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 16,
                          //           color: Colors.black),
                          //     )),
                          const Icon(Icons.watch_later_outlined)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // this is to change platform
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          alignment: Alignment.center,
                          title: Text('Facebook',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                          actions: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FilterChip(
                                    label: const Icon(
                                      Icons.facebook,
                                      color: Colors.blue,
                                      size: 36,
                                    ),
                                    selected: false,
                                    showCheckmark: false,
                                    selectedColor: CustomColors.lightPink,
                                    side: const BorderSide(
                                        color: CustomColors.pink),
                                    onSelected: (value) {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  FilterChip(
                                    label: SvgPicture.asset(
                                      'assets/icons_svg/instagram_outline.svg',
                                      width: 36,
                                      height: 36,
                                    ),
                                    selected: false,
                                    showCheckmark: false,
                                    selectedColor: CustomColors.lightPink,
                                    side: const BorderSide(
                                        color: CustomColors.pink),
                                    onSelected: (value) {

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
                    height: 40,
                    width: 342,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: CustomColors.pink)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Get.arguments['Platform'].toString(),
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                          const Icon(Icons.facebook)
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 130,
                ),
                //for update data in firestore
                SizedBox(
                  width: 342,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(CustomColors.pink),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('Post Data')
                          .doc(Get.arguments['docId'].toString())
                          .update({
                        'Caption': captionText.text.trim(),
                        'Schedule Date':
                            DateFormat.yMMMMEEEEd().format(_selectedDate!),
                        'Schedule Time':selectedTime!.format(context),
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Save',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xffFFFFFC)),
                        )),
                  ),
                ),

                SizedBox(
                  width: 342,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('Post Data')
                          .doc(Get.arguments['docId'].toString())
                          .delete();
                      Navigator.pop(context);
                    },
                    child: Text('Delete',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xffFFFFFC)),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
