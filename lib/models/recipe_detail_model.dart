import 'package:flutter_recipe/models/brief_recipe.dart';

class DetailedRecipe extends BriefRecipe {
  String strCategory;
  String strArea;
  String strInstructions;
  String strMeal;
  String strMealThumb;
  String idMeal;

  DetailedRecipe(
      {this.strMeal = '',
      this.strMealThumb = '',
      this.idMeal = '',
      this.strArea = '',
      this.strCategory = '',
      this.strInstructions = ''})
      : super(strMeal: strMeal, strMealThumb: strMealThumb, idMeal: idMeal);

  factory DetailedRecipe.fromJson(Map<String, dynamic> json) {
    return DetailedRecipe(
        strMeal: json['strMeal'],
        strMealThumb: json['strMealThumb'],
        idMeal: json['idMeal'],
        strArea: json['strArea'],
        strCategory: json['strCategory'],
        strInstructions: json['strInstructions']);
  }
}
