import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeListTile extends StatelessWidget {
  const RecipeListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => Container(
                color: Colors.white,
                child: Text('Recipe detail'),
              ),
            );
          },
          child: Row(
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://placehold.it/100x100'),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Recipe 1',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Unga le Bunga le Shunga',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(height: 1, color: Colors.grey.shade200,
        ),
      ],
    );
  }
}