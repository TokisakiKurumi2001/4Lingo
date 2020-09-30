import '../db/database_creator.dart';

class Vocab {
  int id;
  String word;
  String meaning;
  String sentence;
  String date_created;
  String data_updated;
  Vocab({this.id, this.word, this.meaning, this.sentence, this.date_created,this.data_updated});

  Vocab.fromJson(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.id];
    this.word = json[DatabaseCreator.word];
    this.meaning = json[DatabaseCreator.meaning];
    this.sentence = json[DatabaseCreator.sentence];
    this.date_created = json[DatabaseCreator.date_created];
    this.data_updated = json[DatabaseCreator.date_updated];
  }
}

