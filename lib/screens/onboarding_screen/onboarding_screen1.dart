import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/authentication_screens/sign_up_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    const _Page(
      imagePath: 'assets/onboarding_image/onboarding_image_one.svg',
      title: 'Create Posts',
      description:
          'Lorem ipsum dolor sit amet consectetur.\n Purus tempor in in rhoncus quisque\nviverra amet. Nisl nam ut lobortis quam.',
    ),
    const _Page(
      imagePath: 'assets/onboarding_image/onboarding_image_two.svg',
      title: 'Schedule Posts',
      description:
          'Lorem ipsum dolor sit amet consectetur.\nPurus tempor in in rhoncus quisque\nviverra amet. Nisl nam ut lobortis quam.',
    ),
    const _Page(
      imagePath: 'assets/onboarding_image/onboarding_image_three.svg',
      title: 'Share Posts',
      description:
          'Lorem ipsum dolor sit amet consectetur.\nPurus tempor in in rhoncus quisque\nviverra amet. Nisl nam ut lobortis quam.',
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onDoneTapped() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  _pageController.animateToPage(
                    _pages.length - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                child: Text('Skip',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: CustomColors.darkGrey),
                    )),
              ),
            ),
            Gap(height: 20.spMin,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 600.h,
                      width:342.w ,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _pages.length,
                        onPageChanged: _onPageChanged,
                        itemBuilder: (context, index) {
                          return _pages[index];
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < _pages.length; i++)
                      Container(
                        width: 10.w,
                        height: _currentPage == i ? 17 : 7,
                        margin: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 10.w),
                        decoration: BoxDecoration(
                          color: _currentPage == i
                              ? const Color(0xFFEE4D86)
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                _currentPage < _pages.length - 1
                    ? GestureDetector(
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    height: 40.w,
                    width: 342.w,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color: Color(0xffED4D86),
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
                )
                    : GestureDetector(
                  onTap: _onDoneTapped,
                  child: Container(
                    height: 40.w,
                    width: 342.w,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color: Color(0xffED4D86),
                    ),
                    child: Center(
                      child: Text('Finished',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: const Color(0xffFFFFFC)),
                          )),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: _currentPage != 0
                        ? Text('Back',
                        style: GoogleFonts.montserrat(
                          textStyle:  TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: CustomColors.pink),
                        ))
                        : const SizedBox()
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const _Page({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 342.h, width: 342.w, child: SvgPicture.asset(imagePath)),
        SizedBox(height: 30.spMin),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            textStyle:  TextStyle(
                color: Colors.black, fontSize: 24.sp, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 20.spMin),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
                color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
