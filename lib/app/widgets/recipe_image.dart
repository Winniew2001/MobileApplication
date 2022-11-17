import 'package:mobile_application/app/storage/firebase_storage/storage.dart';

import 'package:flutter/material.dart';

class RecipeImage extends StatelessWidget {
  final String? imagePath;

  RecipeImage({Key? key, required this.imagePath}) : super(key: key);

  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return const Text("NO IMAGE FOUND");
    }
    return FutureBuilder<String>(
        future: storage.downloadURL(imagePath!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data == null) {
            return const Text("IMAGE NOT FOUND");
          }
          return Image.network(
            snapshot.data!,
            fit: BoxFit.fitWidth,
          );
        }
    );
  }
}
