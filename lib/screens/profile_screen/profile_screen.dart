// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/custom_widgets/custom_texfeild.dart';
import 'package:simple_app/custom_widgets/snack_bar.dart';
import 'package:simple_app/screens/authentication_screens/login_screen.dart';
import 'package:simple_app/services/firebase_service/firebase_authentication.dart';
import 'package:simple_app/services/image_picker_service.dart';
import 'package:simple_app/services/validations.dart';

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
            padding: EdgeInsets.all(10.0.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60.0.h,
                    ),
                    Text("Profile",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 32.r,
                              fontWeight: FontWeight.w600),
                        )),
                    SizedBox(height: 30.0.h),
                    GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: SizedBox(
                          height: 100.h,
                          width: 100.w,
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
                                height: 100.h,
                                width: 100.w,
                                child: CircleAvatar(
                                  backgroundImage: _image != null
                                      ? FileImage(_image!) as ImageProvider
                                      : NetworkImage(user!.photoURL ?? ''),
                                ),
                              ))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                      width: 183.w,
                    ),
                    Text("Edit your profile photo",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.r,
                              fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.r),
                            child: Text("Name",
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          NameEmailInputField(
                            controller: userName,
                            enterText: user!.displayName,
                            validator: Validation.validateName,
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.r),
                            child: Text("Email",
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          NameEmailInputField(
                              controller: userEmail, enterText: user!.email)
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(
                  height: 110.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.r),
                  child: SizedBox(
                    width: 342.w,
                    height: 40.h,
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
                              borderRadius: BorderRadius.circular(10.w)),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 16.w),
                          backgroundColor: isUpdating
                              ? CustomColors.lightGrey
                              : const Color(0xFFEE4D86)),
                      child: isUpdating
                          ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2.w, color: Colors.white),
                            )
                          : Text("Update",
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.r,
                                    fontWeight: FontWeight.w600),
                              )),
                    ),
                  ),
                ),
                Gap(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.r),
                  child: SizedBox(
                    width: 342.w,
                    height: 40.h,
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
                            borderRadius: BorderRadius.circular(10.w)),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.w, horizontal: 16.w),
                      ),
                      child: Text("Logout",
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: CustomColors.darkGrey,
                                fontSize: 16.r,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
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
