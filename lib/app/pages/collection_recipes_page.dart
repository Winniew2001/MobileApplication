import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/model/form_values.dart';
import 'package:mobile_application/app/model/recipe.dart';
import 'package:mobile_application/app/pages/new_or_update_collection_page.dart';
import 'package:mobile_application/app/pages/new_or_update_recipe_page.dart';
import 'package:mobile_application/app/pages/web_scrape_page.dart';
import 'package:mobile_application/app/widgets/recipe_list_tile.dart';
import '../model/collection.dart';

/*
 * Page for displaying all the recipes in a collection.
 */
class CollectionRecipesPage extends StatelessWidget {
  final CollectionReference<Collection> ref;
  final Collection collection;
  final String id;
  const CollectionRecipesPage({Key? key, required this.ref, required this.collection, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("${collection.name}"),
        actions: [
          IconButton(
            onPressed: () async {
              await ref
                  .doc(id)
                  .delete()
                  .then((_) => Navigator.of(context).pop());
            },
            icon: const Icon(Icons.delete_forever),
          ),
          IconButton(
            onPressed: () async {
              ref
                  .doc(id)
                  .collection("recipes")
                  .doc()
                  .withConverter(
                  fromFirestore: Recipe.fromFirestore,
                  toFirestore: (Recipe recipe, _) => recipe.toFirestore())
                  .set(await WebScrapePageState.getWebsiteData(
                  'https://www.allrecipes.com/recipe/263394/garlic-shrimp-pasta-bake/'
                  //'https://www.allrecipes.com/recipe/281646/the-best-baked-ziti/'
              ));
            },
            icon: const Icon(Icons.download),
          ),
          IconButton(
            onPressed: () {
              final formValues = FormValues();
              formValues.imageUrl = collection.imageUrl ?? "";
              formValues.name = collection.name ?? "";
              showCupertinoModalPopup(context: context, builder: (context) =>
                  NewOrUpdateCollectionPage(
                    formValues: formValues,
                    ref: ref,
                    pageTitle: "Edit Collection",
                    id: id,
                  ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showCupertinoModalPopup(context: context, builder: (context) =>
              NewOrUpdateRecipePage(pageTitle: "New Recipe", id: null,
                  ref: ref.doc(id).collection("recipes").withConverter(
                      fromFirestore: Recipe.fromFirestore,
                      toFirestore: (Recipe recipe, _) => recipe.toFirestore())
                  )
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              RecipeListTile(ref: ref.doc(id)),
            ]),
          )
        ],
      ),
    );
  }
}
