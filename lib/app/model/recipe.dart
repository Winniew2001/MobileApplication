import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String? name;
  final String? description;
  final int? servingSize;
  final Map<String, dynamic>? measurements;
  final String? instructions;
  final String? imagePath;

  Recipe({
    this.name,
    this.description,
    this.servingSize,
    this.measurements,
    this.instructions,
    this.imagePath,
  });

  factory Recipe.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    //print(data?['measurement']);
    print(data);
    return Recipe(
      name: data?['name'],
      description: data?['description'],
      servingSize: data?['serving-size'],
      measurements: data?['measurements'] != null
          ? data!['measurements'] as Map<String, dynamic>
          : null,
      instructions: data?['instructions'],
      imagePath: data?['image-path'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (description != null) "description": description,
      if (servingSize != null) "serving-size": servingSize,
      if (measurements != null) "measurements": measurements,
      if (instructions != null) "instructions": instructions,
      if (imagePath != null) "image-path": imagePath,
    };
  }
}
