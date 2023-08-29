import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  double _firstOperand = 0;
  String _operator = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _firstOperand = 0;
        _operator = '';
      } else if (buttonText == '=') {
        if (_operator.isNotEmpty) {
          final double secondOperand = double.parse(_input);
          switch (_operator) {
            case '+':
              _input = (_firstOperand + secondOperand).toString();
              break;
            case '-':
              _input = (_firstOperand - secondOperand).toString();
              break;
            case 'X':
              _input = (_firstOperand * secondOperand).toString();
              break;
            case '/':
              _input = (_firstOperand / secondOperand).toString();
              break;
          }
          _operator = '';
        }
      } else if ('+-X/'.contains(buttonText)) {
        _operator = buttonText;
        _firstOperand = double.parse(_input);
        _input = '';
      } else {
        _input += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator',
        style: TextStyle(fontSize: 20),),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _input,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _input,
                style: TextStyle(fontSize: 48),
              ),
            ),
            ]
          ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('7', textColor:Colors.black),
                    _buildButton('8', textColor:Colors.black),
                    _buildButton('9', textColor:Colors.black),
                    _buildFunctionButton('/',Colors.orangeAccent ),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4', textColor:Colors.black),
                    _buildButton('5', textColor:Colors.black),
                    _buildButton('6', textColor:Colors.black),
                    _buildFunctionButton('X', Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1', textColor:Colors.black),
                    _buildButton('2', textColor:Colors.black),
                    _buildButton('3', textColor:Colors.black),
                    _buildFunctionButton('-', Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0', textColor: Colors.black),
                    _buildFunctionButton('.', Colors.grey.shade800),
                    _buildFunctionButton('=', Colors.orangeAccent),
                    _buildFunctionButton('+', Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: [
                    _buildFunctionButton('C', Colors.grey.shade800),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      );
  }

  Widget _buildButton(String buttonText, {Color textColor = Colors.orangeAccent}) {
    return Expanded(
      child: CircleButton(
        onTap: () => buttonPressed(buttonText),
        text: buttonText,
        textcolor: Colors.white,
        buttonColor: Colors.grey.shade800,
      ),
    );
  }


  Widget _buildFunctionButton(String buttonText, Color color) {
    return Expanded(
      child: CircleButton(
          onTap: () => buttonPressed(buttonText),
          text:  buttonText,
          textcolor: Colors.white,
          buttonColor: color,
        ),
      );
  }



  double eval(String expression) {
    try {
      return Function.apply((expression) => expression.toString(),
          [expression],
      ).toDouble(); double.parse(expression);
    } catch (e) {
      return 0;
    }
  }

}

class CircleButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color textcolor;
  final Color buttonColor;
  const CircleButton({super.key, required this.text,
    required this.onTap,  this.textcolor = Colors.white,
    required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: buttonColor,
          shape: BoxShape.circle,
        ),
        child: Text(text,
        style: TextStyle(fontSize: 24,color: textcolor),),
      ),
    );
  }
}
