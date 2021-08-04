import 'package:flutter/material.dart';
import 'package:flutter_recipe/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

class RecipeCategoriesList extends StatelessWidget {
  const RecipeCategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
        return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              height: 60.0,
              child: (recipeProvider.categoryList == null ||
                      recipeProvider.categoryList?.length == 0)
                  ? Center(
                      child: Text("Something went wrong.."),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            recipeProvider.displayRecipes(
                                category: recipeProvider.categoryList![index]);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                              child: Text(
                                recipeProvider.categoryList![index],
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                color: (recipeProvider.categorySelected ==
                                        recipeProvider.categoryList![index])
                                    ? Colors.black87
                                    : Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: recipeProvider.categoryList?.length,
                    ),
            );
          }, childCount: 1),
        );
      },
    );
  }
}
