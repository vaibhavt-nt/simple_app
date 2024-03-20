import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/navigation_screen/bottom_navigation_screen.dart';

class OverViewScreenWhenSkipButtonPressed extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final String imageUrl;
  final String enteredText;
  OverViewScreenWhenSkipButtonPressed(
      {super.key,
      required this.containerHeight,
      required this.containerWidth,
      required this.imageUrl,
      required this.enteredText});

  //for storing image in firebase storage
  final firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser;

  void onSubmitButton() async {
    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    var storageRef =
        FirebaseStorage.instance.ref().child('post_images/$imageName.jpg');
    var uploadTask = storageRef.putFile(imageUrl as File);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();

    //add users details in  firestore
    await firestore.collection("Post Data").doc().set({
      "createdAt": DateTime.now(),
      "Schedule Date": '',
      "Schedule Time": '',
      "Platform": '',
      "Caption": enteredText,
      "userId": userId?.uid,
      "userEmail": userId?.email,
      "userName": userId?.displayName,
      // Add image reference to document
      "Image": downloadUrl.toString()
    });
    Navigator.pushReplacement(
        context as BuildContext,
        MaterialPageRoute(
          builder: (context) => const BottomNavigationBarScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Gap(
                        height: 50,
                      ),
                      Stack(alignment: Alignment.center, children: [
                        // Display the container image
                        SizedBox(
                          height: containerHeight,
                          width: containerWidth,
                          child: imageUrl.isNotEmpty
                              ? Image.asset(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                )
                              : const Text(
                                  'Container',
                                  style: TextStyle(fontSize: 20),
                                ),
                        ),
                        // Display the entered text
                        Positioned.fill(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                color: Colors.white,
                                child: Text(
                                  enteredText,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                surfaceTintColor: Colors.white,
                                shadowColor: Colors.white,
                                backgroundColor:
                                    Colors.white, //background color of button
                                side: const BorderSide(
                                    width: 2,
                                    color: CustomColors
                                        .pink), //border width and color
                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              onPressed: () {},
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.file_download_outlined,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                    Text('Download',
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.black),
                                        )),
                                    // Icon(Icons.file_download_outlined),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                surfaceTintColor: Colors.white,
                                shadowColor: Colors.white,
                                backgroundColor:
                                    Colors.white, //background color of button
                                side: const BorderSide(
                                    width: 2,
                                    color: CustomColors
                                        .pink), //border width and color
                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              onPressed: () {},
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      size: 15,
                                      Icons.share_outlined,
                                      color: Colors.black,
                                    ),
                                    Text('    Share',
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.black),
                                        )),
                                    // Icon(Icons.file_download_outlined),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 342,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomColors.pink),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                ),
                onPressed: () {
                  onSubmitButton();
                },
                child: Text('Go to home',
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
    );
  }
}
