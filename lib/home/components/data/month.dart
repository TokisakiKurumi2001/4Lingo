import 'package:flutter/material.dart';
import 'package:ForLingo/home/components/data/DrawChart.dart';
import 'package:ForLingo/home/components/bottom_nav_bar/bookmark/words.dart';
import 'package:charts_flutter/flutter.dart' as dothi;
import 'package:ForLingo/db/statistic_database_helper.dart';
import 'package:ForLingo/models/stat.dart';
class MonthData extends StatefulWidget {
  @override
  _MonthDataState createState() => _MonthDataState();
}

class _MonthDataState extends State<MonthData> {
  Future<List<Stat>> myMonthData;
  @override
  void initState ()
  {
    super.initState();
    myMonthData = StatDBInteract.getStatistics(1);
    return;
  }
  Widget build(BuildContext context)   {
    double _textWidth = MediaQuery.of(context).size.width;
    // I create four weeks in order to make a month
//    List<Week> dulieutrongtuan = [
//      Week.fromWeek(10, 15),
//      Week.fromWeek(5, 15),
//      Week.fromWeek(10, 20),
//      Week.fromWeek(15, 23)
//    ]

    return Container(
      child: FutureBuilder <List<Stat>>(
        future: myMonthData,
        builder: (context,snapshot){
          if(snapshot.hasData)
            {
              Month thisMonth = Month(snapshot.data);
              final List<ChartData> dulieudothi1 = [
                ChartData(
                    numvocabs: snapshot.data[0].remember,
                    barColor: dothi.ColorUtil.fromDartColor(Colors.indigo),
                    specifictime: '1st'),
                ChartData(
                    numvocabs: snapshot.data[1].remember,
                    barColor: dothi.ColorUtil.fromDartColor(Colors.indigo),
                    specifictime: '2nd'),
                ChartData(
                    numvocabs: snapshot.data[2].remember,
                    barColor: dothi.ColorUtil.fromDartColor(Colors.indigo),
                    specifictime: '3rd'),
                ChartData(
                    numvocabs: snapshot.data[3].remember,
                    barColor: dothi.ColorUtil.fromDartColor(Colors.indigo),
                    specifictime: '4th'),
                ChartData(
                    numvocabs: snapshot.data[4].remember,
                    barColor: dothi.ColorUtil.fromDartColor(Colors.indigo),
                    specifictime: '5th'),
              ];
              final List<ChartData> dulieudothi2 = [
                ChartData(
                    numvocabs: snapshot.data[0].vocabs,
                    barColor: dothi.ColorUtil.fromDartColor(Colors.green[300]),
                    specifictime: '1st'),
                ChartData(
                    numvocabs: snapshot.data[1].vocabs,
                    barColor: dothi.ColorUtil.fromDartColor(Colors.green[300]),
                    specifictime: '2nd'),
                ChartData(
                    numvocabs: snapshot.data[2].vocabs,
                    barColor: dothi.ColorUtil.fromDartColor(Colors.green[300]),
                    specifictime: '3rd'),
                ChartData(
                    numvocabs: snapshot.data[3].vocabs,
                    barColor: dothi.ColorUtil.fromDartColor(Colors.green[300]),
                    specifictime: '4th'),
                ChartData(
                    numvocabs: snapshot.data[4].vocabs,
                    barColor: dothi.ColorUtil.fromDartColor(Colors.green[300]),
                    specifictime: '5th'),
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
                          padding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.green,
                                    blurRadius: 12,
                                    offset: Offset(0, 5))
                              ],
                              gradient: LinearGradient(
                                  colors: [Colors.lightGreenAccent, Colors.green],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomLeft),
                            ),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/pushpin.png',
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
                                      '${thisMonth.monthTotalVocab}',
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
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.indigo[300],
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.indigo[300],
                                    blurRadius: 12,
                                    offset: Offset(0, 5))
                              ],
                              gradient: LinearGradient(
                                  colors: [Colors.indigoAccent, Colors.indigo],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomLeft),
                            ),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/objective.png',
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
                                      '${thisMonth.monthTotalLearned}',
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
                          name: 'Yours vocabs this month',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          else
            {
              return Center();
            }
        }
      ),
    );



  }
}
