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
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.blue[700],
                child: const Text(
                  'A simple text',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    ),
                  ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: (){
                  debugPrint('Button pressed');
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