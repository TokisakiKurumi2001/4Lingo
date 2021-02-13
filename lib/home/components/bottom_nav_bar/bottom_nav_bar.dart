
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'bookmark/bookmark.dart';
import 'bookmark/statics.dart';
import 'package:ForLingo/vocabs_interface.dart' as vs;
import 'package:ForLingo/db/statistic_database_helper.dart';
import 'package:ForLingo/db/interact_with_db.dart';
class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 40.0,
        right: 40.0,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: Colors.blue.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesome5.bookmark,
              color: Colors.blue,
            ),
            onPressed: () {
              vs.future = DBInteract.getAllVocabs();
              //Bookmark popup
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FlashCardFuture(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              FontAwesome5.chart_line,
              color: Colors.blue,
            ),
            onPressed: () async {
              await StatDBInteract.updateStat();
              int val = 0;
              //calculate total num of words to be displayed today and store it to int val
              /*
                   something goes here
              */
              updateDataBase(val);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Thongke(),
                ),
              );
              //Statistic popup
            },
          ),
        ],
      ),
    );
  }
}

Future<void> updateDataBase(int value) async
{
  DateTime currentTime = DateTime.now();
  int week;
  int day = currentTime.day;
  if (day <= 7)
    week = 1;
  else if (day <= 14)
    week = 2;
  else if (day <= 21)
    week = 3;
  else if (day <= 28)
    week = 4;
  else
    week = 5;
  await StatDBInteract.upDateTotalVocab(0, currentTime.weekday,value);
  await StatDBInteract.upDateTotalVocab(1, week,value);
  await StatDBInteract.upDateTotalVocab(2, currentTime.month,value);
  await StatDBInteract.upDateTotalVocab(3, 1,value);
  return;
}


