import 'package:flutter/material.dart';

class Recipe {
  String name;
  String description;
  String imageUrl;
  String id;
  double rating;
  bool isFavorite;

  bool get hasImage => imageUrl != null;

  Recipe({this.name, this.description, this.imageUrl, this.id, this.rating = 0.0, this.isFavorite = false});

  ImageProvider get recipeImage => imageUrl != null
      ? NetworkImage(imageUrl)
      : AssetImage('imgs/blank_recipe.jpg');
}

class MenuChoice {
  final IconData icon;
  final String name;

  const MenuChoice({this.icon, this.name});
}
