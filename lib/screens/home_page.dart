import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_recipe/models/brief_recipe.dart';
import 'package:flutter_recipe/ui_widgets/recipe_card.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<BriefRecipe> _recipes = <BriefRecipe>[];

  @override
  void initState() {
    super.initState();
    _fetchAllRecipes();
  }

  String apiURL =
      "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";

  void _fetchAllRecipes() async {
    //Convert String into Uri Object as http.get() accepts Uri
    var url = Uri.parse(apiURL);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable recipeList = result["meals"];
      setState(() {
        _recipes = recipeList.map((recipe) {
          return BriefRecipe.fromJson(recipe);
        }).toList();
      });
    } else {
      throw Exception('Failed to load Recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Recipe',
          style: TextStyle(
            color: Colors.red,
            fontSize: 30.0,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _recipes.length,
            itemBuilder: (context, index) {
              final recipe = _recipes[index];
              return ListTile(
                title: RecipeCard(recipe: recipe),
              );
            }),
      ),
    );
  }
}
