import 'package:flutter/material.dart';
import 'package:recipes/model.dart';

class RecipeView extends StatelessWidget {
  final Recipe recipe;

  const RecipeView({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Column(children: <Widget>[
        _createHeaderSection(),
        Center(
          child: Text(recipe.description),
        )
      ]),
    );
  }

  Widget _createHeaderSection() => AspectRatio(
        aspectRatio: 16 / 6,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: recipe.recipeImage,
                alignment: FractionalOffset.center,
                fit: BoxFit.fitWidth),
          ),
        ),
      );
}
