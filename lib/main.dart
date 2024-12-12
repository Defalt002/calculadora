import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String result = "0";
  String operation = "";
  double? num1;
  double? num2;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        input = "";
        result = "0";
        num1 = null;
        num2 = null;
        operation = "";
      } else if (buttonText == "=" && operation.isNotEmpty) {
        num2 = double.tryParse(input);

        if (num1 != null && num2 != null) {
          switch (operation) {
            case "+":
              result = (num1! + num2!).toString();
              break;
            case "-":
              result = (num1! - num2!).toString();
              break;
            case "x":
              result = (num1! * num2!).toString();
              break;
            case "/":
              result = num2 != 0 ? (num1! / num2!).toString() : "Erro";
              break;
          }
        }

        input = "";
        operation = "";
        num1 = null;
        num2 = null;
      } else if (["+", "-", "x", "/"].contains(buttonText)) {
        if (input.isNotEmpty) {
          num1 = double.tryParse(input);
          operation = buttonText;
          input = "";
        }
      } else {
        input += buttonText;
        result = input;
      }
    });
  }

  Widget buildButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Calculadora Flutter"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                result,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              buildButton("7", Colors.blue),
              buildButton("8", Colors.blue),
              buildButton("9", Colors.blue),
              buildButton("/", Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton("4", Colors.blue),
              buildButton("5", Colors.blue),
              buildButton("6", Colors.blue),
              buildButton("x", Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton("1", Colors.blue),
              buildButton("2", Colors.blue),
              buildButton("3", Colors.blue),
              buildButton("-", Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton("C", Colors.red),
              buildButton("0", Colors.blue),
              buildButton("=", Colors.green),
              buildButton("+", Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
