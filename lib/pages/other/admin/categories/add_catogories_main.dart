import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/admin/categories/add_categoriess_ima.dart';
import 'package:recipizz/services/functions/adminfunctions/categories_crud_functions.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/text_field_without_border.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
final CategoriesCrud categoriesCrud = CategoriesCrud();

  final categoriesNameController = TextEditingController();
  String imagePath = '';
  @override
  Widget build(BuildContext context) {
    final categoryController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        foregroundColor:AppTheme.colors.appWhiteColor ,
        title: Text(
          'Create Categories',
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
          child:const Icon(
            Icons.arrow_back,
            size: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                AddCategoriesImg(
                  onImageSelected: (image) {
                    setState(() {
                      imagePath = image ?? '';
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextFieldWoutBrd(
                    controllers: categoryController,
                    hintText: 'Enter the Categories Name',
                    labelText: 'Categories'),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colors.shadecolor),
                    foregroundColor: MaterialStateProperty.all<Color>(AppTheme.colors.appWhiteColor)
                  ),
                    onPressed: () async {
                     await categoriesCrud.addCategoriesMethod(categoryController, imagePath, context);
                    },
                    child: const Text('Create Categories'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
