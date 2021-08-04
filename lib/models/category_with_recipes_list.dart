import 'package:flutter_recipe/models/brief_recipe.dart';

class CategoryWithRecipesList {
  String category;
  bool isSelected = false;
  List<BriefRecipe>? recipes;

  CategoryWithRecipesList({required this.category, this.recipes});

  @override
  String toString() {
    // TODO: implement toString

    return "$category + ${recipes?[0].toString()}";
  }
}
