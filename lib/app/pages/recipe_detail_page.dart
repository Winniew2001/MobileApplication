import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String id = "testuser";
  final String collection = "dinner";
  final String recipe = "baked potato";

  const RecipeDetail({super.key});

  Future<Recipe?> heee() async {
    final ref = FirebaseFirestore.instance
        .collection("users")
        .doc("tVBcwa4zBOihZhiQNZ4I")
        .collection("collections")
        .doc("Sbs0RsD66KhwnYsClIas")
        .collection("recipes")
        .doc("0ELVcF8MkP2BEy4ZFwgt")
        .withConverter(
            fromFirestore: Recipe.fromFirestore,
            toFirestore: (Recipe recipe, _) => recipe.toFirestore());
    final docSnap = await ref.get();
    final recipe = docSnap.data();
    return recipe;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icecream'),
      ),
      body: FutureBuilder<Recipe?>(
          future: heee(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              var recipe = snapshot.data;
              return Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RecipeTitle(title: recipe?.name),
                              const MediumSizedBox(),
                              SizedBox(
                                  width: double.infinity,
                                  height: 300,
                                  child: RecipeImage(
                                      imagePath: recipe?.imagePath)),
                              const MediumSizedBox(),
                              RecipeDescription(
                                  description: recipe?.description),
                              const MediumSizedBox(),
                              RecipeMeasurements(
                                  measurements: recipe?.measurements),
                              const MediumSizedBox(),
                              RecipeInstructions(
                                  instructions: recipe?.instructions),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
