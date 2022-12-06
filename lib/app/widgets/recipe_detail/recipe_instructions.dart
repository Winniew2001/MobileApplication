import 'package:flutter/material.dart';

class RecipeInstructions extends StatelessWidget {
  final String? instructions;
  const RecipeInstructions({Key? key, required this.instructions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(instructions == null){
      return const Text('Instructions not found');
    }
    return Text(
      instructions!,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.normal
      ),
    );
  }
}
