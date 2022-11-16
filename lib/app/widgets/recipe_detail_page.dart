import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    final ref = FirebaseFirestore.instance.collection("users").doc("tVBcwa4zBOihZhiQNZ4I").collection("collections").doc("Sbs0RsD66KhwnYsClIas").collection("recipes").doc("0ELVcF8MkP2BEy4ZFwgt").withConverter(fromFirestore: Recipe.fromFirestore, toFirestore: (Recipe recipe, _) => recipe.toFirestore());
    final docSnap = await ref.get();
    final recipe = docSnap.data();
    return recipe;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Recipe?>(
        future: heee(),
        builder: (context, snapshot) {
          print("${snapshot}");
          print({snapshot.data?.instructions});
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if (snapshot.hasData) {
            return Text("${snapshot.data?.name}");
          } else {
            return const Text("data");
          }
        },
    );
    }
}

/**
 * return Scaffold(
    appBar: AppBar(
    title: const Text('Icecream'),
    ),
    body: Container(
    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
    child: CustomScrollView(
    slivers: [
    SliverList(
    delegate: SliverChildListDelegate(
    [
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Icecream',
    style: Theme.of(context).textTheme.headlineSmall,
    ),
    const MediumSizedBox(),
    Container(
    width: double.infinity,
    clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(),
    child: Image.network(
    'https://picsum.photos/600',
    fit: BoxFit.fitWidth,
    )),
    const MediumSizedBox(),
    const Text(
    'Ice cream is a frozen dairy dessert obtained by freezing the ice cream mix with continuous agitation. It contains milk products, sweetening materials, stabilizers, colors, flavors, and egg products. Ice cream had its origins in Europe and was introduced later in the United States where it developed into an industry.',
    style: TextStyle(fontSize: 15),
    ),
    const MediumSizedBox(),
    Text(
    'Ingredients',
    style: Theme.of(context).textTheme.bodyLarge,
    ),
    ],
    )
    ],
    ),
    ),
    ],
    ),
    ),
    );
 */
