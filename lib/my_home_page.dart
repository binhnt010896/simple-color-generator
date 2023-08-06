import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Define the maximum density value allowed for a color
const maxDensityValue = 255;

/// Define HEX
const hex = 16;

/// Define "Hello there" font size
const titleFontSize = 36.0;

/// MyHomePage is the main and only screen for this application
class MyHomePage extends StatefulWidget {
  /// Constructor of MyHomePage
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _random = Random();
  /// Initiate the first color
  Color _currentColor = Colors.blue;

  /// Use built-in Flutter math library to generate random numbers
  int _randomInt(int min, int max) => min + _random.nextInt(max - min);

  /// Handle generating new color
  void _generateColor() {
    setState(() => _currentColor = _randomColor,);
  }

  /// Generate a new color based on new RGB values.
  Color get _randomColor => Color.fromRGBO(
    _randomInt(0, maxDensityValue),
    _randomInt(0, maxDensityValue),
    _randomInt(0, maxDensityValue),
    1,
  );

  /// Generate complementary color for _currentColor.
  Color get _complementaryColor => Color.fromRGBO(
    maxDensityValue - _currentColor.red,
    maxDensityValue - _currentColor.green,
    maxDensityValue - _currentColor.blue,
    1,
  );

  /// Copy _currentColor in HEX
  Future<void> _copyColor() async {
    await Clipboard.setData(ClipboardData(text: _getColorHex)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Copied current color in HEX"),
        backgroundColor: Colors.green,
      ),);
    });
  }

  /// Get color in HEX string
  String get _getColorHex => '0x${_currentColor.value
      .toRadixString(hex)
      .toUpperCase()}';

  /// Show info about the complementary box
  void _showInfoDialog() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Info'),
        content: const Text(
          'This box is in the complementary color of the background.',
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _currentColor = _randomColor;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _currentColor,
        body: GestureDetector(
          key: const Key('home_bg'),
          onTap: _generateColor,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        color: _complementaryColor,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello there',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w700,
                                color: _currentColor,
                              ),
                            ),
                            Text(
                              'Current color in HEX: $_getColorHex',
                              key: const Key('color_in_hex'),
                              style: TextStyle(color: _currentColor),
                            ),
                            Text('Current color in RGB:\n'
                                'R: ${_currentColor.red}\n'
                                'B: ${_currentColor.blue}\n'
                                'G: ${_currentColor.green}',
                              style: TextStyle(color: _currentColor),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: _showInfoDialog,
                          icon: Icon(Icons.info, color: _currentColor,),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _copyColor,
          child: const Icon(Icons.copy),
        ),
    );
  }}
