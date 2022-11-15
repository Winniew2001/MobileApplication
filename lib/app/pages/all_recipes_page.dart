import 'package:flutter/material.dart';
import 'package:mobile_application/app/widgets/recipe_list_tile.dart';

import '../widgets/no_recipes.dart';

class AllRecipesPage extends StatelessWidget {
  const AllRecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Recipes'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              RecipeListTile(),
              NoRecipes(),
              //for (int i = 0; i < 100; i++) (Text('Recipe $i')),
            ]),
          )
        ],
      ),
    );
  }
}
