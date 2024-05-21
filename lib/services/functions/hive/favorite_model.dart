import 'package:hive/hive.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 2)
class FavoriteModel {
  FavoriteModel({
    required this.id,
    required this.recipeName,
    required this.serving,
    required this.duration,
    required this.imagePath,
    required this.ingredients,
    required this.directions,
    required this.description,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String recipeName;

  @HiveField(2)
  String serving;

  @HiveField(3)
  String duration;

  @HiveField(4)
  String imagePath;

  @HiveField(5)
  List<String> ingredients;

  @HiveField(6)
  List<String> directions;

  @HiveField(7)
  String description;
}
