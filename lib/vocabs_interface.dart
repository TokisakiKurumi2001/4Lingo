import 'package:sqlite_test/db/interact_with_db.dart';
import 'models/Vocab.dart';

Future<List<Vocab>> future;

Future<int> createTodo(String word) async {
  int count = await DBInteract.todosCount();
  count += 1;
  final v = Vocab(count, word);
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
