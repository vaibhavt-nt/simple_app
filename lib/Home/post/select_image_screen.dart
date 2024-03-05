// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    'assets/SelectImagePost/image1.svg',
    'assets/SelectImagePost/image2.svg',
    'assets/SelectImagePost/image3.svg',
    'assets/SelectImagePost/image1.svg',
  ];
  XFile? _image;

  // final FrameContent frame;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            children: [
              LinearPercentIndicator(
                width: 342.0,
                lineHeight: 8.0,
                percent: 0.50,
                barRadius: const Radius.circular(20),
                progressColor: const Color(0xffED4D86),
                backgroundColor: const Color(0xffE6E6E6),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
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
              Center(
                child: _image == null
                    ? widget.selectedFrame.frameContainer
                    : _image!.path.startsWith('assets/')
                        ? Image.asset(
                            _image!.path,
                            fit: BoxFit.fill,
                          )
                        : Image.file(File(_image!.path)),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _imageAssets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _image = XFile(_imageAssets[index]);
                          });
                        },
                        child: SvgPicture.asset(
                          _imageAssets[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: GestureDetector(
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
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _getImage,
      //   tooltip: 'Pick Image',
      //   child: const Icon(Icons.add_a_photo),
      // ),
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
