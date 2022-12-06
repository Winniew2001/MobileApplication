import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app/model/collection.dart';
import '../app/model/recipe.dart';

/*
 * Sets some dummy data as default for all users.
 */
class AccountSetup {
static Future<void> setUpUser() async {
  FirebaseFirestore
      .instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({"id": FirebaseAuth.instance.currentUser!.uid})
      .whenComplete(() => _setUpCollection());
}

static Future<void> _setUpCollection() async {
  FirebaseFirestore
      .instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("collections")
      .doc("default")
      .withConverter(
      fromFirestore: Collection.fromFirestore,
      toFirestore: (Collection collection, _) => collection.toFirestore())
      .set(Collection(name: "Sample", imageUrl: "common/burger.jpg")
  ).whenComplete(() => _setUpRecipes());
}

static Future<void> _setUpRecipes() async {
  final recipes = FirebaseFirestore
      .instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("collections")
      .doc("default")
      .collection("recipes").withConverter(
      fromFirestore: Recipe.fromFirestore,
      toFirestore: (Recipe recipe, _) => recipe.toFirestore());

  recipes.doc("sample1").set(
    Recipe(
      name: "Instant Pot Mushroom Risotto",
      description: "This creamy Instant Pot Risotto with softened "
          "mushrooms and sprinkles of cheese will seem like a dish ordered "
          "at a resturant instead of made at home",
      servingSize: 4,
      measurements: [
        "1/4 cup unsalted butter",
        "1/4 cup olive oil",
        "3 cups diced mushrooms",
        "1 cup chopped onion",
        "1 spring rosemary",
        "1 1/2 cups Arborio rice",
        "3/4 cup white wine",
        "1 quart chicken stock",
        "salt and ground black pepper to taste",
        "1/2 cup grated Parmesan cheese",
      ],
      instructions: "Turn on multi-functional pressure cooker"
          " (such as Instant Pot) and select Saute function. Add butter"
          " and olive oil; stir until butter melts, about 2 minutes. Add "
          "mushrooms; cook, stirring occasionally, until slightly "
          "softened, about 3 minutes. Stir in onion; cook for about 2 "
          "minutes. Add rosemary spring; cook for 1 minute"
          "\n \n"
          "Stir rice into the pot until each grain is coated with butter "
          "and olive oil mixture, about 2 minutes. Pour in wine; simmer "
          "for 3 minutes. Pour in chicken stock, stirring to scrap the "
          "sides of the pot. Simmer for 1 minute"
          "\n \n"
          "Stir risotto until creamy, about 1 minute, Discard rosemary "
          "spring. Season with salt and pepper. Stir in Parmesan cheese "
          "until melted and combined",
      imagePath: "common/risotto.jpg",
    ),
  );
  recipes.doc("sample2").set(
    Recipe(
      name: "Iced tea",
      description: "Crisp and refreshing homemade iced tea is easy to "
          "make and easy to scale up for a crowd",
      servingSize: 6,
      measurements: [
        "8 cups water, divided",
        "6 bags black tea",
        "1/3 cup sugar, optional, adjust to taste"
      ],
      instructions: "In saucepan, bring half of the water to a boil. "
          "Remove from the heat and add tea bags. Allow the tea bags to "
          "steep for 10 minutes"
          "\n \n"
          "Remove the tea bags from the water"
          "\n \n"
          "Add the remaining water to the tea. Leave it refrigerated until"
          " fully chilled (about an hour)"
          "\n \n"
          "Serve with ice, lemon slices, and fresh mint if desired",
      imagePath: "common/ice-tea.jpg",
    ),
  );
}
}