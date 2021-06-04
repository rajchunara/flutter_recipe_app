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
        "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$recipeID";

    _fetchRecipe();
  }

  void _fetchRecipe() async {
    var url = Uri.parse(detailedRecipeURL);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable mealList = result["meals"];

      setState(() {
        _detailedRecipe = DetailedRecipe.fromJson(mealList.first);
      });
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  Widget ImageContainer() {
    return _detailedRecipe.strMealThumb == ''
        ? Container(
            width: double.infinity,
            height: 500.0,
            color: Colors.white,
          )
        : Image.network(
            _detailedRecipe.strMealThumb,
            fit: BoxFit.fill,
          );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Stack(
              children: [
                ImageContainer(),
                Positioned(
                  child: Container(
                    height: 100.0,
                    padding: const EdgeInsets.all(15.0),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        end: Alignment.topCenter,
                        begin: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black.withAlpha(0),
                          Colors.black12,
                          Colors.black54
                        ],
                      ),
                    ),
                    // child: Text(
                    //   _detailedRecipe.strMeal,
                    //   style: TextStyle(color: Colors.white, fontSize: 20.0),
                    // ),
                  ),
                ),
                Positioned(
                  top: 20.0,
                  left: 20.0,
                  child: GestureDetector(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: width,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          30.0,
                        ),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(_detailedRecipe.strInstructions)
          ],
        ),
      ),
    );
  }
}
