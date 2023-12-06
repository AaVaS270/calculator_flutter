import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  @override
  _CalcViewState createState() => _CalcViewState();
}

class _CalcViewState extends State<CalculatorView> {
  List<String> str = [
    "c", "*", "/", "<-", "1", "2", "3", "+", "4", "5", "6", "-", "7", "8", "9", "*", "%", "0", '.', "="
  ];

  final inputController = TextEditingController();
  String currentNumber = "";
  String firstNumber = "";
  String secondNumber = "";
  String operation = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: inputController,
                textAlign: TextAlign.right,
                readOnly: true,
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(8),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 4,
                children: [
                  for (int i = 0; i < str.length; i++) ...{
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            handleButtonPress(str[i]);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white),
                        child: Text(
                          str[i],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  }
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // function to handle calculator functionality
  void handleButtonPress(String buttonText) {
    if (buttonText == "<-") {
      handleBackspace();
    } else if (buttonText == "c") {
      handleClear();
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      handleOperator(buttonText);
    } else if (buttonText == "=") {
      handleEqual();
    } else {
      handleNumber(buttonText);
    }
  }

  void handleBackspace() {
    String currentText = inputController.text;
    if (currentText.isNotEmpty) {
      setState(() {
        inputController.text = currentText.substring(0, currentText.length - 1);
      });
    }
  }

  void handleClear() {
    setState(() {
      inputController.clear();
      currentNumber = "";
      firstNumber = "";
      secondNumber = "";
      operation = "";
    });
  }

  void handleOperator(String operator) {
    if (currentNumber.isNotEmpty) {
      setState(() {
        operation = operator;
        firstNumber = currentNumber;
        currentNumber = "";
        inputController.text = firstNumber + operation;
      });
    }
  }

  void handleEqual() {
    if (operation.isNotEmpty && currentNumber.isNotEmpty) {
      int num1 = int.tryParse(firstNumber) ?? 0;
      int num2 = int.tryParse(currentNumber) ?? 0;

      switch (operation) {
        case "+":
          currentNumber = (num1 + num2).toString();
          break;
        case "-":
          currentNumber = (num1 - num2).toString();
          break;
        case "*":
          currentNumber = (num1 * num2).toString();
          break;
        case "/":
          if (num2 != 0) {
            currentNumber = (num1 ~/ num2).toString(); // Using integer division for simplicity
          } else {
            currentNumber = "Error"; // Division by zero, handle as needed
          }
          break;
      }

      setState(() {
        inputController.text = currentNumber;
        operation = "";
        firstNumber = "";
        secondNumber = "";
      });
    }
  }

  void handleNumber(String number) {
    setState(() {
      currentNumber += number;
      inputController.text = firstNumber + operation + currentNumber;
    });
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorView(),
    );
  }
}
