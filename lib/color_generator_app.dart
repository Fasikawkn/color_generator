import 'package:color_generator/home_page.dart';
import 'package:flutter/material.dart';

/// The root widget of the app
class ColorGeneratorApp extends StatelessWidget {
  /// Creates the ColorGeneratorApp widget
  const ColorGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
