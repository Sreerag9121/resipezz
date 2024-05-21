import 'package:hive/hive.dart';
import 'package:recipizz/services/functions/hive/favorite_model.dart';
import 'package:recipizz/services/functions/hive/hive_open_box.dart';

class FavoriteBoxes {
  static Box<FavoriteModel> getFavData() =>
      Hive.box<FavoriteModel>('favoriteBox');
}

class FavoriteCrud {
  Future<void> addFavorite({
    required String id,
    required String recipeName,
    required String serving,
    required String timeRequired,
    required String description,
    required String imagePath,
    required List<String> ingredient,
    required List<String> directions,
  }) async {
    String uniqueTime = DateTime.now().microsecondsSinceEpoch.toString();
    await favoriteBox.put(
        uniqueTime,
        FavoriteModel(
            id: id,
            recipeName: recipeName,
            serving: serving,
            duration:timeRequired,
            imagePath: imagePath,
            ingredients: ingredient,
            directions: directions,
            description: description));
  }

  Future<void> removeRecipe(int index) async {
    await favoriteBox.deleteAt(index);
  }
}
