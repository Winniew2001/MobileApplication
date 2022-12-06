import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/authentication/authentication_repository/firebase_auth_repository/authentication_repository.dart';
import 'package:mobile_application/app/authentication/controller/authentication_controller.dart';
import 'package:mobile_application/app/pages/new_recipe_page.dart';
import 'package:mobile_application/app/widgets/recipe_list_tile.dart';

class AllRecipesPage extends StatelessWidget {
  const AllRecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Recipes'),
        actions: [
          IconButton(
            onPressed: () {
              showCupertinoModalPopup(context: context, builder: (context) => const NewRecipePage(pageTitle: "New Recipe", id: null));
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              AuthenticationRepository authentication = AuthenticationRepository();
              authentication.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const RecipeListTile(),
            ]),
          )
        ],
      ),
    );
  }
}
