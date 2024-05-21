import 'package:hive/hive.dart';
import 'package:recipizz/services/functions/hive/cart_model.dart';
import 'package:recipizz/services/functions/hive/favorite_model.dart';
import 'package:recipizz/services/functions/hive/recipes_hive.dart';

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