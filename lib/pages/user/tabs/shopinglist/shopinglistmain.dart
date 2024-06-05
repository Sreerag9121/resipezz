import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipizz/services/database/hive/cart/cart_fn.dart';
import 'package:recipizz/services/database/hive/cart/cart_model.dart';
import 'package:recipizz/services/database/hive/hive_open_box.dart';
import 'package:recipizz/utils/app_theme.dart';

class ShopingList extends StatelessWidget {
  const ShopingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        foregroundColor:AppTheme.colors.appWhiteColor ,
        title: Text('Shopping List',
          style: TextStyle(
            fontFamily: AppTheme.fonts.jost,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        // automaticallyImplyLeading: false,
      ),
      body: ValueListenableBuilder(
          valueListenable: CartBoxData.getCartData().listenable(),
          builder: (context, cartBox, _) {
            var cartList = cartBox.values.toList().cast<CartModel>();
            return (cartList.isEmpty)
                ? Center(
                    child: Text('Add Recipes',
                      style: TextStyle(
                          color: AppTheme.colors.appBlackColor,
                          fontFamily: AppTheme.fonts.jost),
                    ),
                  )
                : ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      var data = cartList[index];
                      return Card(
                        color: AppTheme.colors.appWhiteColor,
                        child: ListTile(
                          leading: Text(
                            '${index + 1}.',
                            style: TextStyle(
                              fontSize: 16,
                                color: AppTheme.colors.appBlackColor,
                                fontFamily: AppTheme.fonts.jost),
                          ),
                          title: Text(
                            data.cartList.toString(),
                            style: TextStyle(
                                color: AppTheme.colors.appBlackColor,
                                fontFamily: AppTheme.fonts.jost),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                        'Are You Sure Want To Delete',
                                        style: TextStyle(
                                            color:
                                                AppTheme.colors.appBlackColor,
                                            fontFamily: AppTheme.fonts.jost),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            await cartBox.deleteAt(index);
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                color: AppTheme
                                                    .colors.appBlackColor,
                                                fontFamily:
                                                    AppTheme.fonts.jost),
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                  color: AppTheme
                                                      .colors.appBlackColor,
                                                  fontFamily:
                                                      AppTheme.fonts.jost),
                                            )),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.delete_outlined,
                                color: AppTheme.colors.appRedColor,
                              )),
                        ),
                      );
                    });
          },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.colors.shadecolor,
            foregroundColor: AppTheme.colors.appWhiteColor,
            onPressed: (){
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  content: Text('Are You Sure Want To Delete All Data',
                  style: TextStyle(
                    fontFamily: AppTheme.fonts.jost,
                    color: AppTheme.colors.appBlackColor
                  ),
                ),
                actions: [
                  TextButton(onPressed: (){
                    cartBox.clear();
                    Navigator.pop(context);
                  }, 
                  child: Text('Yes',
                  style: TextStyle(
                    color: AppTheme.colors.appBlackColor,
                    fontFamily: AppTheme.fonts.jost
                  ),)),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: Text('No',
                  style: TextStyle(
                    color: AppTheme.colors.appBlackColor,
                    fontFamily: AppTheme.fonts.jost
                  ),))
                ],);
              },);
            },
            child: const Icon(Icons.delete),),
    );
  }
}
