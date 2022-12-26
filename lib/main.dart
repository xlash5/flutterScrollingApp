import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

// list of rainbow colors that will be used to paint the background
final List<Color> rainbowColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];

// card with 100 height and 10 border radius and centered text
Widget _card(Color color) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'Card',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repeatedRainbowColors = List.generate(
    100,
    (index) => rainbowColors[index % rainbowColors.length],
  );
  final ScrollController _scrollController = ScrollController();

  // scroll to top of the list
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  // scroll to bottom of the list
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  // scroll to bottom then scroll to top 20 times with 1 second delay
  void _scrollToBottomAndTop() async {
    for (var i = 0; i < 20; i++) {
      _scrollToBottom();
      await Future.delayed(const Duration(seconds: 1));
      _scrollToTop();
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        children: repeatedRainbowColors.map((e) => _card(e)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToBottomAndTop,
        child: const Icon(Icons.add),
      ),
    );
  }
}
