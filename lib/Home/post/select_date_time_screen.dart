import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_app/Home/post/overview_screen.dart';
import 'package:simple_app/Home/post/overview_screen_when_skip.dart';
import 'package:simple_app/colors.dart';

class SelectDateAndTimeScreen extends StatefulWidget {
  const SelectDateAndTimeScreen({super.key});

  @override
  State<SelectDateAndTimeScreen> createState() =>
      _SelectDateAndTimeScreenState();
}

class _SelectDateAndTimeScreenState extends State<SelectDateAndTimeScreen> {
// For Date Pick Method
  DateTime? _selectedDate;
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

  //for time pick method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LinearPercentIndicator(
                width: 342.0,
                lineHeight: 8.0,
                percent: 1,
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
                        icon: Icon(Icons.arrow_back_ios)),
                    Text(
                      'Step 4',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xff1C1C1C)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OverViewScreenWhenSkipButtonPressed(),
                            ));
                      },
                      child: Text(
                        'Skip',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xff1C1C1C)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.4,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Text(
                            'Schedule your post.',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff1C1C1C)),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select post date',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xff1C1C1C)),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _pickDateDialog();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shadowColor: MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          // overlayColor: MaterialStateProperty.all(Colors.white),
                          surfaceTintColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(width: 1, color: Colors.black12),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate ==
                                      null //ternary expression to check if date is null
                                  ? 'Select Date'
                                  : '${DateFormat.yMMMMEEEEd().format(_selectedDate!)}',
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select post time',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xff1C1C1C)),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _pickTimeDialog();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shadowColor: MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          // overlayColor: MaterialStateProperty.all(Colors.white),
                          surfaceTintColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(width: 1, color: Colors.black12),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedTime == null
                                  ? 'Select time'
                                  : '${selectedTime!.format(context)}',
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                    overlayColor: MaterialStateProperty.all(CustomColors.pink),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5);
                        else if (states.contains(MaterialState.disabled))
                          return Colors.grey;
                        return CustomColors
                            .pink; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: _selectedDate != null && selectedTime != null
                      ? () {
                          // Navigate to the next screen
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OverViewScreen(),));
                        }
                      : null, // Disable the button if either date or time is not selected
                  child: Text('Next',
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
