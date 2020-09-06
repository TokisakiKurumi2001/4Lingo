import 'package:flutter/material.dart';
import 'flashcard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyContent(),
    );
  }
}

class MyContent extends StatefulWidget {
  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> {
  List<Widget> tabContent = [
    Text('Add some word'), // Tam + Khang
    FlashCard(),
    Text('Have some word') // Duong
  ];
  int tabIndex = 1;

  void _onTapTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('4Lingo'),
      ),
      body: SafeArea(
        child: tabContent[tabIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            title: Text('Vocab'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Flashcard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Statistics'),
          ),
        ],
        currentIndex: tabIndex,
        onTap: _onTapTab,
      ),
    );
  }
}
