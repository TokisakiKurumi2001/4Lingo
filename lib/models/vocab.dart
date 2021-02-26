import 'package:ForLingo/db/database_creator.dart';

class Vocab {
  int id;
  String createdAt;
  String updatedAt;
  String word, meaning, sentence;

  //==================
  //NOTE: notify field
  String next;
  int group;
  int level;
  String updateNotifyDate;
  //==================

  //==================
  //NOTE: statistic field
  int isRemember;
  //==================

  Vocab({this.word, this.meaning, this.sentence});
  Vocab.fromJson(Map<String, dynamic> map) {
    this.id = map[DatabaseCreator.id];
    this.word = map[DatabaseCreator.word];
    this.meaning = map[DatabaseCreator.meaning];
    this.sentence = map[DatabaseCreator.sentence];
    this.createdAt = map[DatabaseCreator.createdAt];
    this.updatedAt = map[DatabaseCreator.updatedAt];
    this.next = map[DatabaseCreator.next];
    this.group = map[DatabaseCreator.group];
    this.level = map[DatabaseCreator.level];
    this.updateNotifyDate = map[DatabaseCreator.updateNotifyDate];
  }
}
