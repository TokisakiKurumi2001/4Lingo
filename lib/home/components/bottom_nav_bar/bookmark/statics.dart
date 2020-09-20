import 'package:ForLingo/home/components/data/month.dart';
import 'package:ForLingo/home/components/data/week.dart';
import 'package:ForLingo/home/components/data/year.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('Statistics'),
            backgroundColor: Colors.blue[300],
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Week',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'QuickSand',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Tab(
                  child: Text(
                    'Month',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'QuickSand',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Tab(
                  child: Text(
                    'Year',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'QuickSand',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [WeekData(), MonthData(), YearData()],
          )),
    );
  }
}
