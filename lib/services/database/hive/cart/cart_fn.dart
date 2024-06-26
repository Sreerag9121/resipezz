import 'package:hive/hive.dart';
import 'package:recipizz/services/database/hive/cart/cart_model.dart';
import 'package:recipizz/services/database/hive/hive_open_box.dart';

class CartBoxData {
  static Box<CartModel> getCartData() =>
      Hive.box<CartModel>('cartBox');
}

class CartCrud{
  Future<void>addCart({
    required String cartList,
  })async{
   String uniqueTime = DateTime.now().microsecondsSinceEpoch.toString();
  await cartBox.put(
    uniqueTime,
     CartModel(cartList: cartList)
     );
  }
}