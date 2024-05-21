import 'package:cloud_firestore/cloud_firestore.dart';

class TodaySpecialCurd{
  final CollectionReference _todaySpecialRef=FirebaseFirestore.instance.collection('today_special');
  
  Future<void>addTodaySpecial({required String recipeId})async{
    Map<String,String>dataToSend={
      'TodaySpecial':recipeId,
    };
    await _todaySpecialRef.doc('todaySpecialId').set(dataToSend);
  }

  Future<void>updateTodaySpecial({required String recipeId})async{
    DocumentReference updateTodaySpecial=_todaySpecialRef.doc('todaySpecialId');
    Map<String,String>dataToSend={
     'TodaySpecial':recipeId,
    };
  await updateTodaySpecial.update(dataToSend);
  }

}