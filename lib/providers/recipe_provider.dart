import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipe/models/brief_recipe.dart';
import 'package:flutter_recipe/models/category_with_recipes_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class RecipeProvider extends ChangeNotifier {
  /* State */
  bool isLoading = false;
  List<String>? categoryList;
  List<CategoryWithRecipesList>? categoryWithRecipesList;

  final String _categoriesListURL =
      "https://www.themealdb.com/api/json/v1/1/list.php?c=list";
  final String _categoryApiUrl =
      "https://www.themealdb.com/api/json/v1/1/filter.php?c=";

  RecipeProvider() {
    initializeState();
  }

  void initializeState() async {
    categoryWithRecipesList = <CategoryWithRecipesList>[];
    toggleLoadingState();
    await _fetchListOfCategories();
    await _fetchRecipesForAllCategories();
    toggleLoadingState();
    // categoryWithRecipesList?.forEach((element) {
    //   print(element.toString());
    // });
  }

/* Fetch all categories list */
  Future _fetchListOfCategories() async {
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
  }

  /* Fetch recipes for all categories one by one */
  Future _fetchRecipesForAllCategories() async {
    if (categoryList != null || categoryList?.length != 0) {
      categoryList?.forEach((category) async {
        if (category == 'All') return;
        List<BriefRecipe> recipeList = await _fetchAllRecipes(category);
        CategoryWithRecipesList categoryWithRecipes =
            CategoryWithRecipesList(category: category, recipes: recipeList);
        categoryWithRecipesList?.add(categoryWithRecipes);
      });
    }
  }

  /* Fetch all recipes for one category */
  Future<List<BriefRecipe>> _fetchAllRecipes(String category) async {
    //Convert String into Uri Object as http.get() accepts Uri
    var url = Uri.parse(_categoryApiUrl + category);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable recipeList = result["meals"];
      return recipeList.map((recipe) {
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
