import 'package:flutter/material.dart';
import 'model.dart';

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
    description: 'A delicious British favorite that is moist, sweet and chocolatey!'
  ),
  Recipe(
    name: 'Homemade Beef Chilli',
    description: 'A country home favorite and delicous on a cold day'
  ),
  Recipe(
    name: 'White Chocolate Cheesecake',
    description: 'A lighter variant of the popular cheesecake, but still just as sweet'
  ),
  Recipe(
    name: 'Gnocchi',
    description: 'A curly clumpy pasta made from sweet potato or potatoes'
  ),
  Recipe(
    name: 'Chicken in a Hurry',
    description: 'A quick Newfoundland dish that is a tasty onion sauce chicken'
  ),
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget _buildRecipeTile(BuildContext context, int index) {
    return Text(recipes[index].name);
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView.builder(
        itemCount: recipes.length,
        itemBuilder: _buildRecipeTile,
              ),
              floatingActionButton: new FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: new Icon(Icons.add),
              ),
            );
          }
        
          
}
