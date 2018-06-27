import 'package:flutter/material.dart';
import 'package:recipes/model.dart';
import 'package:recipes/recipe_view.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new MyHomePage(title: 'Recipes'),
    );
  }
}

final List<Recipe> recipes = [
  Recipe(
      name: 'Pumpkin Chocolate Chip Cookies',
      description:
          'A delicious British favorite that is moist, sweet and chocolatey!',
      imageUrl:
          'http://www.veganinsanity.com/wp-content/uploads/2014/10/Pumpkin-Oat-Chocolate-Chip-Cookies.jpg'),
  Recipe(
      name: 'Homemade Beef Chilli',
      description: 'A country home favorite and delicous on a cold day'),
  Recipe(
      name: 'White Chocolate Cheesecake',
      description:
          'A lighter variant of the popular cheesecake, but still just as sweet'),
  Recipe(
      name: 'Gnocchi',
      description: 'A curly clumpy pasta made from sweet potato or potatoes'),
  Recipe(
      name: 'Chicken in a Hurry',
      description:
          'A quick Newfoundland dish that is a tasty onion sauce chicken'),
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _buildRecipeTile(BuildContext context, DocumentSnapshot document) {
    var recipe = Recipe(
      description: document['description'],
      name: document['name'],
      imageUrl: document['imageUrl'],
      rating: double.parse(document['rating'].toString()),
      isFavorite: false,
      id: document.documentID
    );
    return new GestureDetector(
      child: new Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: new Row(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: new CircleAvatar(
                backgroundImage: recipe.recipeImage,
              ),
            ),
            new Flexible(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    recipe.name,
                    style: Theme.of(context).textTheme.body2,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    recipe.description,
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new RecipeView(recipe: recipe),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
              stream: Firestore.instance.collection('recipes').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading....');
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) =>
                      _buildRecipeTile(context, snapshot.data.documents[index]),
                );
              })),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add Recipe',
        child: new Icon(Icons.add),
      ),
    );
  }
}
