import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipes/model.dart';
import 'package:recipes/recipe_view_appbar.dart';

const List<MenuChoice> menuChoices = const [
  const MenuChoice(icon: Icons.edit, name: 'Edit'),
  const MenuChoice(icon: Icons.share, name: 'Share')
];

class RecipeView extends StatefulWidget {
  final Recipe recipe;

  RecipeView({Key key, this.recipe}) : super(key: key);

  @override
  RecipeViewState createState() {
    return new RecipeViewState();
  }
}

class RecipeViewState extends State<RecipeView> {
  Widget _getTabControl(String text) => Container(
        child: Text(text, maxLines: 1, textAlign: TextAlign.start),
        margin: const EdgeInsets.only(top: 16.0),
      );

  Widget _getAppBar(BuildContext context) => AppBar(
        bottom: TabBar(
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              child: _getTabControl('Ingredients'),
            ),
            Tab(
              child: _getTabControl('Instructions'),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            widget.recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: widget.recipe.isFavorite ? Colors.red : Colors.white,
          ),
          onPressed: () {
            setState(() {
              widget.recipe.isFavorite = !widget.recipe.isFavorite;
            });
          },
        ),
        title: Text(
          widget.recipe.name,
        ),
        flexibleSpace: widget.recipe.hasImage
            ? AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 32.0),
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
                  return new PopupMenuItem<MenuChoice>(
                    value: choice,
                    child: new Text(choice.name),
                  );
                }).toList();
              },
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
          appBar: widget.recipe.hasImage
              ? PreferredSize(
                  preferredSize: Size.fromHeight(200.0),
                  child: RecipeViewImageAppBar(recipe: widget.recipe))
              : _getAppBar(context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(
              children: <Widget>[
                StreamBuilder(
                    stream: Firestore.instance
                        .collection('recipes')
                        .document(widget.recipe.id)
                        .collection('ingredients')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return const Text('Loading Ingredients...');
                      if (snapshot.data.documents.length == 0)
                        return const Text(
                            'Add Ingredients by going into Edit Mode');
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) => _buildIngredientTile(
                            context, snapshot.data.documents[index]),
                      );
                    }),
                StreamBuilder(
                    stream: Firestore.instance
                        .collection('recipes')
                        .document(widget.recipe.id)
                        .collection('instructions')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return const Text('Loading Instructions...');
                      if (snapshot.data.documents.length == 0)
                        return const Text(
                            'Add Instructions by going into Edit Mode');
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) => _buildInstructionTile(
                            context, snapshot.data.documents[index]),
                      );
                    }),
              ],
            ),
          )),
    );
  }

  _buildIngredientTile(BuildContext context, DocumentSnapshot document) =>
      ListTile(
        title: Text(document['name'].toString().toUpperCase()),
        subtitle: Text("${document['qty']} ${document['measure']}"),
        leading: Icon(Icons.label),
        trailing: Icon(Icons.check_box_outline_blank),
      );

  _buildInstructionTile(BuildContext context, document) => ListTile(
        title: Text(document['name'].toString().toUpperCase()),
        subtitle: Text(document['step']),
        trailing: Icon(Icons.check_box_outline_blank),
      );
}
