import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'database_helper.dart';
import 'calculation_model.dart';
import 'history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _input = '';
  String _output = '';
  String _lastExpression = '';

  final List<String> buttons = const [
    'C',
    '⌫',
    '%',
    '/',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '='
  ];

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _output = '';
      } else if (buttonText == '⌫') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      } else if (buttonText == '=') {
        _evaluate();
      } else {
        _input += buttonText;
      }
    });
  }

  void _evaluate() {
    if (_input.isEmpty) return;

    _lastExpression = _input;

    // Replace symbols with valid math expressions
    String expression = _input.replaceAll('×', '*');

    // Handle % properly: convert 'number%' to '(number/100)'
    // A simple approach to replace all occurrences of a number followed by %
    expression = expression.replaceAllMapped(
      RegExp(r'(\d+(\.\d+)?)%'),
      (match) => '(${match[1]}/100)',
    );

    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      String result = eval.toString();
      if (result.endsWith('.0')) {
        result = result.substring(0, result.length - 2);
      }

      _output = result;
      _insertHistory(result);
      _input = result;
    } catch (e) {
      _output = 'Error';
      _input = '';
    }
  }

  // Asynchronous call to insert into history DB
  void _insertHistory(String finalResult) async {
    if (finalResult != 'Error') {
      final newCalculation = Calculation(
        expression: _lastExpression,
        result: finalResult,
        timestamp: DateTime.now().toIso8601String(),
      );
      await DatabaseHelper.instance.create(newCalculation);
    }
  }

  bool _isOperator(String x) {
    return ['/', '×', '-', '+', '='].contains(x);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            // CHANGE TO FONT AWESOME ICON
            icon: const Icon(
              FontAwesomeIcons.clockRotateLeft,
              color: Colors.white,
              size:
                  24, // Adjust size, as FA icons can be larger than Material Icons
            ),
            tooltip: 'History',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _input,
                      style:
                          const TextStyle(fontSize: 32, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _output,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final button = buttons[index];

                    Color bgColor = _isOperator(button)
                        ? Colors.deepPurple
                        : button == 'C'
                            ? Colors.red
                            : button == '⌫'
                                ? Colors.orange
                                : Colors.white;
                    Color textColor =
                        _isOperator(button) || button == 'C' || button == '⌫'
                            ? Colors.white
                            : Colors.black;

                    return ElevatedButton(
                      onPressed: () => _onButtonPressed(button),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        elevation: 4,
                      ),
                      child: Text(
                        button,
                        style: TextStyle(
                          fontSize: 24,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
