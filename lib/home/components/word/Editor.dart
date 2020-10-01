import 'package:ForLingo/db/interact_with_db.dart';
import 'package:flutter/material.dart';
import 'package:ForLingo/models/vocab.dart';
import '../../../global.dart' as globals;
import 'package:ForLingo/vocabs_interface.dart';

class FrontEditor extends StatefulWidget {
  final Vocab w;
  FrontEditor(this.w);
  @override
  _FrontEditorState createState() => _FrontEditorState();
}

class _FrontEditorState extends State<FrontEditor> {
  bool isEditing = false;
  final TextEditingController Mycontroller = TextEditingController();
  String Init;
  @override
  void initState() {
    super.initState();
    //index = globals.finding(widget.w);
    Mycontroller.text = widget.w.word;
    Init = widget.w.word;
  }

  @override
  Widget TextorField() {
    if (isEditing) {
      Mycontroller.text = Init;
      isEditing = false;
      return TextFormField(
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

  Widget build(BuildContext context)  {

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
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
                  //(globals.words[index]).word = Mycontroller.text;
                  widget.w.word = Mycontroller.text;
                  updateTodo(widget.w);
                  //print(Init);
                  setState(()  {
                    //index = index;
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
  }
}

class BackEditor extends StatefulWidget {
  final Vocab w;
  BackEditor(this.w);
  @override
  _BackEditorState createState() => _BackEditorState();
}

class _BackEditorState extends State<BackEditor> {
  bool isEditing;
  TextEditingController meaningcontroller = TextEditingController();
  TextEditingController sentencecontroller = TextEditingController();
  //Vocab w;
  @override
  void initState() {
    print('Init state of back editor ${widget.w.meaning}--${widget.w.sentence}');
    super.initState();
    isEditing = false;
    //w = await DBInteract.getVocab(widget.index);
    meaningcontroller.text = widget.w.meaning;
    sentencecontroller.text = widget.w.sentence;
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
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      body: Builder(
        builder: (BuildContext context) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                      //(globals.words)[widget.index].meaning =
                      //    meaningcontroller.text;
                      //(globals.words)[widget.index].sentence =
                      //    sentencecontroller.text;
                      widget.w.meaning = meaningcontroller.text;
                      widget.w.sentence = sentencecontroller.text;
                      updateTodo(widget.w);
                      setState(()  {
                        //w = await DBInteract.getVocab(widget.index);
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

class Editor extends StatefulWidget {
  final Vocab w;
  Editor(this.w);

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {


  @override
  Widget build(BuildContext context) {
    print('Back to Editor');
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Front',
                ),
                Tab(
                  text: 'Back',
                ),
              ],
            ),
            title: Text('Edit Card'),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              FrontEditor(widget.w),
              BackEditor(widget.w),
            ],
          ),
        ),
      ),
    );
  }
}
