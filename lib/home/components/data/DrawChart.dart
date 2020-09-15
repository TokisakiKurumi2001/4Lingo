import 'package:flutter/material.dart';
import 'package:ForLingo/home/components/bottom_nav_bar/bookmark/words.dart';
import'package:charts_flutter/flutter.dart' as dothi;
class DataChart extends StatelessWidget {
  final List<ChartData> dulieu1;
  final List<ChartData> dulieu2;
  final String name;
  DataChart({@required this.dulieu1,@required this.dulieu2, @required this.name}); // We need to have data to draw chart
  // This class is built only it has appropriate data

  @override
  Widget build(BuildContext context) {
    // Change the data into the series itself
    List<dothi.Series<ChartData,String>> series = [
      dothi.Series(
          id: 'learnedvocabs',
          data: dulieu1,
          // This method takes 2 parameters but we need only one of them so I let the '_'
          domainFn: (ChartData series,_)=> series.specifictime,
          measureFn: (ChartData series,_) => series.numvocabs,
          colorFn:  (ChartData series,_) => series.barColor
      ),
      dothi.Series(
          id: 'totalvocabs',
          data: dulieu2,
          // This method takes 2 parameters but we need only one of them so I let the '_'
          domainFn: (ChartData series,_)=> series.specifictime,
          measureFn: (ChartData series,_) => series.numvocabs,
          colorFn:  (ChartData series,_) => series.barColor
      )
    ];
    return Container(
      height: 500,
      width: 500,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text('$name',
                style: TextStyle(
                    fontFamily: 'IndieFlower',
                    fontSize: 20.0
                ),
              ),
              Expanded(
                child: dothi.BarChart(series,animate: true,
                  barGroupingType: dothi.BarGroupingType.grouped,),
              )
            ],
          ),
        ),
        elevation: 5.0,
      ),
    );
  }
}
