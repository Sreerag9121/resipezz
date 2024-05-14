import 'package:hive/hive.dart';
import 'package:recipizz/services/functions/hive/recipes_hive.dart';

late Box recipeBox;


Future<void> openBoxHive() async {
  Hive.registerAdapter(RecipeModelAdapter());
  recipeBox = await Hive.openBox<RecipeModel>('recipeBox');
}