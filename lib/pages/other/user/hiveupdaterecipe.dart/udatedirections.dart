import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class UpdateDirections extends StatefulWidget {
  final Function(List<TextEditingController>) onDirectionList;
  final List<String>editList;
  const UpdateDirections({super.key, required this.editList,required this.onDirectionList});

  @override
  State<UpdateDirections> createState() => _UpdateDirectionsState();
}

class _UpdateDirectionsState extends State<UpdateDirections> {
  List<TextEditingController> listController = [TextEditingController()];
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
    widget.onDirectionList(listController);
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Direction *",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E384E),
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
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "Input Text Here",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Direction';
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
                      )
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
                  style: TextStyle(color: AppTheme.colors.appWhiteColor)),
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
