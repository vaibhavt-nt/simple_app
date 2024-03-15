// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_app/Authentication/login_screen.dart';
import 'package:simple_app/Firebase/firebase_authentication.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userName = TextEditingController();
  final userEmail = TextEditingController();

  void pickImage() async {
    // pick image from gallery, change ImageSource.camera if you want to capture image from camera.
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  final ImagePicker _picker = ImagePicker();
  File? _image;

  //for storing image in firebase storage
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  void onSubmitButton() async {
    // var imageName =
    // DateTime.now().millisecondsSinceEpoch.toString();
    // var storageRef = FirebaseStorage.instance
    //     .ref()
    //     .child('post_images/$imageName.jpg');
    // var uploadTask = storageRef.putFile(_image);
    // var downloadUrl =
    // await (await uploadTask).ref.getDownloadURL();

    //add users details in  firestore
    await firestore.collection("Post Data").doc().update({
      "createdAt": DateTime.now(),
      "userId": user?.uid,
      "userName": user?.displayName,
      // Add image reference to document
      // "Image": downloadUrl.toString()
    });
    Get.showSnackbar(const GetSnackBar(
      title: 'Updated Successfully',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    Text("Profile",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(height: 30.0),
                    GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: GestureDetector(
                              onTap: () {
                                pickImage();
                              },
                              child: Center(
                                  child:SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage("${user!.photoURL}"),
                                    ),
                                  ))
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Edit your profile photo",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name",
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )),
                          SizedBox(
                            height: 70,
                            child: TextFormField(
                              controller: userName,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "username is required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: '${user!.displayName}',
                                hintStyle: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFEE4D86))),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )),
                          SizedBox(
                            height: 70,
                            child: TextFormField(
                              controller: userEmail,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "email is required";
                                }
                                return null;
                              },
                              // controller: emailController,
                              decoration: InputDecoration(
                                hintText: '${user!.email}',
                                hintStyle: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFEE4D86))),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 70, left: 3),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: const Color(0xFFEE4D86)),
                      child: Text("Update",
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                    )),
                TextButton(
                  onPressed: () {
                    FirebaseAuthentication.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Log Out",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )),
                      const Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      )
                    ],
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
