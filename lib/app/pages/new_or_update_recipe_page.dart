import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/model/form_values.dart';
import 'package:mobile_application/app/pages/ingredient_form.dart';
import 'package:mobile_application/app/widgets/recipe_form.dart';
import 'package:mobile_application/app/widgets/select_recipe_image.dart';
import 'package:mobile_application/app/widgets/sized_box_20.dart';
import '../model/recipe.dart';
import '../storage/firebase_storage/storage.dart';
import 'instruction_form.dart';

/*
 * Page where a recipe can be created or update an existing recipe.
 */
class NewOrUpdateRecipePage extends StatelessWidget {
  final String pageTitle;
  final String? id;
  final Recipe? recipe;
  final CollectionReference<Recipe> ref;

  const NewOrUpdateRecipePage(
      {super.key, required this.pageTitle, required this.ref, this.id, this.recipe});

  @override
  Widget build(BuildContext context) {
    FormValues formValues = FormValues();

    if (id != null && recipe != null) {
      formValues.name = recipe!.name ?? "";
      formValues.description = recipe!.description ?? "";
      formValues.servingSize = recipe!.servingSize ?? 0;
      formValues.imageUrl = recipe!.imagePath ?? "";
      formValues.instructions = recipe!.instructions ?? "";

      for (int i = 0; i < (recipe!.measurements?.length ?? 0); i++) {
        formValues.ingredients.add({i: recipe!.measurements![i]});
      }
    }

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
              RecipeForm(formValues: formValues),
              const MediumSizedBox(),
              IngredientForm(
                formValues: formValues,
                onUpdate: (value) {
                  formValues.ingredients = value;
                },
              ),
              const MediumSizedBox(),
              InstructionForm(
                formValues: formValues,
                onUpdate: (value) {
                  formValues.instructions = value;
                },
              ),
              const MediumSizedBox(),
              // const InstructionForm
              const MediumSizedBox(),
              ElevatedButton(
                onPressed: () {
                  _submit(formValues);
                  Navigator.of(context).pop();
                },
                child: const Text("Save"),
              ),
              const MediumSizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(FormValues formValues) {
    final tempRecipeRef = id == null ? ref.doc() : ref.doc(id);
    final recipeRef = tempRecipeRef.withConverter(
        fromFirestore: Recipe.fromFirestore,
        toFirestore: (Recipe recipe, _) => recipe.toFirestore());

    String name, instructions, description, imageUrl;
    int servingSize;
    List<String> ingredients = [];

    name = formValues.name == "" ? "Untitled" : formValues.name;
    description = formValues.description;
    servingSize = formValues.servingSize;
    instructions = formValues.instructions;

    if (formValues.ingredients.isEmpty) {
      ingredients = ["None"];
    } else {
      for (int i = 0; i < formValues.ingredients.length; i++) {
        ingredients.add(
            formValues.ingredients[i].values.first
        );
      }
    }

    if (formValues.localImagePath == "") {
      imageUrl = "";
    } else {
      final Storage storage = Storage();
      storage
          .uploadFile(
          formValues.localImagePath,
          recipeRef.path
      );
      imageUrl = recipeRef.path;
    }

    Recipe recipe = Recipe(
        name: name,
        description: description,
        servingSize: servingSize,
        instructions: instructions,
        measurements: ingredients,
        imagePath: imageUrl
    );

    recipeRef.set(recipe);
  }
}
