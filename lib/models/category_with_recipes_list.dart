import 'package:flutter_recipe/models/brief_recipe.dart';

class CategoryWithRecipesList {
  late String category;
  bool isSelected = false;
  List<BriefRecipe>? recipes;

  CategoryWithRecipesList({required category, recipes});

  @override
  String toString() {
    // TODO: implement toString
    
    return "$category + ${recipes?[0].toString()}";
  }
}
