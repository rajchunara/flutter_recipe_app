import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_recipe/models/recipe_detail_model.dart';
import 'package:http/http.dart' as http;

class RecipeDetails extends StatefulWidget {
  final String recipeId;

  const RecipeDetails({Key? key, required this.recipeId}) : super(key: key);

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState(recipeID: recipeId);
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late DetailedRecipe _detailedRecipe = DetailedRecipe();
  final String recipeID;

  _RecipeDetailsState({required this.recipeID});

  late String detailedRecipeURL;

  @override
  void initState() {
    super.initState();
    detailedRecipeURL =
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$recipeID';

    _fetchRecipe();
  }

  void _fetchRecipe() async {
    var url = Uri.parse(detailedRecipeURL);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable mealList = result["meals"];

      setState(() {
        print('state is setting');
        _detailedRecipe = DetailedRecipe.fromJson(mealList.first);
      });
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_detailedRecipe.strMeal),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Center(child: Text(_detailedRecipe.strInstructions)),
      ),
    );
  }
}
