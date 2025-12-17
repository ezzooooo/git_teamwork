import 'package:flutter/material.dart';
import 'package:git_teamwork/constants/string.dart';
import 'package:git_teamwork/genbox_widget.dart';
import 'package:git_teamwork/slider_box_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isChecked = false;

  void _incrementCounter() {
    Colors.blue.shade500;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppString.appName),
      ),
      body: isChecked
          ? Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    'You have pushed the button this many times:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text('aa', style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const Text('You have pushed the button this many times:'),
                  Text('aa', style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GenderBox(),
          SliderBox(),
          ElevatedButton(onPressed: () {}, child: Text('Calculate')),
        ],
      ),
    );
  }
}
