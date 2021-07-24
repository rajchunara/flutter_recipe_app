import 'package:flutter/material.dart';

class AppBarHomeScreen extends StatelessWidget {
  const AppBarHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SliverAppBar(
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
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
    );
  }
}
