import 'package:flutter/material.dart';
import 'package:recipizz/pages/admin/other/categories/add_categories/catogory_image_picker.dart';
import 'package:recipizz/services/database/firebase/admin/categories_crud_functions.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/text_field_without_border.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final CategoriesCrud categoriesCrud = CategoriesCrud();
  bool isLoading = false;
  final _formKeys = GlobalKey<FormState>();
  final _categoriesNameController = TextEditingController();
  String imagePath = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        foregroundColor: AppTheme.colors.appWhiteColor,
        title: Text('Create Categories',
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
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKeys,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
//categorie Image picker
                  CategoryImagePicker(
                    onImageSelected: (image) {
                      setState(() { imagePath = image ?? '';
                      });
                    },
                  ),
                  const SizedBox(height: 30,),
//categori name picker   
                  BorderlessTextFormField(
                      controllers: _categoriesNameController,
                      hintText: 'Enter the Categories Name',
                      labelText: 'Categories'),
//submit Button
                  Stack(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                AppTheme.colors.shadecolor),
                            foregroundColor: WidgetStateProperty.all<Color>(
                                AppTheme.colors.appWhiteColor)),
                        onPressed: isLoading
                            ? null
                            : () async {
                                if (_formKeys.currentState!.validate()) {
                                  if (imagePath.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Please select an image',
                                          style: TextStyle(
                                              color: AppTheme
                                                  .colors.appWhiteColor),
                                        ),
                                        backgroundColor:
                                            AppTheme.colors.appRedColor,
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await categoriesCrud.addCategoriesMethod(
                                        _categoriesNameController,
                                        imagePath,
                                        context);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                  }
                                }
                              },
                        child: const Text('Submit'),
                      ),
                      if (isLoading)
                        const Positioned.fill(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
