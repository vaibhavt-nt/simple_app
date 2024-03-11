import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_app/Provider/provider.dart';
import 'package:simple_app/jsonModels/users.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Users? _user;

  Future<Users?> _loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');
    if (userJson == null) return null;
    return Users.fromJson(json.decode(userJson));
  }

  @override
  void initState() {
    super.initState();
    _loadUser().then((user) {
      if (user != null) {
        setState(() {
          _user = user;
        });
      }
    });
  }

  bool _passwordVisible = false;

  // _ProfileScreenState(Users? profile);
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
                        child:
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: ClipOval(
                            child: _user?.userPhoto == null
                                ? const Icon(Icons.account_circle)
                                : Image.file(File(_user!.userPhoto), fit: BoxFit.cover,),
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 300),
                            child: Text("Name",
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          SizedBox(
                            height: 70,
                            child: TextFormField(
                              // initialValue: '${_user?.userName ??''} ',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "username is required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: _user?.userName ?? '',
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 305),
                            child: Text("Email",
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          SizedBox(
                            height: 70,
                            child: TextFormField(
                              // initialValue: '${_user?.userEmail ??''} ',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "email is required";
                                }
                                return null;
                              },
                              // controller: emailController,
                              decoration: InputDecoration(
                                hintText: _user?.userEmail ?? '',
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 270),
                            child: Text("Password",
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          SizedBox(
                            height: 70,
                            child: TextFormField(
                              // initialValue: '${_user?.userPassword ??''} ',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "password is required";
                                }
                                return null;
                              },
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xFFEE4D86),
                                  ),
                                ),
                                hintText: _user?.userPassword ?? '',
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
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
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
                Consumer<UiProvider>(
                    builder: (context, UiProvider notifier, child) {
                  return TextButton(
                    onPressed: () {
                      notifier.logout(context);
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
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//  TextButton(
// onPressed: () {
// Navigator.pushReplacement(
// context,
// MaterialPageRoute(
// builder: (context) => const LoginPage(),
// ));
// },
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text("Log Out",
// style: GoogleFonts.montserrat(
// textStyle: const TextStyle(
// color: Colors.red,
// fontSize: 16,
// fontWeight: FontWeight.w500),
// )),
// const Icon(
// Icons.exit_to_app,
// color: Colors.red,
// )
// ],
// ),
// ),
