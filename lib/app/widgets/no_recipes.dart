import 'package:flutter/material.dart';

/*
 * Widget for displaying that there are no current recipes saved.
 */
class NoRecipes extends StatelessWidget {
  const NoRecipes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 100),
        Icon(
          Icons.favorite,
          color: Colors.red,
          size: 50,
        ),
        Text(
          'No recipes to view',
          style: TextStyle(
              color: Colors.grey),
        ),
      ],
    );
  }
}
