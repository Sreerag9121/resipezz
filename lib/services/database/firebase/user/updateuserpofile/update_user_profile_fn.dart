import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateProfile {
  final CollectionReference _profileRef =
      FirebaseFirestore.instance.collection('users');

  String usreImagePath = '';
  String userImageUrl = '';

   Future<String> updateImageUrl(
      String oldImageUrl, String updateImagePath) async {
    Reference referenceImageUpload =
        FirebaseStorage.instance.refFromURL(oldImageUrl);
    referenceImageUpload.putFile(File(updateImagePath));
    String imageUrl = await referenceImageUpload.getDownloadURL();
    return imageUrl;
  }

  Future<void> updateProfileFn(
      String catogoryUpdateController,
      String updateImage,
      String uid) async {
    DocumentReference updateUserProfile = _profileRef.doc(uid);
    String catName = catogoryUpdateController;

    Map<String, dynamic> dataToUpdate = {
      'userName': catName,
      'userImage': updateImage
    };
    await updateUserProfile.update(dataToUpdate);
  }

}
