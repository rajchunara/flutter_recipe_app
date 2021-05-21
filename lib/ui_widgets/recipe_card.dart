import 'package:flutter/material.dart';
import 'package:flutter_recipe/models/brief_recipe.dart';
import 'package:flutter_recipe/screens/recipe_details.dart';

class RecipeCard extends StatelessWidget {
  final BriefRecipe recipe;

  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            Image.network(
              recipe.strMealThumb,
              height: 180.0,
              width: 180.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(recipe.strMeal),
            )
          ],
        ),
      ),
      onTap: () {
        print(recipe.strMeal);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipeDetails(
                    recipeId: recipe.idMeal,
                  )),
        );
      },
    );
  }
}
