// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/custom_widgets/snack_bar.dart';
import 'package:simple_app/screens/authentication_screens/login_screen.dart';
import 'package:simple_app/services/firebase_service/firebase_authentication.dart';
import 'package:simple_app/services/image_picker_service.dart';

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

  bool isUpdating = false;

  //for validation
  final _formKey = GlobalKey<FormState>();

  File? _image;

  //for storing image in firebase storage
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Select Image'),
                                      content: const Text('Choose an option'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Gallery'),
                                          onPressed: () {
                                            PickImage.pickImageFromGallery(
                                                (image) {
                                              if (image != null) {
                                                setState(() {
                                                  _image = image;
                                                });
                                              }
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Camera'),
                                          onPressed: () {
                                            PickImage.pickImageFromCamera(
                                                (image) {
                                              if (image != null) {
                                                setState(() {
                                                  _image = image;
                                                });
                                              }
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Center(
                                  child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  backgroundImage: _image != null
                                      ? FileImage(_image!) as ImageProvider
                                      : NetworkImage(user!.photoURL ?? ''),
                                ),
                              ))),
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
                          TextFormField(
                            controller: userName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "username is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 10.0),
                              hintText: user!.displayName,
                              hintStyle: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFEE4D86))),
                              border: const OutlineInputBorder(),
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
                          TextFormField(
                            initialValue: '${user?.email}',
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 10.0),
                              hintText: '${user!.email}',
                              hintStyle: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFEE4D86))),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(
                  height: 110,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        setState(() {
                          isUpdating = true;
                        });

                        // Get the updated name and photo from the form
                        String updatedName = userName.text;
                        String? updatedPhoto = _image != null
                            ? await PickImage.uploadProfileImage(_image!)
                            : user!.photoURL;

                        // Call the updateUser method from FirebaseAuthentication
                        User? updatedUser =
                            await FirebaseAuthentication.updateUser(
                                name: updatedName, photo: updatedPhoto!);

                        if (updatedUser != null) {
                          // Update the state to reflect the changes
                          setState(() {
                            user = updatedUser;
                            isUpdating = false;
                          });

                          CustomSnackBar.showSuccessSnackBar(
                            context,
                            'Profile updated successfully',
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        backgroundColor: isUpdating
                            ? CustomColors.lightGrey
                            : const Color(0xFFEE4D86)),
                    child: isUpdating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : Text("Update",
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )),
                  ),
                ),
                const Gap(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      CustomSnackBar.showSuccessSnackBar(
                          context, 'Logout Successfully');
                      FirebaseAuthentication.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: CustomColors.pink),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                    ),
                    child: Text("Logout",
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: CustomColors.darkGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
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
