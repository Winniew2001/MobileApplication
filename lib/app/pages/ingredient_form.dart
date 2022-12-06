import 'package:flutter/material.dart';
import 'package:mobile_application/app/model/form_values.dart';
import 'package:mobile_application/app/widgets/sized_box_20.dart';

class IngredientForm extends StatefulWidget {
  final FormValues formValues;

  const IngredientForm(
      {Key? key, required this.onUpdate, required this.formValues})
      : super(key: key);

  final ValueChanged<List<Map<int, String>>> onUpdate;

  @override
  IngredientFormState createState() => IngredientFormState();
}

class IngredientFormState extends State<IngredientForm> {
  List<Map<int, String>> fields = [];
  List<Map<int, TextEditingController>> textControllers = [];
  int count = 0;
  bool initial = true;

  void _addField() {
    setState(() {
      fields.add({count: ''});
      textControllers.add({count: TextEditingController()});
      count++;
    });
  }

  void _updateField(String value, int index) {
    final key = fields[index].keys.first;
    fields[index][key] = value;
    widget.onUpdate(fields);
  }

  void _removeField(int index) {
    setState(() {
      fields.removeAt(index);
      textControllers.removeAt(index);
      widget.onUpdate(fields);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (initial && widget.formValues.ingredients.isNotEmpty) {
      fields = widget.formValues.ingredients;
      for (int i = 0; i < fields.length; i++) {
        textControllers.add({count: TextEditingController()});
        textControllers[i].values.first.text = fields[i].values.first;
        count++;
      }
      initial = false;
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: const [
              SizedBox(
                child: Text(
                    "Ingredients and Measurements",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16
                ),),
              ),
            ],
          ),
          for (int i = 0; i < fields.length; i++)
            Row(
              key: ValueKey(i),
              children: [
                SizedBox(
                  width: 290,
                  child: TextField(
                    controller: textControllers[i].values.first,
                    onChanged: (value) {
                      _updateField(value, i);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    child: IconButton(
                      onPressed: () => {_removeField(i)},
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                ),
              ],
            ),

          const MediumSizedBox(),
          ElevatedButton(
            onPressed: () => {_addField()},
            child: const Text("Add Ingredient"),
          ),
        ],
      ),
    );
  }
}

