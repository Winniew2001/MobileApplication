import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/model/form_values.dart';
import 'package:mobile_application/app/pages/collection_recipes_page.dart';
import 'package:mobile_application/app/pages/new_or_update_collection_page.dart';
import 'package:mobile_application/app/widgets/account_setup.dart';
import 'package:mobile_application/app/widgets/empty_warning.dart';
import 'package:mobile_application/app/widgets/recipe_image.dart';
import '../authentication/authentication_repository/firebase_auth_repository/'
    'authentication_repository.dart';
import '../model/collection.dart';
import '../widgets/recipe_divider.dart';

class AllCollectionsPage extends StatelessWidget {
  final userRef = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  AllCollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AccountSetup.setUpUser();

    final collectionRef = userRef.collection("collections").withConverter(
        fromFirestore: Collection.fromFirestore,
        toFirestore: (Collection collection, _) => collection.toFirestore());

    final collections = collectionRef.snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Collections"),
        actions: [
          IconButton(
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => NewOrUpdateCollectionPage(
                  formValues: FormValues(),
                  ref: collectionRef,
                  pageTitle: 'New Collection',
                ),
              );
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
              Column(
                children: [
                  SizedBox(
                    height: 10000,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: collections,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          if (snapshot.data!.docs.isNotEmpty) {
                          return ListView.builder(
                            itemCount: snapshot.data!.size,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  CollectionTile(
                                    collection:
                                    snapshot.data!.docs[index].data() as Collection,
                                    ref: collectionRef,
                                    id: snapshot.data!.docs[index].id,
                                  ),
                                  const RecipeDivider(),
                                ],
                              );
                            },
                          );
                          } else {
                            return const EmptyWarning(
                                warningText: "No Collections Found!"
                            );
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}

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
