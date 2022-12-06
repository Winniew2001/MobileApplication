//TODO: Refactor null check, reused in many of the recipe widgets
import 'package:flutter/material.dart';

class RecipeHeader extends StatelessWidget {
  final String? header;
  const RecipeHeader({Key? key, required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(header == null){
      return const Text('No Header');
    }
    return Text(
      header!,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}