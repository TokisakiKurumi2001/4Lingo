import 'package:flutter/material.dart';
import 'wordcard.dart';
import 'package:ForLingo/models/vocab.dart';
import 'Editor.dart';
import 'package:ForLingo/models/vocabs_interface.dart' as vs;

class Word extends StatefulWidget {
  final Function sethomestate;
  Word({this.sethomestate});
  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //child: showingList(),
        child: FutureBuilder<List<Vocab>>(
            future: vs.future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text(
                      "You have no word. Press the button to add new words.",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }
                return Column(
                    children: snapshot.data
                        .map((w) => WordCard(
                              w: w,
                              delete: () {
                                vs.deleteVocabModel(w);
                                widget.sethomestate();
                              },
                              movetoeditor: () {
                                FocusManager.instance.primaryFocus.unfocus();
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Editor(w)))
                                    .then((value) => setState(() {
                                          //vs.future = DBInteract.getAllVocabs();
                                          widget.sethomestate();
                                          vs.handleSearch = true;
                                        }));
                              },
                            ))
                        .toList());
              }
              return Center(
                child: Text('loading...'),
              );
            }));
  }
}
