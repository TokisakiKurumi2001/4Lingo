import 'package:ForLingo/home/components/data/DrawChart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as  dothi;
import 'package:ForLingo/home/components/bottom_nav_bar/bookmark/words.dart';
class YearData extends StatefulWidget {
  @override
  _YearDataState createState() => _YearDataState();
}

class _YearDataState extends State<YearData> {

  @override
  Widget build(BuildContext context) {
    // I create my own data for demonstration only
    List<Month> dulieu = [
      Month.fromMonth(70, 52),Month.fromMonth(50, 27),Month.fromMonth(82, 69),Month.fromMonth(59, 42),
      Month.fromMonth(54, 46),Month.fromMonth(56, 35),Month.fromMonth(62,49),Month.fromMonth(75, 52),
      Month.fromMonth(85, 58),Month.fromMonth(76, 63),Month.fromMonth(52, 49),Month.fromMonth(74, 63),
    ];
    Year thisyear = Year(dulieu);
    final List<ChartData> dulieudothi1 = [
      ChartData(numvocabs: dulieu[0].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'Jan' ),
      ChartData(numvocabs: dulieu[1].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'Feb' ),
      ChartData(numvocabs: dulieu[2].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'Mar' ),
      ChartData(numvocabs: dulieu[3].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'Apr' ),
      ChartData(numvocabs: dulieu[4].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'May' ),
      ChartData(numvocabs: dulieu[5].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'Jun' ),
      ChartData(numvocabs: dulieu[6].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'Jul' ),
      ChartData(numvocabs: dulieu[7].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'Aug' ),
      ChartData(numvocabs: dulieu[8].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'Sep' ),
      ChartData(numvocabs: dulieu[9].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'Oct' ),
      ChartData(numvocabs: dulieu[10].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'Nov' ),
      ChartData(numvocabs: dulieu[11].monthtotallearned,barColor:dothi.ColorUtil.fromDartColor(Colors.pinkAccent) ,specifictime: 'Dec' ),
    ];
    final List<ChartData> dulieudothi2 = [
      ChartData(numvocabs: dulieu[0].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'Jan' ),
      ChartData(numvocabs: dulieu[1].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'Feb' ),
      ChartData(numvocabs: dulieu[2].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'Mar' ),
      ChartData(numvocabs: dulieu[3].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'Apr' ),
      ChartData(numvocabs: dulieu[4].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'May' ),
      ChartData(numvocabs: dulieu[5].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'Jun' ),
      ChartData(numvocabs: dulieu[6].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'Jul' ),
      ChartData(numvocabs: dulieu[7].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'Aug' ),
      ChartData(numvocabs: dulieu[8].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'Sep' ),
      ChartData(numvocabs: dulieu[9].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'Oct' ),
      ChartData(numvocabs: dulieu[10].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'Nov' ),
      ChartData(numvocabs: dulieu[11].monthtotalvocab,barColor:dothi.ColorUtil.fromDartColor(Colors.amber) ,specifictime: 'Dec' ),
    ];
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
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.amber,
                          blurRadius: 12,
                          offset: Offset(0,5)
                      )
                    ],
                    gradient:
                    LinearGradient(
                        colors: [Colors.amberAccent[100],Colors.amber],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/pen.png',height: 80,width: 100,),
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
                          Text('${thisyear.yeartotalvocab }',
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
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.pink,
                          blurRadius: 12,
                          offset: Offset(0,5)
                      )
                    ],
                    gradient: LinearGradient(
                        colors: [Colors.pinkAccent[100],Colors.pink],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/statistics.png',height: 80,width: 100,),
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
                          Text('${thisyear.yeartotallearn }',
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
              DataChart(dulieu1: dulieudothi1,dulieu2: dulieudothi2,name: 'Yours vocabs this year',),

            ],
          ),
        ),
      ),
    );
  }
}
