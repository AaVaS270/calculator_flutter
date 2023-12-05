import 'package:flutter/material.dart';

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

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalcViewState();
}

class _CalcViewState extends State<CalculatorView> {
  List<String> str = [
    "c", "*", "/", "<-", "1", "2", "3", "+", "4", "5", "6", "-", "7", "8", "9", "*", "%", "0", '.', "="
  ];

  final firstNumController = TextEditingController();
  final secondNumController = TextEditingController();
  final operationController = TextEditingController();

  int firstnum = 0;
  int secondnum = 0;
  int result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstNumController,
                      decoration: InputDecoration(
                        // Remove the border
                        border: InputBorder.none,
                        // Additional styling
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        filled: true,
                        fillColor: Colors.blueGrey.withOpacity(0.1),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: secondNumController,
                      decoration: InputDecoration(
                        // Remove the border
                        border: InputBorder.none,
                        // Additional styling
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        filled: true,
                        fillColor: Colors.blueGrey.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
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
                          backgroundColor: Colors.blueGrey,
                          foregroundColor: Colors.white,
                        ),
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
    firstNumController.text += buttonText;
    switch (buttonText) {
      case '+':
        operationController.text = '+';
        firstNumController.text = '';
        break;
      case '-':
        operationController.text = '-';
        firstNumController.text = '';
        break;
      case '*':
        operationController.text = '*';
        firstNumController.text = '';
        break;
      case 'c':
        operationController.text = '';
        firstNumController.clear();
        secondNumController.clear();
        firstnum = 0;
        secondnum = 0;
        break;
      case '=':
        if (operationController.text == "+") {
          result = firstnum + secondnum;
          firstNumController.text = result.toString();
        } else if (operationController.text == '-') {
          result = secondnum - firstnum;
          firstNumController.text = result.toString();
        } else if (operationController.text == '*') {
          result = firstnum * secondnum;
          firstNumController.text = result.toString();
        }
        secondNumController.text = '';
        break;
      default:
        if (operationController.text.isNotEmpty) {
          firstnum = int.tryParse(firstNumController.text) ?? 0;
        } else {
          secondNumController.text += buttonText;
        }
        secondnum = int.tryParse(secondNumController.text) ?? 0;
    }
  }
}
