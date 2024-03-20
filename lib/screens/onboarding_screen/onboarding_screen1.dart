import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:simple_app/screens/authentication_screens/sign_up_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      skipStyle: ButtonStyle(
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 17)),
          foregroundColor: MaterialStateProperty.all(Colors.redAccent)),
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                    'assets/onboarding_image/onboarding_image_one.svg'),
                const SizedBox(height: 50),
                Text("Create Posts",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    )),
                Text(
                    "Lorem ipsum dolor sit amet consectetur. Purus tempor in in rhoncus quisque viverra amet. Nisl nam ut lobortis quam.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  'assets/onboarding_image/onboarding_image_two.svg'),
              const SizedBox(height: 20),
              Text("Schedule Posts",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  )),
              Text(
                  "Lorem ipsum dolor sit amet consectetur. Purus tempor in in rhoncus quisque viverra amet. Nisl nam ut lobortis quam.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  'assets/onboarding_image/onboarding_image_three.svg'),
              const SizedBox(height: 20),
              Text("Share Posts",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  )),
              Text(
                  "Lorem ipsum dolor sit amet consectetur. Purus tempor in in rhoncus quisque viverra amet. Nisl nam ut lobortis quam.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )),
            ],
          ),
        ),
      ],
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      // onChange: (val) {},
      skip: Text("Skip",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          )),
      next: const Icon(
        Icons.arrow_forward,
      ),
      done: Text("Finished",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                color: Color(0xFFEE4D86),
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )),
      onDone: () => _onIntroEnd(context),
      nextStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(const Color(0xFFEE4D86))),
      dotsDecorator: const DotsDecorator(
        size: Size.square(7),
        activeColor: Color(0xFFEE4D86),
        activeSize: Size.square(17),
      ),
    );
  }
}
