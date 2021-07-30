import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeProvider extends ChangeNotifier {
  bool isLoading = false;
  List<String>? categoryList;
  String categoriesListURL =
      "https://www.themealdb.com/api/json/v1/1/list.php?c=list";

  RecipeProvider() {
    fetchListOfCategories(categoriesListURL);
  }

/* Fetch all categories list */
  Future fetchListOfCategories(String categoriesListURL) async {
    toggleLoadingState();

    var url = Uri.parse(categoriesListURL);
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

  void toggleLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
