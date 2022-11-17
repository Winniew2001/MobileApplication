import 'package:mobile_application/app/storage/firebase_storage/storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/pages/recipe_detail_page.dart';
import 'package:mobile_application/app/widgets/recipe_image.dart';

import '../model/recipe.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;

  const RecipeTile({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => const RecipeDetail(),
        );
      },
      child: Row(
        children: [
          SizedBox(
              width: 90,
              height: 90,
              child: RecipeImage(imagePath: recipe.imagePath)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name!,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  recipe.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
