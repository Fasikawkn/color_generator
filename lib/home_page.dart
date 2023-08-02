import 'dart:math';

import 'package:color_generator/color_history_widget.dart';
import 'package:flutter/material.dart';

/// This method returns a black color or a white color based on the brightness
/// of the scaffold background color, if background color is brighter black
/// color returned if the background color is darker white color is returned.
Color getTextColor(Color color) {
  return ThemeData.estimateBrightnessForColor(color) == Brightness.dark
      ? Colors.white
      : Colors.black;
}

/// This widget is the widget that we see when we open the app
class HomePage extends StatefulWidget {
  /// Creates the HomePage widget
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _backgroundColor = Colors.white;
  final _colorIntensity = 256;
  final List<Color> _colorHistories = [];

  @override
  void initState() {
    super.initState();
    _backgroundColor = _getRandomColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _updateBackgroundColor,
      child: Scaffold(
        // AnimatedContainer helps in smooth transition of the background
        // color
        body: SafeArea(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: _backgroundColor,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      _openColorHistory(context);
                    },
                    child: Text(
                      'Color History',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: getTextColor(_backgroundColor),
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Hello there!',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: getTextColor(_backgroundColor),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // This method updates the background color of the screen.
  void _updateBackgroundColor() {
    final _randomColor = _getRandomColor();
    setState(() {
      _backgroundColor = _randomColor;
      // add a newly generated color on the first position of the list.
      _colorHistories.insert(0, _randomColor);
    });
  }

  // This method generates and returns a random color.
  Color _getRandomColor() {
    final random = Random();

    return Color.fromRGBO(
      random.nextInt(_colorIntensity), // Red value
      random.nextInt(_colorIntensity), // Green value
      random.nextInt(_colorIntensity), // Blue value
      1.0, // Opacity
    );
  }

  // This method opens a bottomsheet for the history of colors generated.
  Future<void> _openColorHistory(BuildContext context) async {
    final _result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ColorHistoryWidget(
          colorHistories: _colorHistories,
        );
      },
    );

    if (_result != null) {
      setState(
        () {
          _backgroundColor = _result as Color;
        },
      );
    }
  }
}
