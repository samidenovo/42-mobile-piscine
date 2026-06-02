import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}//MyApp

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController  _tabController;
  late TextEditingController  _textController;
  String displayText = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget  build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search location...',
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                setState(() {
                  displayText = value;
                });
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    displayText = _textController.text;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.my_location),
                onPressed: () {
                  setState(() {
                    displayText = 'Geolocation';
                  });
                }
              ),
            ],
          ),//appBar
          body: TabBarView(
            controller: _tabController,
            children: [
              Center(
                child: Text('Currently\n$displayText',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30)
                )
              ),
              Center(
                child: Text('Today\n$displayText',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30)
                )
              ),
              Center(
                child: Text('Weekly\n$displayText',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30)
                )
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  icon: Icon(Icons.wb_sunny),
                  text: 'Currently'
                ),
                Tab(
                  icon: Icon(Icons.today),
                  text: 'Today',
                ),
                Tab(
                  icon: Icon(Icons.calendar_view_week),
                  text: 'Weekly',
                ),
              ],
            ),
          ),
        ),
      );//MaterialApp
  }//build
}//_MyAppState
