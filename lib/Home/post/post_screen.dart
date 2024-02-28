import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:simple_app/Home/post/frame_screen.dart';
import 'package:simple_app/colors.dart';

// class Post_Screen extends StatefulWidget {
//   const Post_Screen({Key? key}) : super(key: key);
//
//   @override
//   _Post_ScreenState createState() => _Post_ScreenState();
// }
//
// class _Post_ScreenState extends State<Post_Screen> {
//   // we have initialized active step to 0 so that
//   // our stepper widget will start from first step
//   int _activeCurrentStep = 0;
//
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController pass = TextEditingController();
//   TextEditingController address = TextEditingController();
//   TextEditingController pincode = TextEditingController();
//
//   // Here we have created list of steps
//   // that are required to complete the form
//   List<Step> stepList() => [
//         // This is step1 which is called Account.
//         // Here we will fill our personal details
//         Step(
//           state:
//               _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
//           isActive: _activeCurrentStep >= 0,
//           title: const Text(''),
//           content: Container(
//             child: Column(
//               children: [
//                 TextField(
//                   controller: name,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Full Name',
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 TextField(
//                   controller: email,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 TextField(
//                   controller: pass,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // This is Step2 here we will enter our address
//         Step(
//             state: _activeCurrentStep <= 1
//                 ? StepState.editing
//                 : StepState.complete,
//             isActive: _activeCurrentStep >= 1,
//             title: const Text(''),
//             content: Container(
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   TextField(
//                     controller: address,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Full House Address',
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   TextField(
//                     controller: pincode,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Pin Code',
//                     ),
//                   ),
//                 ],
//               ),
//             )),
//
//         // This is Step3 here we will display all the details
//         // that are entered by the user
//         Step(
//             state: StepState.complete,
//             isActive: _activeCurrentStep >= 2,
//             title: const Text(''),
//             content: Container(
//                 child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text('Name: ${name.text}'),
//                 Text('Email: ${email.text}'),
//                 Text('Password: ${pass.text}'),
//                 Text('Address : ${address.text}'),
//                 Text('PinCode : ${pincode.text}'),
//               ],
//             )))
//       ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Here we have initialized the stepper widget
//       body: Stepper(
//         connectorColor: MaterialStatePropertyAll(Custom_Colors.pink),
//
//         type: StepperType.horizontal,
//         currentStep: _activeCurrentStep,
//         steps: stepList(),
//
//         // onStepContinue takes us to the next step
//         onStepContinue: () {
//           if (_activeCurrentStep < (stepList().length - 1)) {
//             setState(() {
//               _activeCurrentStep += 1;
//             });
//           }
//         },
//
//         // onStepCancel takes us to the previous step
//         onStepCancel: () {
//           if (_activeCurrentStep == 0) {
//             return;
//           }
//
//           setState(() {
//             _activeCurrentStep -= 1;
//           });
//         },
//
//         // onStepTap allows to directly click on the particular step we want
//         onStepTapped: (int index) {
//           setState(() {
//             _activeCurrentStep = index;
//           });
//         },
//       ),
//     );
//   }
// }

class Post_Screen extends StatefulWidget {
  const Post_Screen({super.key});

  @override
  State<Post_Screen> createState() => _Post_ScreenState();
}

class _Post_ScreenState extends State<Post_Screen> {
  @override
  Widget build(BuildContext context) {
    var currentStep = 1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              LinearProgressBar(
                maxSteps: 4,
                progressType: LinearProgressBar.progressTypeLinear,
                currentStep: currentStep,
                progressColor: Custom_Colors.pink,
                backgroundColor: Colors.black12,
                valueColor: AlwaysStoppedAnimation<Color>(Custom_Colors.pink),
                semanticsLabel: "Label",
                semanticsValue: "Value",
                minHeight: 8,
              ),
              SizedBox(
                height: 20,
              ),
              CustomText_16_600(text: 'Step 1'),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: CustomText_16_400(text: 'Select your post frame.')),
              SizedBox(
                height: 20,
              ),
              Frame(),
              ElevatedButton(
                onPressed: () {},
                child: CustomText_16_600(text: 'Next'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
