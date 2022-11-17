import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/widgets/recipe_divider.dart';
import 'package:mobile_application/app/widgets/recipe_tile.dart';

import '../model/recipe.dart';

//TODO: Clean up widget
class RecipeListTile extends StatelessWidget {
  const RecipeListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipes = FirebaseFirestore.instance
        .collection("users")
        .doc("tVBcwa4zBOihZhiQNZ4I")
        .collection("collections")
        .doc("Sbs0RsD66KhwnYsClIas")
        .collection("recipes")
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
                return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        RecipeTile(
                            recipe:
                                snapshot.data!.docs[index].data() as Recipe),
                        const RecipeDivider(),
                      ],
                    );
                  },
                );
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
