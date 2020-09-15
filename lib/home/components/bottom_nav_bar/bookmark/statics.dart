import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'words.dart';

class MyVocab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Thongke();
  }
}

class Thongke extends StatefulWidget {
  @override
  _ThongkeState createState() => _ThongkeState();
}

class _ThongkeState extends State<Thongke> {
  List<Day> dulieu = [
    Day(learned: 5, vocabs: 10),
    Day(learned: 1, vocabs: 5),
    Day(learned: 2, vocabs: 13),
    Day(learned: 9, vocabs: 10),
    Day(learned: 9, vocabs: 10),
    Day(learned: 5, vocabs: 15),
    Day(learned: 7, vocabs: 20),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text(
          'My data',
          style: TextStyle(
            fontFamily: 'QuickSand',
            letterSpacing: 1.0,
              fontSize: 25.0
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/cloud.png'), fit: BoxFit.cover)),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.looks_one),
                    title: Text(
                      'Week',
                      style: TextStyle(
                        fontFamily: 'QuickSand',
                        letterSpacing: 1.0,
                        fontSize: 20.0,
                      ),
                    ),
                    subtitle: Text(
                      'Your vocabs this week',
                      style: TextStyle(
                        fontFamily: 'IndieFlower',
                        letterSpacing: 1.0,
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/week', arguments: {
                        'date0' : dulieu[0], 'date1':dulieu[1],'date2':dulieu[2],
                        'date3':dulieu[3],'date4':dulieu[4],'date5':dulieu[5],'date6':dulieu[6]
                      });
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.looks_two),
                    title: Text(
                      'Month',
                      style: TextStyle(
                        fontFamily: 'QuickSand',
                        letterSpacing: 1.0,
                        fontSize: 20.0,
                      ),
                    ),
                    subtitle: Text(
                      'Your vocabs this month',
                      style: TextStyle(
                        fontFamily: 'IndieFlower',
                        letterSpacing: 1.0,
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/month',);
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.looks_3),
                    title: Text(
                      'Year',
                      style: TextStyle(
                        fontFamily: 'QuickSand',
                        letterSpacing: 1.0,
                        fontSize: 20.0,
                      ),
                    ),
                    subtitle: Text(
                      'Your vocabs this year',
                      style: TextStyle(
                        fontFamily: 'IndieFlower',
                        letterSpacing: 1.0,
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/year');
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
