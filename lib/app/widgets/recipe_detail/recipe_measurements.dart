import 'package:flutter/material.dart';

/*
 * Widget for displaying the ingredients and measurements of a recipe.
 */
class RecipeMeasurements extends StatelessWidget {
  final List<String>? measurements;

  const RecipeMeasurements({super.key, required this.measurements});

  @override
  Widget build(BuildContext context) {
    if (measurements == null) {
      return const Text("Measurements not found!");
    }

    return Column(
      children: [
        ListView.builder(
            itemCount: measurements?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text(measurements!.elementAt(index),
                  style: const TextStyle(
                    fontSize: 20,
                  ),),
                ],
              );
            })
      ],
    );
  }
}
