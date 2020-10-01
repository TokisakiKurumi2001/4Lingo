import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'bookmark/bookmark.dart';
import 'bookmark/statics.dart';

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
            onPressed: () {
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
