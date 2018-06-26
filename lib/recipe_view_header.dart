import 'package:flutter/material.dart';
import 'package:recipes/model.dart';

class RecipeHeader extends StatelessWidget {
  final Recipe recipe;

  const RecipeHeader({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headLineTheme =
        Theme.of(context).textTheme.headline.apply(color: Colors.white);

    return SizedBox(
      height: 450.0,
          child: Stack(
        fit: StackFit.expand,
        children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            margin: const EdgeInsets.only(bottom: 32.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: recipe.recipeImage,
                  alignment: FractionalOffset.center,
                  fit: BoxFit.fitWidth),

            ),
          ),
        ),
        Positioned(
          child: Text(
            recipe.name,
            textAlign: TextAlign.start,
            style: headLineTheme,
            softWrap: true,
          ),
          bottom: 32.0,
          left: 16.0,
        ),
        Positioned(
            child: Text(
              "Time: 1 hour",
              style: TextStyle(color: Colors.white),
            ),
            bottom: 32.0,
            right: 16.0),
      ]),
    );
  }
}
