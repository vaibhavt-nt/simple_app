import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:simple_app/Home/post/frame_screen.dart';
import 'package:simple_app/colors.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    var currentStep = 1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              LinearProgressBar(
                maxSteps: 4,
                progressType: LinearProgressBar.progressTypeLinear,
                currentStep: currentStep,
                progressColor: CustomColors.pink,
                backgroundColor: Colors.black12,
                valueColor: const AlwaysStoppedAnimation<Color>(CustomColors.pink),
                semanticsLabel: "Label",
                semanticsValue: "Value",
                minHeight: 8,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomText16600(text: 'Step 1'),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: CustomText16400(text: 'Select your post frame.')),
              const SizedBox(
                height: 20,
              ),
              const Frame(),
              ElevatedButton(
                onPressed: () {},
                child: CustomText16600(text: 'Next'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
