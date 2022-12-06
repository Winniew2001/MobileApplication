import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/pages/new_or_update_recipe_page.dart';
import 'package:mobile_application/app/widgets/recipe_detail/recipe_headers.dart';
import 'package:mobile_application/app/widgets/recipe_detail/recipe_measurements.dart';
import 'package:mobile_application/app/widgets/recipe_detail/recipe_description.dart';
import 'package:mobile_application/app/widgets/recipe_detail/recipe_serving_size.dart';
import 'package:mobile_application/app/widgets/recipe_image.dart';
import 'package:mobile_application/app/widgets/recipe_detail/recipe_instructions.dart';
import 'package:mobile_application/app/widgets/recipe_detail/recipe_title.dart';
import 'package:mobile_application/app/widgets/sized_box_20.dart';

import '../model/recipe.dart';

/*
 * Page for displaying the details for a recipe.
 */
class RecipeDetail extends StatelessWidget {
  final Recipe recipe;
  final CollectionReference<Recipe> ref;
  final String id;

  const RecipeDetail(
      {super.key, required this.recipe, required this.ref, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name!),
        actions: [
          IconButton(
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => NewOrUpdateRecipePage(
                  pageTitle: "Edit recipe",
                  id: id,
                  recipe: recipe,
                  ref: ref,
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              await ref
                  .doc(id)
                  .delete()
                  .then((_) => Navigator.of(context).pop());
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 60),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RecipeTitle(title: recipe.name),
                      const MediumSizedBox(),
                      SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: RecipeImage(imagePath: recipe.imagePath),
                      ),
                      const MediumSizedBox(),
                      const RecipeHeader(header: "Description"),
                      RecipeDescription(description: recipe.description),
                      const MediumSizedBox(),
                      const RecipeHeader(header: "Ingredients"),
                      RecipeMeasurements(measurements: recipe.measurements),
                      const MediumSizedBox(),
                      const RecipeHeader(header: "Serving Size"),
                      RecipeServingSize(
                        servingSize: recipe.servingSize.toString(),
                      ),
                      const MediumSizedBox(),
                      const RecipeHeader(header: "Instructions"),
                      RecipeInstructions(instructions: recipe.instructions),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
