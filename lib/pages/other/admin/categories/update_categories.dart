import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/admin/categories/update_cat_image.dart';
import 'package:recipizz/services/functions/adminfunctions/categories_crud_functions.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/text_field_without_border.dart';

class UpdateCategories extends StatefulWidget {
  final String catId;
  const UpdateCategories(this.catId,{super.key});

  @override
  State<UpdateCategories> createState() => _UpdateCategoriesState();
}

class _UpdateCategoriesState extends State<UpdateCategories> {
  final CategoriesCrud categoriesCRUD = CategoriesCrud();
  late TextEditingController _catNameController;
  String? imagePath = '';
  String _oldimageUrl = '';
  String _newImageUrl='';

  late DocumentReference _catCollectionReference;
  late Stream<DocumentSnapshot> _catStreamData;
  @override
  void initState() {
    _catCollectionReference = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.catId);
    _catNameController = TextEditingController();
    _catStreamData = _catCollectionReference.snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colors.shadecolor,
          foregroundColor:  AppTheme.colors.appWhiteColor,
          title: Text(
            _newImageUrl.toString(),
            // 'Update Categories',
            style: TextStyle(
              fontFamily: AppTheme.fonts.jost,
              fontSize: 26,
            ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              size: 25,
            ),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: _catStreamData,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                Map<String, dynamic> itemData =
                    snapshot.data!.data() as Map<String, dynamic>;
                _catNameController.text = itemData['categoriesName'];
                _oldimageUrl = itemData['image'];
                return SafeArea(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          UpdateCatImage(
                            onImageSelected: (image) {
                              setState(() {
                                imagePath = image ?? '';
                              });
                            },
                            oldImages: _oldimageUrl,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          MyTextFieldWoutBrd(
                              controllers: _catNameController,
                              hintText: 'Enter the Categories Name',
                              labelText: 'Categories'),
                          ElevatedButton(
                              onPressed: () async {
                                _newImageUrl= await categoriesCRUD.updateImageUrl(_oldimageUrl, imagePath!);
                               await categoriesCRUD.updateCategoriesFn(
                                  _catNameController,
                                   _newImageUrl,
                                    // ignore: use_build_context_synchronously
                                    context, widget.catId);
                                    setState(() {
                                      
                                    });
                              },
                              child: const Text('Update'))
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            ),
            );
  }
  @override
  void dispose() {
    _catNameController.dispose();
    super.dispose();
  }
}