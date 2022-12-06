import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/widgets/recipe_image.dart';
import '../model/collection.dart';
import '../pages/collection_recipes_page.dart';

/*
 * Widget for displaying a collection.
 */
class CollectionTile extends StatelessWidget {
  final Collection collection;
  final CollectionReference<Collection> ref;
  final String id;

  const CollectionTile({
    super.key,
    required this.collection,
    required this.ref,
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        onPressed: () {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => CollectionRecipesPage(
              collection: collection,
              ref: ref,
              id: id,
            ),
          );
        },
        child: Row(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: RecipeImage(imagePath: collection.imageUrl),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collection.name!,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
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
