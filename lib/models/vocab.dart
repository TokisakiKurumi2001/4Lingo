import 'package:ForLingo/db/database_creator.dart';
import 'package:ForLingo/vocabs_interface.dart' as vs;
class Vocab {
  int id;
  String createdAt;
  String updatedAt;
  String word, meaning, sentence;
  Vocab({this.word, this.meaning, this.sentence});
  Vocab.fromJson(Map<String,dynamic> map)
  {
    this.id = map[DatabaseCreator.id];
    this.word = map[DatabaseCreator.word];
    this.meaning = map[DatabaseCreator.meaning];
    this.sentence = map[DatabaseCreator.sentence];
    this.createdAt = map[DatabaseCreator.createdAt];
    this.updatedAt = map[DatabaseCreator.updatedAt];
  }

}
