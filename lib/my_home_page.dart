import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Define the maximum density value allowed for a color
const maxDensityValue = 255;

/// Define HEX
const hex = 16;

/// Define the number of digits after decimal points for double variables
const roundDecimalPoint = 2;

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
  /// Generate double from 0 to 1, so there's no need for parameters
  double _randomDouble() => _random.nextDouble();

  /// Handle generating new color
  void _generateColor() {
    setState(() => _currentColor = _randomColor,);
  }

  /// Generate a new color based on new RGBO values.
  Color get _randomColor => Color.fromRGBO(
    _randomInt(0, maxDensityValue),
    _randomInt(0, maxDensityValue),
    _randomInt(0, maxDensityValue),
    _randomDouble(),
  );

  Future<void> _copyColor() async {
    await Clipboard.setData(ClipboardData(text: _getColorHex)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        key: Key('copied_snackbar'),
        content: Text("Copied current color in HEX"),
        backgroundColor: Colors.green,
      ),);
    });
  }

  String get _getColorHex => '0x${_currentColor.value
      .toRadixString(hex)
      .toUpperCase()}';

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
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello there',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Current color in HEX: $_getColorHex',
                          key: const Key('color_in_hex'),
                        ),
                        Text('Current color in RGBO:\n'
                            'R: ${_currentColor.red}\n'
                            'B: ${_currentColor.blue}\n'
                            'G: ${_currentColor.green}\n'
                            'O: ${_currentColor.opacity
                            .toStringAsFixed(roundDecimalPoint)}'
                        )
                      ],
                    ),
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
