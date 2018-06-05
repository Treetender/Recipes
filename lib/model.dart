import 'package:flutter/material.dart';

class Recipe {
  String name;
  String description;
  String imageUrl;
  double rating;

  Recipe({this.name, this.description, this.imageUrl, this.rating = 0.0});

  ImageProvider get recipeImage => imageUrl != null
      ? NetworkImage(imageUrl)
      : AssetImage('imgs/blank_recipe.jpg');
}
