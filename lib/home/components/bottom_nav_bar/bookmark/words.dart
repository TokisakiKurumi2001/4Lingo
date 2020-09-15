import 'package:charts_flutter/flutter.dart' as dothi;
import 'package:flutter/material.dart';
class Words {
  String word;
  String meaning;
  String sentence;

  Words({String word, String meaning, String sentence}) {
    this.word = word;
    this.meaning = meaning;
    this.sentence = sentence;
  }
}
class Day {
  // Number of vocabs you wish to remember
  int vocabs;
  // Number of vocabs you haved remembered
  int learned;
  Day({this.learned, this.vocabs});
}
class Week {
  List<Day> myweek = new List(7);
  int numlearnedvocabs;
  int totalvocabs;
  Week(List<Day> temp) {
    myweek = temp;
    numlearnedvocabs = 0;
    totalvocabs = 0;
    for (int i = 0; i < myweek.length; i++) {
      numlearnedvocabs += myweek[i].learned;
      totalvocabs += myweek[i].vocabs;
    }
  }
  Week.fromWeek(int _numlearnedvocab, int _totalvocab)
  {
    numlearnedvocabs = _numlearnedvocab;
    totalvocabs = _totalvocab;
  }
}

class Month {
  List<Week> mymonth = new List(4);
  int monthtotalvocab;
  int monthtotallearned;
  Month(List<Week> temp) {
    mymonth = temp;
    monthtotallearned = 0;
    monthtotalvocab = 0;
    for (int i = 0; i < mymonth.length; i++) {
      monthtotallearned += mymonth[i].numlearnedvocabs;
      monthtotalvocab += mymonth[i].totalvocabs;
    }
  }
}
// This class is used when we draw a chart
class ChartData
{
  final int numvocabs;
  final String specifictime; // This can be monday, thurday, august, something,...
  final dothi.Color barColor;
  ChartData({ @required this.barColor, @required this.numvocabs, @ required this.specifictime});
}

