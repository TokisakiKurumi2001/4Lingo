import 'package:ForLingo/db/interact_with_db.dart';
import 'package:ForLingo/models/vocab.dart';
import 'package:flutter/material.dart';
//import '../../../global.dart' as globals; // It seem likes we do not need this anymore

class Adding extends StatefulWidget {
  @override
  _AddingState createState() => _AddingState();
}

class _AddingState extends State<Adding> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    '     Add your word here:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                    child: TextFormField(
                      style: TextStyle(fontWeight: FontWeight.w600),
                      validator: (value)
                      {
                        if (value.isEmpty)
                             {
                               return 'This field is required';
                             }
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        fillColor: Colors.blue[400],
                        hintText: 'Type your word here',
                      ),
                      autofocus: true,
                      controller: controller1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '     Meaning of the word: (optional)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                    child: TextField(
                      style: TextStyle(fontWeight: FontWeight.w600),
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        fillColor: Colors.blue[400],
                        hintText: 'Type your description here',
                      ),
                      autofocus: true,
                      controller: controller2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '    Sentence containing that word:(optional)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                    child: TextField(
                      style: TextStyle(fontWeight: FontWeight.w600),
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        fillColor: Colors.blue[400],
                        hintText: 'Type your sentence here',
                      ),
                      autofocus: true,
                      controller: controller3,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: RaisedButton.icon(
                            icon: Icon(Icons.save),
                            label: Text('Save result'),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) { // I have to edit here
                                Vocab nw = Vocab(
                                    word: controller1.text,
                                    meaning: controller2.text,
                                    sentence: controller3.text,
                                    id: await DBInteract.vocabsCount(),
                                  date_created: DateTime.now().toString(),
                                  data_updated: DateTime.now().toString()
                                );
                                //globals.adding(nw);
                                DBInteract.addNewVocab(nw);
                                print('New word added!');
                                setState(() {
                                  controller1.clear();
                                  controller2.clear();
                                  controller3.clear();
                                });
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('New word added'),
                                ));
                              }
                              //end else
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        child: Center(
                          child: RaisedButton.icon(
                            icon: Icon(Icons.exit_to_app),
                            label: Text('Exit'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
