import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String  expression = '0';
  String  result = '0';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade600,
        appBar: AppBar(
          title: const Text(
            'Calulator',
            style: TextStyle(color: Colors.white)
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
      body: 
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildDisplay(expression),
              buildDisplay(result),
              Spacer(),
              Row(
                children: [
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  buildButton('C'),
                  buildButton('AC'),
                ],
              ),
              Row(
                children: [
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('+'),
                  buildButton('-'),
                ],
              ),
              Row(
                children: [
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('*'),
                  buildButton('/'),
                ],
              ),
              Row(
                children: [
                  buildButton('0'),
                  buildButton('.'),
                  buildButton('00'),
                  buildButton('='),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }//build

  Widget buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: (){
            setState(() {
              if (value == 'AC'){
                expression = '0';
                result = '0';
              }
              else if (value == 'C'){
                expression = expression.substring(0, expression.length -1);
                if (expression.isEmpty){
                  expression = '0';
                }                  
              }
              else if (value == '='){
                calculateResult();
              }
              else if (expression != '0' && expression != '00'){
                expression += value;
              }
              else{
                expression = expression.substring(0, expression.length -1);
                expression = value;
              }
            });
          },
          child: Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }//buildButton

  Widget buildDisplay(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
        ),
      ),
    );
  }//buildDisplay

  void  calculateResult() {
    try{
      GrammarParser parser = GrammarParser();//Create the object
      Expression exp = parser.parse(expression);//turn into math expression
      ContextModel cm = ContextModel();//empty, but next ft need this variable
      double rval = exp.evaluate(EvaluationType.REAL, cm); //calculate
      if (rval.isInfinite || rval.isNaN){
        result = 'Error';
        return;
      }
      result = rval.toString();
    } catch (e)
    {
      result = "Error";
    }
  }//calculateResult
}//class