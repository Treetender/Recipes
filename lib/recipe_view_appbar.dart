import 'package:flutter/material.dart';
import 'package:recipes/model.dart';

const List<MenuChoice> menuChoices = const [
  const MenuChoice(icon: Icons.edit, name: 'Edit'),
  const MenuChoice(icon: Icons.share, name: 'Share')
];

class RecipeViewImageAppBar extends StatefulWidget {
  final Recipe recipe;

  const RecipeViewImageAppBar({Key key, this.recipe}) : super(key: key);

  @override
  _RecipeViewImageAppBarState createState() => _RecipeViewImageAppBarState();
}

class _RecipeViewImageAppBarState extends State<RecipeViewImageAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        decoration: BoxDecoration(color: Colors.black54),
        child: Text(
          widget.recipe.name,
        ),
      ),
      titleSpacing: 0.0,
      flexibleSpace: widget.recipe.hasImage
          ? AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: widget.recipe.recipeImage,
                      alignment: FractionalOffset.center,
                      fit: BoxFit.fitWidth),
                ),
              ),
            )
          : null,
      actions: <Widget>[
        Theme(
          data: Theme.of(context).copyWith(
              iconTheme:
                  Theme.of(context).iconTheme.copyWith(color: Colors.white)),
          child: PopupMenuButton<MenuChoice>(
            itemBuilder: (BuildContext context) {
              return menuChoices.map((MenuChoice choice) {
                return PopupMenuItem<MenuChoice>(
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Icon(choice.icon),
                      Text(choice.name),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ),
      ],
    );
  }
}
