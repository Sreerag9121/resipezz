import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipizz/utils/app_theme.dart';

class UpdateMyRecipeImage extends StatefulWidget {
  final Function(String?) onImageSelected;
  final String? oldImages;
  const UpdateMyRecipeImage({
    super.key,
    required this.onImageSelected,
    this.oldImages,
  });

  @override
  State<UpdateMyRecipeImage> createState() => _UpdateMyRecipeImageState();
}

class _UpdateMyRecipeImageState extends State<UpdateMyRecipeImage> {
  late String? image;
  @override
  void initState() {
    image = widget.oldImages;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Image.file(File(image!),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover),
        ),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Choos Profile Photo',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Column(
                                children: [
                                  //camera icon

                                  IconButton(
                                    onPressed: () {
                                      _pickImageFromCamera();
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.camera,
                                      size: 70.0,
                                    ),
                                  ),
                                  Text('CAMERA',
                                  style: TextStyle(
                                    color: AppTheme.colors.appBlackColor,
                                    fontFamily: AppTheme.fonts.jost
                                  ),)
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 70,
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  //gallery icon

                                  IconButton(
                                    onPressed: () {
                                      _pickImageFromGallery();
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.photo,
                                      size: 70.0,
                                    ),
                                  ),
                                  Text('GALLERY',
                                  style: TextStyle(
                                    color: AppTheme.colors.appBlackColor,
                                    fontFamily: AppTheme.fonts.jost
                                  ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            });
          },
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: AppTheme.colors.appButtonColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text("Add Photo",
                  style: TextStyle(
                    color: AppTheme.colors.appWhiteColor,
                  )),
            ),
          ),
        ),
      ],
    );
  }

//pick Image From gallery
  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(
      () {
        image = returnedImage.path;
        widget.onImageSelected(image);
      },
    );
  }

//pick Image From Camera
  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(
      () {
        image = returnedImage.path;
        widget.onImageSelected(image);
      },
    );
  }
}
