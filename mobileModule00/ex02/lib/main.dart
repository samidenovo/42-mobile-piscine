import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              buildDisplay('0'),
              buildDisplay('0'),
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
            debugPrint(value);
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
}//class