import 'package:hive/hive.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 3)
class CartModel {
  CartModel({required this.cartList});
  
  @HiveField(0)
  String cartList;
}
