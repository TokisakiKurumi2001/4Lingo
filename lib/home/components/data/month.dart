import 'package:flutter/material.dart';
import 'package:ForLingo/home/components/data/DrawChart.dart';
import 'package:ForLingo/home/components/bottom_nav_bar/bookmark/words.dart';
import 'package:charts_flutter/flutter.dart' as  dothi;
class MonthData extends StatefulWidget {
  @override
  _MonthDataState createState() => _MonthDataState();
}

class _MonthDataState extends State<MonthData> {

  @override
  Widget build(BuildContext context) {
    // I create four weeks in order to make a month
    List<Week> dulieutrongtuan = [ Week.fromWeek(10, 15),
    Week.fromWeek(5, 15),
    Week.fromWeek(10, 20),
    Week.fromWeek(15, 23)];
    Month thismonth = Month(dulieutrongtuan);
    final List<ChartData> dulieudothi1=[
      ChartData(numvocabs: dulieutrongtuan[0].numlearnedvocabs,barColor:dothi.ColorUtil.fromDartColor(Colors.indigo) ,specifictime: '1st' ),
      ChartData(numvocabs: dulieutrongtuan[1].numlearnedvocabs,barColor:dothi.ColorUtil.fromDartColor(Colors.indigo) ,specifictime: '2nd' ),
      ChartData(numvocabs: dulieutrongtuan[2].numlearnedvocabs,barColor:dothi.ColorUtil.fromDartColor(Colors.indigo) ,specifictime: '3rd' ),
      ChartData(numvocabs: dulieutrongtuan[3].numlearnedvocabs,barColor:dothi.ColorUtil.fromDartColor(Colors.indigo) ,specifictime: '4th' ),
    ];
    final List<ChartData> dulieudothi2=[
      ChartData(numvocabs: dulieutrongtuan[0].totalvocabs,barColor:dothi.ColorUtil.fromDartColor(Colors.green[300]) ,specifictime: '1st' ),
      ChartData(numvocabs: dulieutrongtuan[1].totalvocabs,barColor:dothi.ColorUtil.fromDartColor(Colors.green[300]) ,specifictime: '2nd' ),
      ChartData(numvocabs: dulieutrongtuan[2].totalvocabs,barColor:dothi.ColorUtil.fromDartColor(Colors.green[300]) ,specifictime: '3rd' ),
      ChartData(numvocabs: dulieutrongtuan[3].totalvocabs,barColor:dothi.ColorUtil.fromDartColor(Colors.green[300]) ,specifictime: '4th' ),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[400],
          title: Text('Month',
            style: TextStyle(
              fontFamily: 'IndieFlower',
              letterSpacing: 2.0,
              fontSize: 25.0,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 8.0,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green,
                          blurRadius: 12,
                          offset: Offset(0,5)
                      )
                    ],
                    gradient:
                    LinearGradient(
                        colors: [Colors.lightGreenAccent,Colors.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/pushpin.png',height: 80,width: 100,),
                      SizedBox(width: 14.0,),
                      Column(
                        children: <Widget>[
                          Text('Number of vocabs '
                            ,
                            style: TextStyle(
                                fontFamily: 'IndieFlower',
                                fontSize: 27
                            ),
                          ),
                          Text('you wish to learn'
                            ,
                            style: TextStyle(
                                fontFamily: 'IndieFlower',
                                fontSize: 27
                            ),
                          ),
                          Text('${thismonth.monthtotalvocab }',
                            style: TextStyle(
                                fontFamily: 'PoorStory',
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.0,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.indigo[300],
                          blurRadius: 12,
                          offset: Offset(0,5)
                      )
                    ],
                    gradient: LinearGradient(
                        colors: [Colors.indigoAccent,Colors.indigo],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/objective.png',height: 80,width: 100,),
                      SizedBox(width: 14.0,),
                      Column(
                        children: [
                          Text('Number of vocabs '
                            ,
                            style: TextStyle(
                                fontFamily: 'IndieFlower',
                                fontSize: 27
                            ),
                          ),
                          Text('you have remembered'
                            ,
                            style: TextStyle(
                                fontFamily: 'IndieFlower',
                                fontSize: 27
                            ),
                          ),
                          Text('${thismonth.monthtotallearned }',
                            style: TextStyle(
                                fontFamily: 'PoorStory',
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              DataChart(dulieu1: dulieudothi1,dulieu2: dulieudothi2,name: 'Vocabs you have learned',),

            ],
          ),
        ),
      ),
    );
  }
}
