import 'package:flutter/material.dart';
import 'wordcard.dart';
import 'package:ForLingo/vocab.dart';
import 'package:ForLingo/global.dart' as globals;
import 'add.dart';
import 'Editor.dart';
class Word extends StatefulWidget {
  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('Your vocabulary'),
        centerTitle: true,
      ),
      body: ShowingList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Adding()
            )
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  Widget ShowingList()
  {
    if((globals.words).length == 0)
      return Center(
        child: Text(
          "You have no word. Press the button to add new words.",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    else {
      List<Vocab> DisplayList = List.from(globals.words);
      DisplayList.sort((Vocab a, Vocab b) => ((a.word).compareTo(b.word)));
      for(int i=0; i<DisplayList.length;i++) {
        print(DisplayList[i].word);
      }
      return ListView(
          children: DisplayList.map((w) => WordCard(
            w:w,
            delete:(){
              setState(() {
                globals.delete(w);
              });
            },
            movetoeditor: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Editor(w)
                  )
              );
            },
          )).toList()
      );
    }
  }
}