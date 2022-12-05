import 'package:flutter/material.dart';
import 'package:mobile_application/app/widgets/recipe_detail/recipe_measurements.dart';
import 'package:mobile_application/app/widgets/recipe_detail/recipe_description.dart';
import 'package:mobile_application/app/widgets/recipe_image.dart';
import 'package:mobile_application/app/widgets/recipe_detail/recipe_instructions.dart';
import 'package:mobile_application/app/widgets/recipe_detail/recipe_title.dart';
import 'package:mobile_application/app/widgets/sized_box_20.dart';

import '../model/recipe.dart';

//TODO: Make separate widgets for the different sections (ingredients/instructions etc)
//TODO: Clean up widget
class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetail({required this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //TODO: add check
          title: Text(recipe.name!),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                            child: RecipeImage(imagePath: recipe.imagePath)),
                        const MediumSizedBox(),
                        RecipeDescription(description: recipe.description),
                        const MediumSizedBox(),
                        RecipeMeasurements(measurements: recipe.measurements),
                        const MediumSizedBox(),
                        RecipeInstructions(instructions: recipe.instructions),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
