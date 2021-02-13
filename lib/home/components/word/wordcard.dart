import 'package:flutter/material.dart';
import 'package:ForLingo/models/vocab.dart';

class WordCard extends StatelessWidget {
  final Vocab w;
  final Function delete;
  final Function movetoeditor;
  WordCard({this.w, this.delete, this.movetoeditor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: movetoeditor,
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 10, 15, 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                w.word,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: Colors.black87,
                ),
              ),
              Spacer(),
              FlatButton.icon(
                onPressed: () {
                  // ignore: non_constant_identifier_names
                  Widget YesButton = FlatButton(
                    child: Text(
                      'Yes',
                      style: TextStyle(color: Colors.red.shade600),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      delete();
                    },
                  );
                  // ignore: non_constant_identifier_names
                  Widget NoButton = FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Delete words"),
                          content: Text(
                              "Are you sure you want to delete '${w.word}' ?"),
                          actions: <Widget>[YesButton, NoButton],
                        );
                      });
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade600,
                ),
                label: Text(''),
              ),
              FlatButton.icon(
                onPressed: movetoeditor,
                icon: Icon(Icons.navigate_next),
                label: Text(''),
              )
            ],
          ),
        ),
      ),
    );
  }
}
