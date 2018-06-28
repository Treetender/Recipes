import 'package:flutter/material.dart';
import 'package:recipes/model.dart';

class RecipeHeader extends StatelessWidget {
  final Recipe recipe;

  const RecipeHeader({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
        recipe.name,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.headline,
        softWrap: true,
      ),
      AspectRatio(
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
      ),
      
    ]);
  }
}
