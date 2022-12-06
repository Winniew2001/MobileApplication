import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/model/form_values.dart';
import 'dart:io';
import 'recipe_image.dart';

/*
 * Widget for selecting an image for a new recipe or updating an existing one.
 */
class SelectRecipeImage extends StatefulWidget {
  final FormValues formValues;

  const SelectRecipeImage({super.key, required this.formValues});

  @override
  SelectRecipeImageState createState() => SelectRecipeImageState();
}

class SelectRecipeImageState extends State<SelectRecipeImage> {
  Widget image = const Placeholder();
  String path = "";
  String imageName = "";

  @override
  Widget build(BuildContext context) {
    image = widget.formValues.imageUrl == "" ? image
        : RecipeImage(imagePath: widget.formValues.imageUrl);

    return Column(
      children: [
        image,
        Center(
          child: ElevatedButton(
            onPressed: () async {
              final results = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.image,
              );

              if (results == null) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar (
                        content: Text("No file selected"),
                    ),
                );
                return;
              }

              path = results.files.single.path!;
              widget.formValues.localImagePath = path;
              imageName = results.files.single.name;
              widget.formValues.imageName = results.files.single.name;
              widget.formValues.imageUrl = "";
              image = Image.file(
                  File(
                      results.files.single.path!
                  )
              );
              setState(() {});
            },
            child: const Text("Upload file"),
          ),
        ),
      ],
    );
  }
}
