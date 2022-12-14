import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/model/form_values.dart';
import 'package:mobile_application/app/pages/new_or_update_collection_page.dart';
import 'package:mobile_application/misc/account_setup.dart';
import 'package:mobile_application/app/widgets/empty_warning.dart';
import '../authentication/authentication_repository/firebase_auth_repository/authentication_repository.dart';
import '../model/collection.dart';
import '../widgets/collection_tile.dart';
import '../widgets/recipe_divider.dart';

/*
 * Page for displaying all collections.
 */
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
