import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_app/constants/colors.dart';
import 'package:simple_app/custom_widgets/gap.dart';
import 'package:simple_app/screens/post_screens/select_caption_screen.dart';
import 'package:simple_app/services/image_picker_service.dart';

class SelectImageScreen extends StatefulWidget {
  final double height;
  final double width;
  SelectImageScreen({super.key, required this.height, required this.width});

  final List<String> imageUrls = [];
  String? selectedImageUrl;

  @override
  State<SelectImageScreen> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
  void showImagePicker(
    BuildContext context,
    Function(File?) onImagePicked,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                await PickImage.pickImageFromCamera(onImagePicked);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                await PickImage.pickImageFromGallery(onImagePicked);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.selectedImageUrl ??= '';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          children: [
            const Gap(
              height: 20,
            ),
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
                    Container(
                      height: widget.height,
                      width: widget.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: widget.selectedImageUrl!.isNotEmpty
                            ? Image.file(
                                File(widget.selectedImageUrl!),
                                fit: BoxFit.cover,
                                width: widget.width,
                                height: widget.height,
                              )
                            : const Text(
                                'Select Image',
                                style: TextStyle(fontSize: 20),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    //Horizontal gallery of images
                    SizedBox(
                      height: 100, // Adjust height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.imageUrls.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  showImagePicker(context, (selectedFile) {
                                    if (selectedFile != null) {
                                      setState(() {
                                        final String newUrl = selectedFile.path;
                                        widget.selectedImageUrl = newUrl;
                                        widget.imageUrls.add(newUrl);
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color: CustomColors.lightGrey,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 50,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            final int assetIndex = index - 1;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.selectedImageUrl =
                                        widget.imageUrls[assetIndex];
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                  ),
                                  child: Image.file(
                                    File(widget.imageUrls[assetIndex]),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectCaptionScreen(
                      containerHeight: widget.height,
                      containerWidth: widget.width,
                      imageUrl: widget.selectedImageUrl!,
                    ),
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
