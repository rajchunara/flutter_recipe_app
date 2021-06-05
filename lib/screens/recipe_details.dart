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

  Widget imageContainer() {
    return _detailedRecipe.strMealThumb.length != 0
        ? Container(
            width: double.infinity,
            height: 500.0,
            color: Colors.white,
            child: Center(
              child: Text('Loading Recipe...'),
            ),
          )
        : Image.network(
            _detailedRecipe.strMealThumb,
            fit: BoxFit.fill,
          );
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _detailedRecipe.strMeal == ''
          ? Container(
              child: Center(
                child: Text('Loading recipe....'),
              ),
            )
          : SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    expandedHeight: 400.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              _detailedRecipe.strMealThumb,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[
                                    Colors.black.withAlpha(0),
                                    Colors.black.withAlpha(0),
                                    Colors.black38,
                                    Colors.black54
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: Text(
                        _detailedRecipe.strMeal,
                        style: TextStyle(fontSize: 30.0),
                      ),
                      titlePadding: EdgeInsets.only(left: 20, bottom: 20),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          height: 30.0,
                          // color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_detailedRecipe.strArea,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15)),
                              VerticalDivider(
                                color: Colors.grey,
                                width: 50.0,
                              ),
                              Text(_detailedRecipe.strCategory,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15)),
                            ],
                          ),
                        ),
                        //Instructions UI
                        Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Instructions',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              // SizedBox(
                              //   height: 3,
                              // ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20),
                                child: Text(
                                  _detailedRecipe.strInstructions,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 340,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );

    // Scaffold(
    //   body: Container(
    //     child: ListView(
    //       children: [
    //         Stack(
    //           children: [
    //             imageContainer(),
    //             Positioned(
    //               child: Container(
    //                 height: 100.0,
    //                 padding: const EdgeInsets.all(15.0),
    //                 alignment: Alignment.bottomCenter,
    //                 decoration: BoxDecoration(
    //                   gradient: LinearGradient(
    //                     end: Alignment.topCenter,
    //                     begin: Alignment.bottomCenter,
    //                     colors: <Color>[
    //                       Colors.black.withAlpha(0),
    //                       Colors.black12,
    //                       Colors.black54
    //                     ],
    //                   ),
    //                 ),
    //                 // child: Text(
    //                 //   _detailedRecipe.strMeal,
    //                 //   style: TextStyle(color: Colors.white, fontSize: 20.0),
    //                 // ),
    //               ),
    //             ),
    //             Positioned(
    //               top: 20.0,
    //               left: 20.0,
    //               child: GestureDetector(
    //                 child: Icon(
    //                   Icons.arrow_back,
    //                   color: Colors.white,
    //                   size: 30.0,
    //                 ),
    //                 onTap: () {
    //                   Navigator.pop(context);
    //                 },
    //               ),
    //             ),
    //             Positioned(
    //               bottom: 0.0,
    //               child: Container(
    //                 alignment: Alignment.bottomCenter,
    //                 width: width,
    //                 height: 50.0,
    //                 decoration: BoxDecoration(
    //                   color: Colors.grey[50],
    //                   borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(
    //                       30.0,
    //                     ),
    //                     topRight: Radius.circular(30.0),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         Text(_detailedRecipe.strInstructions)
    //       ],
    //     ),
    //   ),
    // );
  }
}
