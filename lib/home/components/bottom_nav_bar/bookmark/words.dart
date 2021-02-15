import 'package:charts_flutter/flutter.dart' as dothi;
import 'package:flutter/material.dart';
import 'package:ForLingo/models/stat.dart';
class Day {
  // Number of vocabs you wish to remember
  int vocabs;
  // Number of vocabs you haved remembered
  int learned;
  Day({this.learned, this.vocabs});
}

//class Week {
//  List<Day> myweek = new List(7);
//  int numlearnedvocabs;
//  int totalvocabs;
//  Week(List<Day> temp) {
//    myweek = temp;
//    numlearnedvocabs = 0;
//    totalvocabs = 0;
//    for (int i = 0; i < myweek.length; i++) {
//      numlearnedvocabs += myweek[i].learned;
//      totalvocabs += myweek[i].vocabs;
//    }
//  }
//  Week.fromWeek(int _numlearnedvocab, int _totalvocab) {
//    numlearnedvocabs = _numlearnedvocab;
//    totalvocabs = _totalvocab;
//  }
//}
class Week {
  List<Stat> myWeek = new List<Stat>();
  int numLearnedVocabs;
  int totalVocabs;
  Week(List<Stat> temp) {
    myWeek = temp;
    numLearnedVocabs = 0;
    totalVocabs = 0;
    for(final node in myWeek){
      numLearnedVocabs += node.remember;
      totalVocabs += node.vocabs;
    }
  }
  Week.fromWeek(int _numlearnedvocab, int _totalvocab) {
    numLearnedVocabs = _numlearnedvocab;
    totalVocabs = _totalvocab;
  }
}

//class Month {
//  List<Week> mymonth = new List(4);
//  int monthtotalvocab;
//  int monthtotallearned;
//  Month(List<Week> temp) {
//    mymonth = temp;
//    monthtotallearned = 0;
//    monthtotalvocab = 0;
//    for (int i = 0; i < mymonth.length; i++) {
//      monthtotallearned += mymonth[i].numlearnedvocabs;
//      monthtotalvocab += mymonth[i].totalvocabs;
//    }
//  }
//  Month.fromMonth(int _monthtotalvocab, int _monthtotallearned) {
//    monthtotalvocab = _monthtotalvocab;
//    monthtotallearned = _monthtotallearned;
//  }
//}
class Month {
  List<Stat> myMonth = new List<Stat>();
  int monthTotalVocab;
  int monthTotalLearned;
  Month(List<Stat> temp) {
    myMonth = temp;
    monthTotalLearned = 0;
    monthTotalVocab = 0;
    for (final node in myMonth ) {
      monthTotalLearned += node.remember;
      monthTotalVocab += node.vocabs;
    }
  }
  Month.fromMonth(int _monthtotalvocab, int _monthtotallearned) {
    monthTotalVocab = _monthtotalvocab;
    monthTotalLearned = _monthtotallearned;
  }
}

class Year {
  List<Stat> myYear = new List<Stat>();
  int yearTotalVocab;
  int yearTotalLearn;
  Year(List<Stat> temp) {
    myYear = temp;
    yearTotalLearn = yearTotalVocab = 0;
    for (final node in temp) {
      yearTotalVocab += node.vocabs;
      yearTotalLearn += node.remember;
    }
  }
}

// This class is used when we draw a chart
class ChartData {
  final int numvocabs;
  final String
      specifictime; // This can be monday, thursday, august, something,...
  final dothi.Color barColor;
  ChartData(
      {@required this.barColor,
      @required this.numvocabs,
      @required this.specifictime});
}
