import 'package:flutter/material.dart';

/*
 * Widget for displaying the serving size of a recipe.
 */
class RecipeServingSize extends StatelessWidget {
  final String? servingSize;
  const RecipeServingSize({Key? key, required this.servingSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(servingSize == null){
      return const Text('0');
    }
    return Text(
      servingSize!,
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}