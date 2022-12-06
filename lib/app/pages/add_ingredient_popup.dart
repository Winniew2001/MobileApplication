import 'package:flutter/material.dart';

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
