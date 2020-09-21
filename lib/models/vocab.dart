// import '../db/database_creator.dart';

// class Vocab {
//   int id;
//   String word;
//   String meaning;
//   String sentence;

//   Vocab({this.id, this.word, this.meaning, this.sentence});

//   Vocab.fromJson(Map<String, dynamic> json) {
//     this.id = json[DatabaseCreator.id];
//     this.word = json[DatabaseCreator.word];
//     this.meaning = json[DatabaseCreator.meaning];
//     this.sentence = json[DatabaseCreator.sentence];
//   }
// }

class Vocab {
  String word, meaning, sentence;
  Vocab({this.word, this.meaning, this.sentence});
}
