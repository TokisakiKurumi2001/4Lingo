import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ForLingo/home/components/bottom_nav_bar/bookmark/words.dart';
import 'package:charts_flutter/flutter.dart' as dothi;
import 'package:ForLingo/home/components/data/DrawChart.dart';
import 'package:ForLingo/db/statistic_database_helper.dart';
import 'package:ForLingo/models/stat.dart';

class WeekData extends StatefulWidget {
  @override
  _WeekDataState createState() => _WeekDataState();
}

class _WeekDataState extends State<WeekData> {
  Future<List<Stat>> myWeekData;
  @override
  void initState() {
    super.initState();
    myWeekData = StatDBInteract.getStatistics(0);
    return;
  }

  Widget build(BuildContext context) {
    double _textWidth = MediaQuery.of(context).size.width;
    return Container(
        child: FutureBuilder<List<Stat>>(
            future: myWeekData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Week myfirstweek = Week(snapshot.data);
                final List<ChartData> dulieudothi1 = [
                  ChartData(
                      specifictime: 'Mo',
                      numvocabs: snapshot.data[0].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.red[400])),
                  ChartData(
                      specifictime: 'Tu',
                      numvocabs: snapshot.data[1].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.red[400])),
                  ChartData(
                      specifictime: 'We',
                      numvocabs: snapshot.data[2].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.red[400])),
                  ChartData(
                      specifictime: 'Th',
                      numvocabs: snapshot.data[3].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.red[400])),
                  ChartData(
                      specifictime: 'Fr',
                      numvocabs: snapshot.data[4].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.red[400])),
                  ChartData(
                      specifictime: 'Sa',
                      numvocabs: snapshot.data[5].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.red[400])),
                  ChartData(
                      specifictime: 'Su',
                      numvocabs: snapshot.data[6].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.red[400])),
                ];
                final List<ChartData> dulieudothi2 = [
                  ChartData(
                      specifictime: 'Mo',
                      numvocabs: snapshot.data[0].remember,
                      barColor:
                          dothi.ColorUtil.fromDartColor(Colors.blue[400])),
                  ChartData(
                      specifictime: 'Tu',
                      numvocabs: snapshot.data[1].remember,
                      barColor:
                          dothi.ColorUtil.fromDartColor(Colors.blue[400])),
                  ChartData(
                      specifictime: 'We',
                      numvocabs: snapshot.data[2].remember,
                      barColor:
                          dothi.ColorUtil.fromDartColor(Colors.blue[400])),
                  ChartData(
                      specifictime: 'Th',
                      numvocabs: snapshot.data[3].remember,
                      barColor:
                          dothi.ColorUtil.fromDartColor(Colors.blue[400])),
                  ChartData(
                      specifictime: 'Fr',
                      numvocabs: snapshot.data[4].remember,
                      barColor:
                          dothi.ColorUtil.fromDartColor(Colors.blue[400])),
                  ChartData(
                      specifictime: 'Sa',
                      numvocabs: snapshot.data[5].remember,
                      barColor:
                          dothi.ColorUtil.fromDartColor(Colors.blue[400])),
                  ChartData(
                      specifictime: 'Su',
                      numvocabs: snapshot.data[6].remember,
                      barColor:
                          dothi.ColorUtil.fromDartColor(Colors.blue[400])),
                ];
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8),
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.red,
                                    blurRadius: 12,
                                    offset: Offset(0, 5))
                              ],
                              gradient: LinearGradient(
                                  colors: [Colors.pinkAccent, Colors.red],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomLeft),
                            ),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/book.png',
                                  height: 80,
                                  width: 80,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: _textWidth * 0.65,
                                      child: Text(
                                        'Number of vocabs you wish to learn',
                                        style: TextStyle(
                                          fontFamily: 'IndieFlower',
                                          fontSize: 27,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${myfirstweek.totalVocabs}',
                                      style: TextStyle(
                                          fontFamily: 'PoorStory',
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8),
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue,
                                    blurRadius: 12,
                                    offset: Offset(0, 5))
                              ],
                              gradient: LinearGradient(
                                  colors: [Colors.blueAccent[100], Colors.blue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomLeft),
                            ),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/tasks.png',
                                  height: 80,
                                  width: 80,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: _textWidth * 0.65,
                                      child: Text(
                                        'Number of vocabs you have remembered',
                                        style: TextStyle(
                                          fontFamily: 'IndieFlower',
                                          fontSize: 27,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${myfirstweek.numLearnedVocabs}',
                                      style: TextStyle(
                                          fontFamily: 'PoorStory',
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataChart(
                          dulieu1: dulieudothi1,
                          dulieu2: dulieudothi2,
                          name: 'Your activities this week',
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: Text('loading...'));
              }
            }));
  }
}
