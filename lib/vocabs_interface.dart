import 'package:ForLingo/db/interact_with_db.dart';
import 'package:ForLingo/models/vocab.dart';


Future<List<Vocab>> future;

Future<int> createTodo(String _word, String _meaning) async
{
  int count = await DBInteract.vocabsCount();
  count += 1;
  final v = Vocab(id: count,word: _word,meaning: _meaning,data_updated: DateTime.now().toString(),date_created: DateTime.now().toString());
  await DBInteract.addNewVocab(v);
  return v.id;
}

deleteTodo(Vocab v) async {
  await DBInteract.deleteVocab(v);
}

updateTodo(Vocab v, String word) async {
  v.word = word;
  await DBInteract.updateVocab(v);
}
