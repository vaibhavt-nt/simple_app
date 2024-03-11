import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/colors.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  // For Date Pick Method
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
          minimum: const EdgeInsets.fromLTRB(0, 60, 0, 10),
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
                      child: Text(
                          'Lorem ipsum dolor sit\n'
                          'amet consectetur.\n'
                          'Senectus eleifend purus\n'
                          'viverra placerat\n'
                          'pellentesque ac et\n'
                          'commodo. Viverra tellus\n'
                          'risus arcu integer justo\n'
                          'malesuada in urna\n'
                          'enim.',
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
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Post Schedule',
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
                          Text('31 October 2001',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
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
                          Text('01 : 08 PM',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
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
                          title: Text('Select Plateform',
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
                          Text('Facebook',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
