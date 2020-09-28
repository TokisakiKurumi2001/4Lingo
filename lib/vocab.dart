import 'package:ForLingo/db/database_creator.dart';
class Vocab {
  int id;
  String word, meaning, sentence;
  Vocab({this.word, this.meaning, this.sentence});
  Vocab.fromJson(Map<String,dynamic> map)
  {
    this.id = map[DatabaseCreator.id];
    this.word = map[DatabaseCreator.word];
    this.meaning = map[DatabaseCreator.meaning];
    this.sentence = map[DatabaseCreator.sentence];
  }
}
