import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/admin/categories/update_categories.dart';
import 'package:recipizz/services/functions/adminfunctions/categories_crud_functions.dart';
import 'package:recipizz/utils/app_theme.dart';

class CategoriesDetails extends StatefulWidget {
  final String? catIdDetail;
  const CategoriesDetails({super.key, this.catIdDetail});

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  final CategoriesCrud categoriesCRUD = CategoriesCrud();
  late DocumentReference _catReferance;
  late Future<DocumentSnapshot> _catFutureData;
  @override
  void initState() {
    super.initState();
    _catReferance =
        FirebaseFirestore.instance.collection('categories').doc(widget.catIdDetail);
    _catFutureData = _catReferance.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        centerTitle: true,
        title: Text(
          'Details',
          style: TextStyle(
            color: AppTheme.colors.appWhiteColor,
            fontFamily: AppTheme.fonts.jost,
            fontSize: 26,
          ),
        ),
        leading: IconButton(
          onPressed: ()=>Navigator.of(context).pop(),
         icon:Icon(Icons.arrow_back,
          size: 25,
          color: AppTheme.colors.appWhiteColor,) 
        ),
      ),
      body: FutureBuilder(
          future: _catFutureData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              DocumentSnapshot catDocSnapShot = snapshot.data;
              Map catData = catDocSnapShot.data() as Map;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 300,
                        height: 200,
                        child: Image.network(catData['image']!,fit: BoxFit.fill,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: AppTheme.colors.shadecolor,
                          width: 300,
                          height: 50,
                          child: Center(
                            child: Text(
                              catData['categoriesName'],
                              style: TextStyle(
                                color: AppTheme.colors.appWhiteColor,
                                fontFamily: AppTheme.fonts.jost,
                                fontSize: 30
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: (){
                              Navigator.pushReplacement(context, 
                              MaterialPageRoute(builder: (context)=> UpdateCategories(widget.catIdDetail!,)));
                            }, 
                            icon: const Icon(Icons.edit_outlined), 
                            label: const Text('Edit'),
                            ),
                            ElevatedButton.icon(
                            onPressed: ()async{                           
                              await categoriesCRUD.deleteCategories(widget.catIdDetail!);
                             await categoriesCRUD.deleteImage(catData['image']!);
                             // ignore: use_build_context_synchronously
                             Navigator.pop(context);
                            }, 
                            icon: const Icon(Icons.delete_outline_sharp), 
                            label: const Text('Delete'),
                            ),
                        ],
                      )
                      ],
                  ),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
