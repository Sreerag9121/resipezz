import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class UpdateIngredients extends StatefulWidget {
  final Function(List<TextEditingController>) onIngredientList;
  final List<String> editList;
  const UpdateIngredients(
      {super.key, required this.onIngredientList, required this.editList});

  @override
  State<UpdateIngredients> createState() => _UpdateIngredientsState();
}

class _UpdateIngredientsState extends State<UpdateIngredients> {
  List<TextEditingController> listController = [];
  @override
  void initState() {
    listController = widget.editList
        .map((ingredients) => TextEditingController(text: ingredients))
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in listController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    widget.onIngredientList(listController);
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ingredients *",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listController.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: listController[index],
                      decoration: InputDecoration(
                        hintText: "Input Ingredient's Here",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.colors.appGreyColor),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Ingredients';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      listController[index].clear();
                      listController[index].dispose();
                      listController.removeAt(index);
                    });
                  },
                  child: const Icon(
                    Icons.delete,
                    size: 25,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              listController.add(TextEditingController());
            });
          },
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: AppTheme.colors.appButtonColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text("Add More",
                  style: TextStyle(
                    color: AppTheme.colors.appWhiteColor,
                  )),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
