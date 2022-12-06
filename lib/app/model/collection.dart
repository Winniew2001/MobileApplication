import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
 * Represents a collection of recipes.
 */
class Collection {
  final String? name;
  final String? imageUrl;

  Collection({
    this.name,
    this.imageUrl,
  });

  factory Collection.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Collection(
      name: data?['name'],
      imageUrl: data?['image-path'] ,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (imageUrl != null) "image-path": imageUrl,
    };
  }
}
