import 'package:flutter/material.dart';

//TODO: Refactor null check, reused in many of the recipe widgets
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
