import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/Navigation/bnb_screen.dart';
import 'package:simple_app/colors.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({super.key});

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
//for storing image in firebase storage
  final firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser;

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
    await firestore.collection("Post Data").doc().set({
      "createdAt": DateTime.now(),
      "Schedule Date": '31 October 2024',
      "Schedule Time": '10:00 PM',
      "Platform": 'Instagram',
      "Caption": 'This is my caption',
      "userId": userId?.uid,
      "userEmail": userId?.email,
      "userName": userId?.displayName,
      // Add image reference to document
      // "Image": downloadUrl.toString()
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BNBScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 60, 20, 10),
          child: Center(
            child: Column(
              children: [
                Stack(alignment: Alignment.center, children: [
                  const SizedBox(
                      height: 342,
                      width: 342,
                      child: Image(
                          image:
                              AssetImage('assets/SelectImagePost/image1.png'))),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 237,
                    width: 237,
                    child: Center(
                      child: Text(
                          'Lorem ipsum dolor sit\n'
                          'amet consectetur.\n'
                          'Senectus eleifend purus\n'
                          'viverra placerat\n'
                          'pellentesque ac et\n'
                          'commodo. Viverra tellus\n'
                          'risus arcu integer justo\n'
                          'malesuada in urna\n'
                          'enim.',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black),
                          )),
                    ),
                  )
                ]),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Post Schedule',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        width: 342,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: CustomColors.pink)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('31 October 2001',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black),
                                  )),
                              const Icon(Icons.date_range_outlined)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        width: 342,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: CustomColors.pink)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('01 : 08 PM',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black),
                                  )),
                              const Icon(Icons.watch_later_outlined)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        width: 342,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: CustomColors.pink)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Facebook',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black),
                                  )),
                              const Icon(Icons.facebook)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 342,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(CustomColors.pink),
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
        ),
      ),
    );
  }
}
