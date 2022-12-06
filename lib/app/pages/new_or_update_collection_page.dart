import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/model/collection.dart';
import 'package:mobile_application/app/model/form_values.dart';
import 'package:mobile_application/app/widgets/select_recipe_image.dart';
import 'package:mobile_application/app/widgets/sized_box_10.dart';
import 'package:mobile_application/app/widgets/sized_box_20.dart';
import '../storage/firebase_storage/storage.dart';

/*
 * Page where a collection is created or updated.
 */
class NewOrUpdateCollectionPage extends StatelessWidget {
  NewOrUpdateCollectionPage({super.key, required this.formValues, this.id,
    required this.ref, required this.pageTitle});

  final FormValues formValues;
  final String? id;
  final String pageTitle;
  final CollectionReference<Collection> ref;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = formValues.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SelectRecipeImage(formValues: formValues),
              const MediumSizedBox(),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Collection Name'
                ),
                controller: controller,
                onChanged: (value) {
                  formValues.name = value;
                },
              ),
              const SmallSizedBox(),
              ElevatedButton(
                  onPressed: () {
                    _submit();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Save")
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit () {
    final tempCollectionRef = id == null ? ref.doc() : ref.doc(id);
    final collectionRef = tempCollectionRef.withConverter(
        fromFirestore: Collection.fromFirestore,
        toFirestore: (Collection collection, _) => collection.toFirestore());

    String name, imageUrl;

    name = formValues.name == "" ? "Untitled" : formValues.name;

    if (formValues.localImagePath == "") {
      imageUrl = "";
    } else {
      final Storage storage = Storage();
      storage
          .uploadFile(
          formValues.localImagePath,
          collectionRef.path
      );
      imageUrl = collectionRef.path;
    }

    Collection collection = Collection(
        name: name,
        imageUrl: imageUrl
    );

    collectionRef.set(collection);
  }
}