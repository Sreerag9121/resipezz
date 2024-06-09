
import 'package:cloud_firestore/cloud_firestore.dart';

class TodaySpecialCurd {
  final CollectionReference _todaySpecialRef =
      FirebaseFirestore.instance.collection('today_special');

  Future<void> addTodaySpecial({required String recipeId,
   required String recipeName,
    required String recipeImage,
    required String timeReqd,
    required String serving,
    required List<dynamic> ingredient,
    required List<dynamic> directions,
    required String description,}) async {
    Map<String, dynamic> dataToSend = {
      'TodaySpecial': recipeId,
       'name': recipeName,
      'serving': serving,
      'timeRequired': timeReqd,
      'recipeImage': recipeImage,
      'ingredient': ingredient,
      'directions': directions,
      'description': description,
    };
    await _todaySpecialRef.doc('today_special').set(dataToSend);
  }

  Future<void> updateTodaySpecial({
    required String recipeId,
    required String recipeName,
    required String recipeImage,
    required String timeReqd,
    required String serving,
    required List<dynamic> ingredient,
    required List<dynamic> directions,
    required String description,
  }) async {
    DocumentReference updateTodaySpecial =
        _todaySpecialRef.doc('today_special');
    Map<String, dynamic> dataToSend = {
      'TodaySpecial': recipeId,
      'name': recipeName,
      'serving': serving,
      'timeRequired': timeReqd,
      'recipeImage': recipeImage,
      'ingredient': ingredient,
      'directions': directions,
      'description': description,
    };
    await updateTodaySpecial.update(dataToSend);
  }
}
