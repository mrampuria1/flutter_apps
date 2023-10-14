import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bouncing Ball'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  double ballPosition = 0.0;
  double ballSpeed = 4.0;
  bool isAnimating = false;

  Color ballColor = Colors.white;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  void startAnimation() {
    setState(() {
      isAnimating = true;
    });
    _animateBall();
  }

  void _animateBall() async {
    while (isAnimating) {
      await Future.delayed(Duration(milliseconds: 16)); // Adjust speed here
      setState(() {
        ballPosition += ballSpeed;
        if (ballPosition >= 250.0 || ballPosition <= 0.0) {
          ballSpeed *= -1.0;
        }
      });
    }
  }



  void stopAnimation() {
    setState(() {
      isAnimating = false;
    });
  }

  void changeBallColor() {
    setState(() {
      // You can change the color to any desired color
      if (ballColor==Colors.black){
        ballColor = Colors.white;
      }
      else{
        ballColor = Colors.black;
      }
       // Change to the desired color
    });
  }


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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: ballPosition),
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: ballColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: startAnimation,
              child: Text('Start/Increase speed'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: stopAnimation,
              child: Text('Stop'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: changeBallColor, // Call the function to change color
              child: Text('Change Color'), // Button to change color
            ),

          ]
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  /*
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }*/
}
