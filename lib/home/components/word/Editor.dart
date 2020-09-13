import 'package:flutter/material.dart';
import '../../../vocab.dart';
import '../../../global.dart' as globals;

class Editor extends StatefulWidget {
  final Vocab w;
  Editor(this.w);
  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  bool isEditing = false;
  final TextEditingController Mycontroller = TextEditingController();
  String Init;
  int index;
  @override
  void initState() {
    super.initState();
    index = globals.finding(widget.w);
    Mycontroller.text = (widget.w).word;
    Init = (widget.w).word;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is the place for editing'),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                    Icons.navigate_before,
                    size: 50,
                    color: Colors.grey[400],
                  )),
                  IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      size: 50,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BackEditor(index)));
                    },
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextorField(),
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton.icon(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      if (isEditing == true)
                        return;
                      else {
                        setState(() {
                          isEditing = true;
                        });
                      }
                    },
                    label: Text('Edit'),
                  ),
                  RaisedButton.icon(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      (globals.words[index]).word = Init;
                      print(Init);
                      setState(() {
                        index = index;
                        isEditing = false;
                        Init = Mycontroller.text;
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Changes saved!'),
                      ));
                    },
                    label: Text('Save'),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  Widget TextorField() {
    if (isEditing) {
      Mycontroller.text = Init;
      isEditing = false;
      return TextField(
        autofocus: true,
        controller: Mycontroller,
      );
    } else {
      return Text(
        Init,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 50,
        ),
      );
    }
  }
}

class BackEditor extends StatefulWidget {
  final int index;
  BackEditor(this.index);
  @override
  _BackEditorState createState() => _BackEditorState();
}

class _BackEditorState extends State<BackEditor> {
  bool isEditing;
  TextEditingController meaningcontroller = TextEditingController();
  TextEditingController sentencecontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    isEditing = false;
    meaningcontroller.text = (globals.words[widget.index]).meaning;
    sentencecontroller.text = (globals.words[widget.index]).sentence;
  }

  @override
  void dispose() {
    super.dispose();
    meaningcontroller.dispose();
    sentencecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Builder(
        builder: (BuildContext context) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.navigate_before,
                      size: 50,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      size: 50,
                      color: Colors.grey[400],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Meaning',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              TextorField(2),
              SizedBox(
                height: 40,
              ),
              Text(
                'Sentence',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextorField(3),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton.icon(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      if (isEditing == false) {
                        setState(() {
                          isEditing = true;
                        });
                      }
                    },
                    label: Text('Edit'),
                  ),
                  RaisedButton.icon(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      (globals.words)[widget.index].meaning =
                          meaningcontroller.text;
                      (globals.words)[widget.index].sentence =
                          sentencecontroller.text;
                      setState(() {
                        isEditing = false;
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Changes saved!'),
                      ));
                    },
                    label: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TextorField(int val) {
    if (isEditing) {
      return Container(
          height: 50,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            autofocus: true,
            controller: (val == 2) ? (meaningcontroller) : (sentencecontroller),
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ));
    } else {
      return Text(
        (val == 2) ? (meaningcontroller.text) : (sentencecontroller.text),
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 15,
        ),
      );
    }
  }
}
