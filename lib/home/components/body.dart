import 'package:flutter/material.dart';
import 'header_with_searchbox.dart';
import 'word/wordpage.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          /*Center(
            child: Text(
              'data',
              style: TextStyle(fontSize: 40),
            ),
          ),*/
          Word(),
        ],
      ),
    );
  }
}
