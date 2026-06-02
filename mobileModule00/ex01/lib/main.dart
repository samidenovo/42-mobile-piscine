import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String text = 'A simple text';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.blue[700],
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    ),
                  ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    if (text == 'A simple text'){
                      text = 'Hello World!';
                    }
                    else{
                      text = 'A simple text';
                    }
                  });
                },
                child: const Text('Press me'),
              ),
            ],
          ),
        ),
      ),
    );
  }//build
}//class