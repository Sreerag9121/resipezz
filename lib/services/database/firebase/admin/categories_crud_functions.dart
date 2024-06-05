import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CategoriesCrud {
  final CollectionReference _categoriesReference =
      FirebaseFirestore.instance.collection('categories');

  String imagePath = '';
  String imageUrl = '';

  Future<void> addCategoriesMethod(TextEditingController catogoryController,
      String imagePath, BuildContext context) async {
    Reference categoriesImageRef = FirebaseStorage.instance.ref();
    Reference referenceDirImage = categoriesImageRef.child('categories_images');
    String uniqueTime = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceImageUpload = referenceDirImage.child(uniqueTime);
    try {
      await referenceImageUpload.putFile(File(imagePath));
      imageUrl = await referenceImageUpload.getDownloadURL();
      String categoriesName = catogoryController.text;
      Map<String, String> dataToSend = {
        'categoriesName': categoriesName,
        'image': imageUrl,
        'datetime': uniqueTime,
      };
      await _categoriesReference.add(dataToSend);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> deleteCategories(String id) async {
    DocumentReference deleteCategories = _categoriesReference.doc(id);
    deleteCategories.delete();
  }

  Future<void> deleteImage(String deleteImageUrl) async {
    Reference reference = FirebaseStorage.instance.refFromURL(deleteImageUrl);
    await reference.delete();
  }

  Future<String> updateImageUrl(
      String oldImageUrl, String updateImagePath) async {
    Reference referenceImageUpload =
        FirebaseStorage.instance.refFromURL(oldImageUrl);
    referenceImageUpload.putFile(File(updateImagePath));
    String imageUrl = await referenceImageUpload.getDownloadURL();
    return imageUrl;
  }

  Future<void> updateCategoriesFn(
      TextEditingController catogoryUpdateController,
      String updateImage,
      BuildContext context,
      String id) async {
    DocumentReference updateCategories = _categoriesReference.doc(id);
    String catName = catogoryUpdateController.text;

    Map<String, dynamic> dataToUpdate = {
      'categoriesName': catName,
      'image': updateImage
    };
    await updateCategories.update(dataToUpdate);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
