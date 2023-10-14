import 'package:flutter/material.dart';

import 'details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(title: 'Recipe Book App'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {

  final List<String> recipes = [
    'Blueberry Pancake',
    'Banana Bread',
    'Chocolate Mug Cake'
  ];

  final List<String> ingredients = [
    "1 cup all-purpose flour, 1 teaspoon baking powder, ⅛ teaspoon ground nutmeg, 1 tablespoon white sugar, 1 egg ½ cup plain yogurt, ½ cup milk, 2 tablespoons vegetable oil, ¾ cup fresh blueberries",
    "3 riped mashed bananas, 1 cup white sugar, 1 egg, ¼ cup melted butter, 1 ½ cups all-purpose flour, 1 teaspoon baking soda, 1 teaspoon salt",
    "¼ cup all-purpose flour, ¼ cup white sugar, 2 tablespoons unsweetened cocoa powder, ⅛ teaspoon baking soda, ⅛ teaspoon salt, 3 tablespoons milk, 2 tablespoons canola oil, 1 tablespoon water, ¼ teaspoon vanilla extract"
  ];

  final List<String> instructions = [
    "Step 1: Preheat griddle over medium heat. Stir together the flour, baking powder, nutmeg and sugar, set aside. \nStep 2: In a medium bowl, stir together the egg, yogurt, milk and oil. Gradually stir in the flour mixture, then fold in the blueberries.\nStep 3: Pour batter onto hot greased griddle, two tablespoons at a time. Cook over medium heat until bubbles pop and stay open, then turn over and cook on the other side until golden.",
    "Step 1: Combine the dry ingredients in one bowl and the wet ingredients in another. \nStep 2: Stir the dry mixture into the wet mixture.\nStep 3: Pour the batter into a prepared loaf pan and bake for 1 hour.",
    "Step 1: Mix flour, sugar, cocoa powder, baking soda, and salt together in a large microwave-safe mug; stir in milk, canola oil, water, and vanilla extract.\nStep 2: Cook in the microwave until cake is done in the middle, about 1 minute 45 seconds."
  ];


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.all(16.0),
          child: Text(
              "Here are your delicious recipes",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(recipes[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(recipeName: recipes[index], recipeIngredient: ingredients[index], recipeInstruction: instructions[index]),
                      ),
                    );
                  },
                );
              }
          )
        ],
      )
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
