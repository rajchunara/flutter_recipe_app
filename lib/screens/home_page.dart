import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_recipe/models/brief_recipe.dart';
import 'package:flutter_recipe/providers/recipe_provider.dart';
import 'package:flutter_recipe/ui_widgets/app_bar_home_screen.dart';
import 'package:flutter_recipe/ui_widgets/recipe_card.dart';
import 'package:flutter_recipe/ui_widgets/recipe_categories_list.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

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

  String categoryApiUrl =
      "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";

  String categoriesListURL =
      "https://www.themealdb.com/api/json/v1/1/list.php?c=list";

/* Fetch all categories list */
  // void _fetchListOfCategories() async {
  //   var url = Uri.parse(categoriesListURL);
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final result = jsonDecode(response.body);
  //     Iterable catgList = result["meals"];
  //     setState(() {
  //       _categoriesList = [
  //         'All',
  //         ...catgList.map((categoryJson) {
  //           return categoryJson["strCategory"];
  //         }).toList()
  //       ];
  //     });
  //   } else {
  //     throw Exception('Failed to load categories list');
  //   }
  // }

/* Fetch recipes */
  void _fetchAllRecipes() async {
    //Convert String into Uri Object as http.get() accepts Uri
    var url = Uri.parse(categoryApiUrl);
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
    double width = MediaQuery.of(context).size.width;

    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
        return Scaffold(
          body: ((_recipes.length == 0 && recipeProvider.categoryList == null))
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.green,
                ))
              : CustomScrollView(slivers: [
                  AppBarHomeScreen(),

                  //Padding widget can not be  used so use SliverList for padding
                  /* Recipe types */
                  // SliverList(
                  //   delegate: SliverChildBuilderDelegate(
                  //       (BuildContext context, int index) {
                  //     return Container(
                  //       height: 60.0,
                  //       child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         itemBuilder: (context, index) {
                  //           return Container(
                  //             alignment: Alignment.center,
                  //             padding: EdgeInsets.symmetric(horizontal: 15.0),
                  //             child: Container(
                  //               padding: EdgeInsets.symmetric(
                  //                   vertical: 5.0, horizontal: 10),
                  //               child: Text(
                  //                 _categoriesList?[index],
                  //                 style: TextStyle(
                  //                     fontSize: 15.0, color: Colors.white),
                  //               ),
                  //               decoration: BoxDecoration(
                  //                   color: Colors.black87,
                  //                   borderRadius: BorderRadius.all(
                  //                       Radius.circular(15.0))),
                  //             ),
                  //           );
                  //         },
                  //         itemCount: _categoriesList?.length,
                  //       ),
                  //     );
                  //   }, childCount: 1),
                  // ),

                  RecipeCategoriesList(),

                  /* Recipe Grid */
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 280.0),
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final recipe = _recipes[index];
                      return RecipeCard(recipe: recipe);
                    }, childCount: _recipes.length),
                  )
                ]),
        );
      },
    );
  }
}
