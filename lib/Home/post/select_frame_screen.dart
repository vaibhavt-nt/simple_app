import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_app/Home/post/select_image_screen.dart';

class SelectFrameScreen extends StatefulWidget {
  const SelectFrameScreen({
    super.key,
  });

  @override
  State<SelectFrameScreen> createState() => _SelectFrameScreenState();
}

class _SelectFrameScreenState extends State<SelectFrameScreen> {
  late PageController _pageController = PageController(viewportFraction: 1.1);
  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var idx = _pageIndex;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width/1.2,
              lineHeight: 8.0,
              percent: 0.25,
              barRadius: const Radius.circular(20),
              progressColor: const Color(0xffED4D86),
              backgroundColor: const Color(0xffE6E6E6),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: Text(
                'Step 1',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xff1C1C1C)),
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
                    child: PageView.builder(
                      itemCount: frames.length,
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                          if (kDebugMode) {
                            print(_pageIndex);
                          }
                          if (kDebugMode) {
                            print(frames[index].frameType);
                          }
                          if (kDebugMode) {
                            print(frames[index].frameContainer.toString());
                          }
                        });
                      },
                      itemBuilder: (context, index) => FrameContent(
                          frameType: frames[index].frameType,
                          frameContainer: frames[index].frameContainer),
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
                            frames[idx].frameType,
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
                  Frame selectedFrame = frames[_pageIndex];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SelectImageScreen(selectedFrame: selectedFrame),
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
}

class Frame {
  final String frameType;
  final Widget frameContainer;

  Frame({
    required this.frameType,
    required this.frameContainer,
  });
}

final List<Frame> frames = [
  Frame(
    frameType: 'Square',
    frameContainer: Container(
      height: 342,
      width: 342,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: const Color(0xffE6E6E6),
        ),
      ),
    ),
  ),
  Frame(
    frameType: 'Vertical',
    frameContainer: SizedBox(
      height: 420,
      width: 342,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color(0xffE6E6E6),
          ),
        ),
      ),
    ),
  ),
  Frame(
    frameType: 'Horizontal',
    frameContainer: SizedBox(
      height: 200,
      width: 342,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color(0xffE6E6E6),
          ),
        ),
      ),
    ),
  ),
];

class FrameContent extends StatelessWidget {
  const FrameContent({
    super.key,
    required this.frameType,
    required this.frameContainer,
  });

  final String frameType;
  final Widget frameContainer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [frameContainer, const Spacer()],
    );
  }
}
