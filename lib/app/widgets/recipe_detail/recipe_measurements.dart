import 'package:flutter/material.dart';
import 'package:mobile_application/app/widgets/sized_box_20.dart';

class RecipeMeasurements extends StatelessWidget {
  final Map<String, dynamic>? measurements;

  const RecipeMeasurements({super.key, required this.measurements});

  @override
  Widget build(BuildContext context) {
    if (measurements == null) {
      return const Text("Measurements not found!");
    }
    print(measurements?.length);
    return Column(
      children: [
        ListView.builder(
            itemCount: measurements?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text("${measurements!.keys.elementAt(index)}: "),
                  Text(measurements!.values.elementAt(index)),
                ],
              );
            })
      ],
    );
  }
}
