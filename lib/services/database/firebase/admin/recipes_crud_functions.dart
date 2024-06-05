import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class RecipesCurdOp {
  final CollectionReference _recipeReferance =
      FirebaseFirestore.instance.collection('recipes');

  String recipeImageUrl = '';

  Future<void> addRecipeMethod({
     required TextEditingController recipeNameController,
     required TextEditingController servingController,
    required  String timeRequiredController,
     required TextEditingController descriptionController,
     required String recipeImagePath,
     required List<TextEditingController> recipeIngredients,
     required List<TextEditingController> recipeDirection,
     required String categoresTagController,
     required BuildContext context}) async {
    List<String> recipeIngredientList = [];
    List<String> recipeDirectionList = [];
    Reference recipeImageRef =
        FirebaseStorage.instance.ref().child('recipe_image');
    String uniqueTime = DateTime.now().microsecondsSinceEpoch.toString();
    Reference recipeImageUpload = recipeImageRef.child(uniqueTime);
    try {
      await recipeImageUpload.putFile(File(recipeImagePath));
      recipeImageUrl = await recipeImageUpload.getDownloadURL();
      String recipeName = recipeNameController.text;
      String serving = servingController.text;
      String timeReqd = timeRequiredController;
      String categoriesTag = categoresTagController;
      String descriptions=descriptionController.text;
      recipeIngredientList.clear();
      for (var controllers in recipeIngredients) {
        recipeIngredientList.add(controllers.text);
      }
      for (var controllers in recipeDirection) {
        recipeDirectionList.add(controllers.text);
      }

      Map<String, dynamic> dataTosend = {
        'dateTime': uniqueTime,
        'name': recipeName,
        'serving': serving,
        'timeRequired': timeReqd,
        'recipeImage': recipeImageUrl,
        'ingredient': recipeIngredientList,
        'directions': recipeDirectionList,
        'description':descriptions,
        'categoriesTag': categoriesTag
      };
      await _recipeReferance.add(dataTosend);
    } catch (e) {
       ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No images: $e')));
    }
  }

  Future<void> deleteRcipes(String id) async {
    DocumentReference deleteRecipes = _recipeReferance.doc(id);
    await deleteRecipes.delete();
  }

  Future<void>deleteRecipeImage(String imageUrl)async{
    Reference imageReference = FirebaseStorage.instance.refFromURL(imageUrl);
    await imageReference.delete();
  }
}
