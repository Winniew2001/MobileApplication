import 'package:flutter/material.dart';
import 'package:mobile_application/app/authentication/authentication_repository'
    '/firebase_auth_repository/authentication_repository.dart';

/*
 *
 */
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
              Container(),
              //RecipeListTile(),
            ]),
          )
        ],
      ),
    );
  }
}
