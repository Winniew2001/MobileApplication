import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/widgets/empty_warning.dart';
import 'package:mobile_application/app/widgets/recipe_divider.dart';
import 'package:mobile_application/app/widgets/recipe_tile.dart';

import '../model/collection.dart';
import '../model/recipe.dart';

/*
 * Widget for listing all the recipes in a collection.
 */
class RecipeListTile extends StatelessWidget {
  final DocumentReference<Collection> ref;
  const RecipeListTile({Key? key, required this.ref}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipeRef = ref
        .collection("recipes").withConverter(
        fromFirestore: Recipe.fromFirestore,
        toFirestore: (Recipe recipe, _) => recipe.toFirestore());

    final recipes = recipeRef
        .withConverter(
            fromFirestore: Recipe.fromFirestore,
            toFirestore: (Recipe recipe, _) => recipe.toFirestore())
        .snapshots();

    return Column(
      children: [
        SizedBox(
          height: 10000,
          child: StreamBuilder<QuerySnapshot>(
            stream: recipes,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                if (snapshot.data!.docs.isNotEmpty) {
                snapshot.data!.docs[0].id;
                return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        RecipeTile(
                          recipe: snapshot.data!.docs[index].data() as Recipe,
                          ref: recipeRef,
                          id: snapshot.data!.docs[index].id,
                        ),
                        const RecipeDivider(),
                      ],
                    );
                  },
                );
                } else {
                  return const EmptyWarning(
                    warningText: "No Recipes Found!",
                  );
                }
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
