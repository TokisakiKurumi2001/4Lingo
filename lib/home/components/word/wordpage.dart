import 'package:flutter/material.dart';
import 'wordcard.dart';
import '../../../vocab.dart';
import '../../../global.dart' as globals;
import 'Editor.dart';

class Word extends StatefulWidget {
  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: showingList(),
    );
  }

  Widget showingList() {
    if ((globals.words).length == 0)
      return Center(
        child: Text(
          "You have no word. Press the button to add new words.",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    else {
      List<Vocab> displayList = List.from(globals.words);
      displayList.sort((Vocab a, Vocab b) => ((a.word).compareTo(b.word)));
      for (int i = 0; i < displayList.length; i++) {
        print(displayList[i].word);
      }
      return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: displayList
              .map((w) => WordCard(
                    w: w,
                    delete: () {
                      setState(() {
                        globals.delete(w);
                      });
                    },
                    movetoeditor: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Editor(w)));
                    },
                  ))
              .toList());
    }
  }
}
