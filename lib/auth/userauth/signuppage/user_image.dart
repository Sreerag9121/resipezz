import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipizz/utils/app_theme.dart';

class AddUserImage extends StatefulWidget {
  final Function(String?) onImageSelectedResipe;
  const AddUserImage({
    super.key,
    required this.onImageSelectedResipe,
  });

  @override
  State<AddUserImage> createState() => _AddUserImageState();
}

class _AddUserImageState extends State<AddUserImage> {
  String? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image != null?
        CircleAvatar(
          radius: 60,
          backgroundImage: FileImage(File(image!,)),
        )
            : CircleAvatar(
                backgroundColor: AppTheme.colors.shadecolor,
                radius: 60,
                child: Icon(
                  Icons.person,
                  color:AppTheme.colors.appBlackColor,
                  size: 100,
                ),
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
                                  Text(
                                    'CAMERA',
                                    style: TextStyle(
                                        fontFamily: AppTheme.fonts.jost),
                                  )
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
                                  Text(
                                    'GALLERY',
                                    style: TextStyle(
                                        fontFamily: AppTheme.fonts.jost),
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

  bool validateImage() {
    if (image == null || image!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please select an image',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppTheme.colors.appRedColor,
        ),
      );
      return false;
    }
    return true;
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(
      () {
        image = returnedImage.path;
        widget.onImageSelectedResipe(image);
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
        widget.onImageSelectedResipe(image);
      },
    );
  }
}
