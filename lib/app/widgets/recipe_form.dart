import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_application/app/model/form_values.dart';
import 'package:mobile_application/app/widgets/sized_box_10.dart';

/*
 * Widget for editing the name, description, and serving size of an existing
 * recipe or new recipe.
 */
class RecipeForm extends StatefulWidget {
  final FormValues formValues;
  const RecipeForm({Key? key, required this.formValues}) : super(key: key);

  @override
  State<RecipeForm> createState() => RecipeFormState();
}

class RecipeFormState extends State<RecipeForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController servingSizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.formValues.name;
    descriptionController.text = widget.formValues.description;
    servingSizeController.text = "${widget.formValues.servingSize}";

    return  Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: nameController,
            onChanged: (value) {
              widget.formValues.name = value;
            },
            decoration: const InputDecoration(
              labelText: 'Recipe Name',
            ),
          ),
          const SmallSizedBox(),
          TextField(
            maxLines: 5,
            minLines: 1,
            controller: descriptionController,
            onChanged: (value) {
              widget.formValues.description = value;
            },
            decoration: const InputDecoration(
              labelText: 'Recipe Description',
            ),
          ),
          const SmallSizedBox(),
          TextField(
            controller: servingSizeController,
            onChanged: (value) {
              widget.formValues.servingSize = value.trim().isNotEmpty
                  ? int.tryParse(value.trim())! : 0;
            },
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              labelText: 'Serving Size',
            ),
          ),
        ],
      ),
    );
  }
}
