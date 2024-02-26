import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/home_screen.dart';
import 'package:simple_app/login_screen.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    Text("Signup",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(height: 30.0),
                    Container(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        child: Image.asset(
                            'assets/sign_up_images/image_picker.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Add your profile photo",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 300),
                          child: Text("Name",
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                        SizedBox(
                          height: 50,
                          child: TextField(

                            controller: usernameController,
                            decoration: InputDecoration(
                              hintText: "Enter your name",
                              hintStyle: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid, width: 1)),
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
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                        SizedBox(
                          height: 50,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Enter your email",
                              hintStyle: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid, width: 1)),
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
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                        SizedBox(
                          height: 50,
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              hintStyle: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid, width: 1)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                      },
                      child: Text("Signup",
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Color(0xFFEE4D86)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account?",
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                        child: Text("Login",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Color(0xFFEE4D86),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
