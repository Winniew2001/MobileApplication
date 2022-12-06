import 'package:flutter/material.dart';

/*
 * Widget for displaying recipe description.
 */
class RecipeDescription extends StatelessWidget {
  final String? description;
  const RecipeDescription({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(description == null){
      return const Text('No description found');
    }
    return Text(
      description!,
      style: const TextStyle(
          fontSize: 20,
      ),
    );
  }
}
