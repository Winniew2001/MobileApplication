import 'package:flutter/material.dart';
import 'package:mobile_application/app/widgets/sized_box_20.dart';

//TODO: Make separate widgets for the different sections (ingredients/instructions etc)
//TODO: Clean up widget
class RecipeDetail extends StatelessWidget {
  const RecipeDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }
}
