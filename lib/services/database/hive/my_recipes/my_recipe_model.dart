import 'package:hive/hive.dart';
part 'my_recipe_model.g.dart';



@HiveType(typeId: 1)
 class RecipeModel{
  RecipeModel({
    required this.recipeName,
    required this.serving,
    required this.duration,
    required this.imagePath,
    required this.ingredients,
    required this.directions,
    required this.description,
  });
  @HiveField(0)
  String recipeName;

 @HiveField(1)
  String serving;

 @HiveField(2)
String duration;

@HiveField(3)
String imagePath;

 @HiveField(4)
List<String>ingredients;

 @HiveField(5)
List<String>directions;

 @HiveField(6)
String description;

 }