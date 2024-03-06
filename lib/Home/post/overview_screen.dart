import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({super.key});

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const myPage(),
                    //   ),
                    // );
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Center(
                      child: Text(
                        "Button Name",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),

              //Here's my Scrollable widget
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black,
                        height: 400,
                        width: 300,
                      ),
                      Container(
                        color: Colors.purple,
                        height: 400,
                        width: 300,
                      ),
                      Container(
                        color: Colors.lightGreenAccent,
                        height: 400,
                        width: 300,
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 400,
                        width: 300,
                      )
                    ],
                  ),
                )
              ),

              //this is the same button used as above
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const myPage2(),
                    //   ),
                    // );
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Center(
                      child: Text(
                        "Button 2",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
