import 'package:ForLingo/home/components/data/DrawChart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as dothi;
import 'package:ForLingo/home/components/bottom_nav_bar/bookmark/words.dart';
import 'package:ForLingo/db/statistic_database_helper.dart';
import 'package:ForLingo/models/stat.dart';
class YearData extends StatefulWidget {
  @override
  _YearDataState createState() => _YearDataState();
}

class _YearDataState extends State<YearData> {
  Future<List<Stat>> myYearData;
  @override
  void initState() {
    super.initState();
    myYearData = StatDBInteract.getStatistics(2);
    return;
  }
  Widget build(BuildContext context) {
    double _textWidth = MediaQuery.of(context).size.width;
    // I create my own data for demonstration only
//    List<Month> dulieu = [
//      Month.fromMonth(70, 52),
//      Month.fromMonth(50, 27),
//      Month.fromMonth(82, 69),
//      Month.fromMonth(59, 42),
//      Month.fromMonth(54, 46),
//      Month.fromMonth(56, 35),
//      Month.fromMonth(62, 49),
//      Month.fromMonth(75, 52),
//      Month.fromMonth(85, 58),
//      Month.fromMonth(76, 63),
//      Month.fromMonth(52, 49),
//      Month.fromMonth(74, 63),
//    ];
    return Container(
      child: FutureBuilder(
        future: myYearData,
        builder: (context,snapshot)
          {
            if(snapshot.hasData) {
              Year thisYear = Year(snapshot.data);
              final List<ChartData> dulieudothi1 = [
                  ChartData(
                      numvocabs: snapshot.data[0].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'Jan'),
                  ChartData(
                      numvocabs: snapshot.data[1].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'Feb'),
                  ChartData(
                      numvocabs: snapshot.data[2].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'Mar'),
                  ChartData(
                      numvocabs: snapshot.data[3].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'Apr'),
                  ChartData(
                      numvocabs: snapshot.data[4].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'May'),
                  ChartData(
                      numvocabs: snapshot.data[5].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'Jun'),
                  ChartData(
                      numvocabs: snapshot.data[6].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'Jul'),
                  ChartData(
                      numvocabs: snapshot.data[7].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'Aug'),
                  ChartData(
                      numvocabs: snapshot.data[8].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'Sep'),
                  ChartData(
                      numvocabs: snapshot.data[9].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'Oct'),
                  ChartData(
                      numvocabs: snapshot.data[10].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'Nov'),
                  ChartData(
                      numvocabs: snapshot.data[11].remember,
                      barColor: dothi.ColorUtil.fromDartColor(
                          Colors.pinkAccent),
                      specifictime: 'Dec'),
                ];
                final List<ChartData> dulieudothi2 = [
                  ChartData(
                      numvocabs: snapshot.data[0].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'Jan'),
                  ChartData(
                      numvocabs: snapshot.data[1].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'Feb'),
                  ChartData(
                      numvocabs: snapshot.data[2].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'Mar'),
                  ChartData(
                      numvocabs: snapshot.data[3].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'Apr'),
                  ChartData(
                      numvocabs: snapshot.data[4].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'May'),
                  ChartData(
                      numvocabs: snapshot.data[5].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'Jun'),
                  ChartData(
                      numvocabs: snapshot.data[6].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'Jul'),
                  ChartData(
                      numvocabs: snapshot.data[7].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'Aug'),
                  ChartData(
                      numvocabs: snapshot.data[8].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'Sep'),
                  ChartData(
                      numvocabs: snapshot.data[9].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'Oct'),
                  ChartData(
                      numvocabs: snapshot.data[10].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'Nov'),
                  ChartData(
                      numvocabs: snapshot.data[11].vocabs,
                      barColor: dothi.ColorUtil.fromDartColor(Colors.amber),
                      specifictime: 'Dec'),
                ];
                return SafeArea(
                  child: Scaffold(
                    body: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(24.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.amber,
                                      blurRadius: 12,
                                      offset: Offset(0, 5))
                                ],
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.amberAccent[100],
                                      Colors.amber
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomLeft),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/pen.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                  SizedBox(
                                    width: 14.0,
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
                                        '${thisYear.yearTotalVocab}',
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
                            padding:
                            const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 8),
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(24.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.pink,
                                      blurRadius: 12,
                                      offset: Offset(0, 5))
                                ],
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.pinkAccent[100],
                                      Colors.pink
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomLeft),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/statistics.png',
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
                                        '${thisYear.yearTotalLearn}',
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
                            name: 'Yours vocabs this year',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              else {
                return Center();
              }
            }
      ),
    );

  }
}
