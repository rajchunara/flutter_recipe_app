class BriefRecipe {
  String strMeal;
  String strMealThumb;
  String idMeal;

  BriefRecipe(
      {required this.strMeal,
      required this.strMealThumb,
      required this.idMeal});

  factory BriefRecipe.fromJson(Map<String, dynamic> json) {
    return BriefRecipe(
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      idMeal: json['idMeal'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strMeal'] = this.strMeal;
    data['strMealThumb'] = this.strMealThumb;
    data['idMeal'] = this.idMeal;
    return data;
  }
}
