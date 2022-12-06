import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:mobile_application/app/model/recipe.dart';

/*
 * Scrapes a recipe from AllRecipes.com
 */
class WebScrapePageState {
  static Future<Recipe> getWebsiteData(String webUrl) async {
    final url = Uri.parse(webUrl);
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final title = html.querySelector('#article-heading_2-0')!.innerHtml.trim().toString();
    final description = html.querySelector('#article-subheading_2-0')!.innerHtml.trim().toString();
    final webIngredients = html.querySelector('#mntl-structured-ingredients_1-0 > ul')?.children.toList();
    final directions = html.querySelector('#mntl-sc-block_2-0')?.children.toList();

    //// Ingredients
    final List<List<dom.Element>> aIngredients = [];
    for (int i = 0; i < webIngredients!.length; i++) {
      aIngredients.add(webIngredients.elementAt(i).children.toList());
    }
    List<dom.Element> bIngredients = [];
    for (int i = 0; i < aIngredients.length; i++) {
      for (int j = 0; j < aIngredients.elementAt(i).length; j++) {
        bIngredients.add(aIngredients.elementAt(i).elementAt(j));
      }
    }
    final List<String> ingredients = [];
    for (int i = 0; i < bIngredients.length; i++) {
      String string = "";
      final c = bIngredients.elementAt(i).children.toList();
      for (int j = 0; j < c.length; j++) {
        string = "$string ${c.elementAt(j).innerHtml}";
      }
      ingredients.add(string);
    }

    //// Direction
    List<String> directionPart = [];
    for (int i = 0; i < directions!.length; i++) {
      String d = directions.elementAt(i).children[0].innerHtml;
      if (d.trim() != ',') {
        directionPart.add(d);
      } else {
        directionPart.add("\n\n");
      }
    }
    String directionString = "";
    for (int i = 0; i < directionPart.length; i++) {
      directionString = "$directionString ${directionPart.elementAt(i)}";
    }

    return Recipe(instructions: directionString, measurements: ingredients,
        name: title, description: description, servingSize: 4);
  }
}