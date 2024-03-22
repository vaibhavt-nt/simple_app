import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/snack_bar.dart';
import 'package:simple_app/screens/navigation_screen/bottom_navigation_screen.dart';

class EditPostScreen extends StatefulWidget {
  final String platform;
  final String enteredText;
  final String selectedDate;
  final String selectedTime;
  final String postImage;
  final String docID;

  const EditPostScreen(
      {super.key,
      required this.platform,
      required this.enteredText,
      required this.selectedDate,
      required this.selectedTime,
      required this.docID,
      required this.postImage});

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
        minimum: const EdgeInsets.fromLTRB(15, 60, 10, 15),
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

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      Stack(alignment: Alignment.center, children: [
                        SizedBox(
                            height: 342,
                            width: 342,
                            child:
                                Image(image: NetworkImage(widget.postImage))),
                        Positioned.fill(
                          left: 40,
                          right: 40,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                color: Colors.white,
                                child: TextField(
                                    controller: captionText
                                      ..text = widget.enteredText,
                                    // Get.arguments['Caption'].toString(),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.black),
                                    )),
                              ),
                            ),
                          ),
                        )
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                        width: 342,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Edit Post Schedule',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                        ),
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
                                      ? widget.selectedDate
                                      : DateFormat.yMMMMd()
                                          .format(_selectedDate!),
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
                                      ? widget.selectedTime
                                      : selectedTime!.format(context),
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
                                title: Text('Select Platform',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.black),
                                    )),
                                actions: [
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FilterChip(
                                          label: const Icon(
                                            Icons.facebook,
                                            color: Colors.blue,
                                            size: 36,
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
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        FilterChip(
                                          label: SvgPicture.asset(
                                            'assets/icons_svg/instagram_outline.svg',
                                            width: 36,
                                            height: 36,
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
                                    selectedPlatform == null
                                        ? widget.platform
                                        : selectedPlatform.toString(),
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
                    ],
                  ),
                ),
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
                    if (captionText.text.isNotEmpty &&
                        _selectedDate != null &&
                        selectedTime != null &&
                        selectedPlatform != null) {
                      FirebaseFirestore.instance
                          .collection('Post Data')
                          .doc(widget.docID)
                          .update({
                        'Caption': captionText.text.trim(),
                        'Schedule Date':
                            DateFormat.yMMMMd().format(_selectedDate!),
                        'Schedule Time': selectedTime!.format(context),
                        'Platform': selectedPlatform
                      });
                      Navigator.pop(context);
                    } else {
                      CustomSnackBar.showErrorSnackBar(
                          context, 'Please fill in all the required fields');
                    }
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
              // for delete data from firestore and ui
              SizedBox(
                width: 342,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Are you sure you want to delete?',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                          content: TextButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('Post Data')
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
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.red),
                                )),
                          ),
                        );
                      },
                    );
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
    );
  }
}
