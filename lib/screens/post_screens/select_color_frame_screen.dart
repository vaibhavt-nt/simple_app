import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          children: [
            const Gap(
              height: 20,
            ),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.2,
              lineHeight: 8.0,
              percent: 0.40,
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
                      'Step 2',
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
                        'Select your post frame.',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xff1C1C1C)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 420,
                    width: 342,
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
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 22),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            _buttonTexts[_selectedIndex],
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xff1C1C1C)),
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
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
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
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: GradientBoxBorder(
              width: 8,
              gradient: LinearGradient(
                  colors: [color, color2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        ),
      ),
    );
  }
}
