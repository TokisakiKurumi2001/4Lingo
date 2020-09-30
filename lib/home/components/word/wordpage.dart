import 'package:ForLingo/db/interact_with_db.dart';
import 'package:ForLingo/models/vocab.dart';
import 'package:flutter/material.dart';
import 'wordcard.dart';
import 'Editor.dart';

class Word extends StatefulWidget {
  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> {
  // Future<Widget> _calculation = Future<Widget>.delayed(
  //   Duration(seconds: 1),
  //   () => showingList(),
  // );
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<Widget>(
      future: showingList(),
      builder: null,
    ));
  }

  Future<Widget> showingList() async {
    int length = await DBInteract.vocabsCount();
    if (length == null)
      return Center(
        child: Text(
          "You have no word. Press the button to add new words.",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    else {
      //List<Vocab> displayList = List.from(globals.words);
      List<Vocab> displayList = await DBInteract.getAllVocabs();
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
                        //globals.delete(w);
                        DBInteract.deleteVocab(w);
                      });
                    },
                    movetoeditor: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Editor(w)))
                          .then((value) => setState(() {}));
                    },
                  ))
              .toList());
    }
  }
}
