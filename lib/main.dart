import 'package:flutter/material.dart';
import 'package:simple_color_generator/my_home_page.dart';

void main() {
  runApp(const Main());
}

/// Main is the main widget for this application
class Main extends StatelessWidget {
  /// Constructor of Main
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Color Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
