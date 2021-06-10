import 'dart:convert';
import 'dart:ui';

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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: (_recipes.length == 0)
          ? Container(
              child: Center(
              child: Text('Loading recipes'),
            ))
          : CustomScrollView(slivers: [
              SliverAppBar(
                collapsedHeight: 80,
                backgroundColor: Colors.white,
                pinned: true,
                expandedHeight: 350.0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(5.0, 5.0),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 7.0, horizontal: 15.0),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(style: BorderStyle.none),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(width: 0.0),
                            ),
                            enabled: true,
                            hintStyle: TextStyle(fontSize: 12.0),
                            hintText: 'Enter a search recipe',
                          ),
                        ),
                      ),
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/home-page-image.jpg',
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          height: 50,
                          width: width,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Padding widget can not be  used so use SliverList for padding
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    height: 50.0,
                  );
                }, childCount: 1),
              ),

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
  }
}
