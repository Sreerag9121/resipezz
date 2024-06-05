import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:recipizz/services/database/hive/favorite/favorite_model.dart';

class FavoriteBoxes {
  static Box<FavoriteModel> getFavData() =>
      Hive.box<FavoriteModel>('favoriteBox');
}

class FavoriteCrud {
  Future<void> addFavorite({
    required String id,
  }) async {
    DocumentReference recipeReference =
        FirebaseFirestore.instance.collection('recipes').doc(id);

    DocumentSnapshot recipeSnapshot = await recipeReference.get();

    if (recipeSnapshot.exists) {
      Map<String, dynamic> recipeData = recipeSnapshot.data() as Map<String, dynamic>;
      String uniqueTime = DateTime.now().microsecondsSinceEpoch.toString();

      Box<FavoriteModel> favoriteBox = FavoriteBoxes.getFavData();

      await favoriteBox.put(
        uniqueTime,
        FavoriteModel(
          id: id,
          recipeName: recipeData['name'],
          serving: recipeData['serving'],
          duration: recipeData['timeRequired'],
          imagePath: recipeData['recipeImage'],
          ingredients: List<String>.from(recipeData['ingredient']),
          directions: List<String>.from(recipeData['directions']),
          description: recipeData['description'],
        ),
      );
    } else {
     
    }
  }

  Future<void> removeRecipe(int index) async {
    Box<FavoriteModel> favoriteBox = FavoriteBoxes.getFavData();
    await favoriteBox.deleteAt(index);
  }

  void removeFavorite({required id}) {}
}
