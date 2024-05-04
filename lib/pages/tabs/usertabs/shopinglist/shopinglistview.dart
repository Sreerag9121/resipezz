import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class ShopingListView extends StatefulWidget {
  const ShopingListView({super.key});

  @override
  State<ShopingListView> createState() => _ShopingListViewState();
}

class _ShopingListViewState extends State<ShopingListView> {
  final List<Ingredients> ingrditem = [
    Ingredients(
      name: 'chicken teriyaki chow',
       ingrdname: 'chicken breast, cubed'
       )
       ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ingrditem.length,
        itemBuilder: (context, intex) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.colors.appWhiteColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Text(ingrditem[intex].name,
                style: TextStyle(
                  fontFamily: AppTheme.fonts.jost,
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.push_pin_outlined),
                      Text(ingrditem[intex].ingrdname),
                    ],
                  ),
                ),
                trailing: const Icon(Icons.more_vert),
              ),
            ),
          );
        });
  }
}

class Ingredients {
  final String name;
  final String ingrdname;

  Ingredients({required this.name, required this.ingrdname});
}
