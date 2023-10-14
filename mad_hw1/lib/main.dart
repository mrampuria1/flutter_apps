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
      title: 'Calculator App',
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
      home: const MyHomePage(title: 'Calculator App'),
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

class _MyHomePageState extends State<MyHomePage> {
  String display = '';
  int num1 = 0;
  int num2 = 0;
  String operator = '';
  bool shouldClear = false;

  void _ButtonClick(String value){
    if (value == 'C') {
      // Clear the calculator
      setState(() {
        display = '';
        num1 = 0;
        num2 = 0;
        operator = '';
        shouldClear = false;
      });
    }
    else if (value == '=' && operator.isNotEmpty && display.isNotEmpty) {
      var result;
      switch (operator) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          if (num2 != 0) {
            result = (num1 / num2).round();
          } else {
            result = "Error"; // Handle division by zero
          }
          break;
      }

      if (result=="Error"){
        setState(() {
          display = result.toString();
          num1 = 0;
          num2 = 0;
          operator = '';
          shouldClear = true;
        });
      }
      else{
        setState(() {
          display = result.toString();
          num1 = result;
          num2 = 0;
          operator = '';
          shouldClear = true;
        });
      }
    }
    else if (value == '+' || value == '-' || value == '*' || value == '/') {
      // Set the operator for calculation
      setState(() {
        operator = value;
        shouldClear = true;
      });
    }
    else {
      // Append the entered value to the display
      setState(() {
        if (shouldClear) {
          display = value;
          shouldClear = false;
        } else {
          display += value;
        }
        if (operator.isEmpty) {
          num1 = int.parse(display);
        } else {
          num2 = int.parse(display);
        }
      });
    }
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
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(16),
                child: Text(
                  display,
                  style: TextStyle(fontSize: 36),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton('C'),
                _buildButton('0'),
                _buildButton('='),
                _buildButton('+'),
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () => _ButtonClick(text),
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
