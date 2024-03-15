// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_app/Home/post/select_frame_screen.dart';
import 'package:simple_app/Home/post/select_caption_screen.dart';

class SelectImageScreen extends StatefulWidget {
  const SelectImageScreen({super.key, required this.selectedFrame});
  final Frame selectedFrame;

  @override
  State<SelectImageScreen> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
  final List<String> _imageAssets = [
    'assets/SelectImagePost/image1.png',
    'assets/SelectImagePost/image1.png',
    'assets/SelectImagePost/image1.png',
    'assets/SelectImagePost/image1.png',
    'assets/SelectImagePost/image1.png',
  ];

  // final FrameContent frame;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.2,
              lineHeight: 8.0,
              percent: 0.50,
              barRadius: const Radius.circular(20),
              progressColor: const Color(0xffED4D86),
              backgroundColor: const Color(0xffE6E6E6),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios)),
                  Padding(
                    padding: const EdgeInsets.only(right: 150),
                    child: Text(
                      'Step 2',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xff1C1C1C)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Select your post background image.',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xff1C1C1C)),
                        ),
                      ),
                    ),
                  ),
                  Center(child: widget.selectedFrame.frameContainer),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _imageAssets.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {});
                            },
                            child: Image.asset(
                              _imageAssets[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectCaptionScreen(),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 342,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  color: Color(0xffED4D86),
                ),
                child: Center(
                  child: Text('Next',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xffFFFFFC)),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePickerBottomSheet extends StatefulWidget {
  final Function(XFile) onImageSelected;
  final List<String> imageAssets;

  const ImagePickerBottomSheet(
      {required this.onImageSelected, required this.imageAssets, super.key});

  @override
  _ImagePickerBottomSheetState createState() => _ImagePickerBottomSheetState();
}

class _ImagePickerBottomSheetState extends State<ImagePickerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.imageAssets.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                widget.onImageSelected(pickedFile);
                Navigator.pop(context);
              }
            },
          );
        } else {
          final int assetIndex = index - 1;
          return ListTile(
            leading: Image.asset(widget.imageAssets[assetIndex], width: 50),
            title: Text(widget.imageAssets[assetIndex]),
            onTap: () {
              widget.onImageSelected(XFile(widget.imageAssets[assetIndex]));
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
