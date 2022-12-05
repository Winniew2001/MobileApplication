import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_application/app/widgets/sized_box_10.dart';
import 'package:mobile_application/app/widgets/sized_box_20.dart';

class NewRecipePage extends StatefulWidget {
  const NewRecipePage({Key? key}) : super(key: key);

  @override
  State<NewRecipePage> createState() => NewRecipeState();
}

class NewRecipeState extends State<NewRecipePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController servingSizeController = TextEditingController();

  void submit() {
    String name = nameController.text;
    String description = descriptionController.text;
    String instructions = instructionsController.text;

    String servingSizeString = servingSizeController.text;
    int servingSize =
        servingSizeString.isEmpty ? 0 : int.parse(servingSizeController.text);

    print("$name $description $instructions $servingSize");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Recipe"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Recipe Name',
                    ),
                  ),
                  const SmallSizedBox(),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Recipe Description',
                    ),
                  ),
                  const MediumSizedBox(),
                  const NewMeasurements(),
                  TextField(
                    controller: instructionsController,
                    decoration: const InputDecoration(
                      labelText: 'Instructions',
                    ),
                  ),
                  const SmallSizedBox(),
                  TextField(
                    controller: servingSizeController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Serving Size',
                    ),
                  ),
                  const MediumSizedBox(),
                  ElevatedButton(
                    onPressed: true ? submit : null,
                    child: const Text('Save Recipe'),
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

class NewMeasurements extends StatefulWidget {
  const NewMeasurements({super.key});

  @override
  State<StatefulWidget> createState() => NewMeasurementsState();
}

class NewMeasurementsState extends State<NewMeasurements> {
  final Map<String, dynamic> map = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        map.isNotEmpty
            ? ListView.builder(
                itemCount: map.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(map.keys.elementAt(index)),
                      Text(map.values.elementAt(index))
                    ],
                  );
                })
            : const Text("No ingredients added yet!"),
        ElevatedButton(
            onPressed: addMeasurement, child: const Text("Add ingredient"))
      ],
    );
  }

  Future addMeasurement() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            contentPadding: const EdgeInsets.only(top: 10),
            title: const Text("New ingredient"),
            content: SizedBox(
              height: 220,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Ingredient',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Amount'
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple),
                        child: const Text("Add"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}
