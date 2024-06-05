import 'package:hive/hive.dart';
import 'package:recipizz/services/database/hive/cart/cart_model.dart';
import 'package:recipizz/services/database/hive/favorite/favorite_model.dart';
import 'package:recipizz/services/database/hive/my_recipes/my_recipe_model.dart';

late Box recipeBox;
late Box favoriteBox;
late Box cartBox;

Future<void> openBoxHive() async {
  //open Box  my recipes
  Hive.registerAdapter(RecipeModelAdapter());
  recipeBox = await Hive.openBox<RecipeModel>('recipeBox');
  //open Box favorite
  Hive.registerAdapter(FavoriteModelAdapter());
  favoriteBox=await Hive.openBox<FavoriteModel>('favoriteBox');
  //open Box cart
  Hive.registerAdapter(CartModelAdapter());
  cartBox=await Hive.openBox<CartModel>('cartBox');

}