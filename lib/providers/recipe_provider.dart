import 'package:flutter/material.dart';
import 'package:flutter_recipe/models/brief_recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeProvider extends ChangeNotifier {
  /* State */
  bool isLoading = false;
  List<String>? categoryList;




  final String _categoriesListURL =
      "https://www.themealdb.com/api/json/v1/1/list.php?c=list";
  final String _categoryApiUrl =
      "https://www.themealdb.com/api/json/v1/1/filter.php?c=";

  RecipeProvider() {
    fetchListOfCategories();
  }

/* Fetch all categories list */
  Future fetchListOfCategories() async {
    toggleLoadingState();

    var url = Uri.parse(_categoriesListURL);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable catgList = result["meals"];
      categoryList = [
        'All',
        ...catgList.map((categoryJson) {
          return categoryJson["strCategory"];
        }).toList()
      ];

      toggleLoadingState();
    } else {
      throw Exception('Failed to load categories list');
    }

    notifyListeners();
  }

  /* Fetch all recipes for one category */
  Future_fetchAllRecipes(String category) async {
    //Convert String into Uri Object as http.get() accepts Uri
    var url = Uri.parse(_categoryApiUrl+category);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable recipeList = result["meals"];
      _recipes = recipeList.map((recipe) {
        return BriefRecipe.fromJson(recipe);
      }).toList();
    } else {
      throw Exception('Failed to load Recipes');
    }
  }

  void toggleLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
