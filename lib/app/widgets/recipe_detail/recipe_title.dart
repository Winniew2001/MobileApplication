import 'package:flutter/material.dart';

/*
 * Widget for displaying recipe name.
 */
class RecipeTitle extends StatelessWidget {
  final String? title;
  const RecipeTitle({Key? key, required this.title}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return const Text("NO TITLE");
    }
    return Text(
      title!,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
