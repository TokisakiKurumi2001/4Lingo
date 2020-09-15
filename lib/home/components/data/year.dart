import 'package:flutter/material.dart';
import 'package:ForLingo/home/components/bottom_nav_bar/bookmark/words.dart';
class YearData extends StatefulWidget {
  @override
  _YearDataState createState() => _YearDataState();
}

class _YearDataState extends State<YearData> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[400],
          title: Text('Year',
            style: TextStyle(
              fontFamily: 'IndieFlower',
              letterSpacing: 2.0,
              fontSize: 25.0,
            ),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
