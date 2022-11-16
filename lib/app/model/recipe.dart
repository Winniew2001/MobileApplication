import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe{
  final String? name;
  final String? description;
  final int? servingSize;
  final Map<String, String>? measurements;
  final String? instructions;

  Recipe({
    this.name,
    this.description,
    this.servingSize,
    this.measurements,
    this.instructions
  });

  factory Recipe.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    print("$data");
    return Recipe(
      name: data?['name'],
      description: data?['description'],
      servingSize: data?['servingSize'],
      measurements: data?['measurements'] is Iterable ? Map.from(data?['measurements']) : null,
      instructions: data?['instructions'],
    );
  }

  Map<String, dynamic> toFirestore(){
    return{
      if (name != null) "name" : name,
      if (description != null) "description" : description,
      if (servingSize != null) "servingSize" : servingSize,
      if (measurements != null) "measurements" : measurements,
      if (instructions != null) "instructions" : instructions,
    };
  }
}