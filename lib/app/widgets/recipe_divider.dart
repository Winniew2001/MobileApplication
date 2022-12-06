import 'package:flutter/material.dart';

/*
 * Widget for showing separation between recipe tiles.
 */
class RecipeDivider extends StatelessWidget {
  const RecipeDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.grey.shade300,
    );
  }
}
