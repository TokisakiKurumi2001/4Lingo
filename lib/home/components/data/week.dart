import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ForLingo/home/components/bottom_nav_bar/bookmark/words.dart';
import 'package:charts_flutter/flutter.dart' as  dothi;
import 'package:ForLingo/home/components/data/DrawChart.dart';
class WeekData extends StatefulWidget {
  @override
  _WeekDataState createState() => _WeekDataState();
}
class _WeekDataState extends State<WeekData> {
  @override
  Widget build(BuildContext context) {
    List <Day> array  = [
      Day(learned: 5, vocabs: 10),
      Day(learned: 1, vocabs: 5),
      Day(learned: 2, vocabs: 13),
      Day(learned: 9, vocabs: 10),
      Day(learned: 9, vocabs: 10),
      Day(learned: 5, vocabs: 15),
      Day(learned: 7, vocabs: 20),
    ];
    final List <ChartData> dulieudothi1 = [
      ChartData(specifictime: 'Mo',numvocabs: array[0].vocabs,barColor: dothi.ColorUtil.fromDartColor(Colors.red[400]) ),
      ChartData(specifictime: 'Tu',numvocabs: array[1].vocabs,barColor: dothi.ColorUtil.fromDartColor(Colors.red[400]) ),
      ChartData(specifictime: 'We',numvocabs: array[2].vocabs,barColor: dothi.ColorUtil.fromDartColor(Colors.red[400]) ),
      ChartData(specifictime: 'Th',numvocabs: array[3].vocabs,barColor: dothi.ColorUtil.fromDartColor(Colors.red[400]) ),
      ChartData(specifictime: 'Fr',numvocabs: array[4].vocabs,barColor: dothi.ColorUtil.fromDartColor(Colors.red[400]) ),
      ChartData(specifictime: 'Sa',numvocabs: array[5].vocabs,barColor: dothi.ColorUtil.fromDartColor(Colors.red[400]) ),
      ChartData(specifictime: 'Su',numvocabs: array[6].vocabs,barColor: dothi.ColorUtil.fromDartColor(Colors.red[400]) ),
    ];
    final List <ChartData> dulieudothi2 = [
      ChartData(specifictime: 'Mo',numvocabs: array[0].learned,barColor: dothi.ColorUtil.fromDartColor(Colors.blue[400]) ),
      ChartData(specifictime: 'Tu',numvocabs: array[1].learned,barColor: dothi.ColorUtil.fromDartColor(Colors.blue[400]) ),
      ChartData(specifictime: 'We',numvocabs: array[2].learned,barColor: dothi.ColorUtil.fromDartColor(Colors.blue[400]) ),
      ChartData(specifictime: 'Th',numvocabs: array[3].learned,barColor: dothi.ColorUtil.fromDartColor(Colors.blue[400]) ),
      ChartData(specifictime: 'Fr',numvocabs: array[4].learned,barColor: dothi.ColorUtil.fromDartColor(Colors.blue[400]) ),
      ChartData(specifictime: 'Sa',numvocabs: array[5].learned,barColor: dothi.ColorUtil.fromDartColor(Colors.blue[400]) ),
      ChartData(specifictime: 'Su',numvocabs: array[6].learned,barColor: dothi.ColorUtil.fromDartColor(Colors.blue[400]) ),
    ];
    Week myfirstweek = Week(array);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 8.0,),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
               child: Container(
                 margin: EdgeInsets.all(5.0),
                 height: 130,
                 decoration: BoxDecoration(
                   color: Colors.redAccent,
                   borderRadius: BorderRadius.circular(24.0),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.red,
                       blurRadius: 12,
                       offset: Offset(0,5)
                     )
                   ],
                   gradient:
                   LinearGradient(
                     colors: [Colors.pinkAccent,Colors.red],
                     begin: Alignment.topLeft,
                     end: Alignment.bottomLeft
                   ),
                 ),
                 child: Row(
                   children: <Widget>[
                     Image.asset('assets/book.png',height: 80,width: 100,),
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
                         Text('${myfirstweek.totalvocabs }',
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
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue,
                          blurRadius: 12,
                          offset: Offset(0,5)
                      )
                    ],
                    gradient: LinearGradient(
                        colors: [Colors.blueAccent[100],Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/tasks.png',height: 80,width: 100,),
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
                          Text('${myfirstweek.numlearnedvocabs }',
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
              DataChart(dulieu1: dulieudothi1,dulieu2: dulieudothi2,name: 'Your activities this week',),

            ]
          ),
        )
        ),
      );
  }
}
