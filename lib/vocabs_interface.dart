import 'package:ForLingo/db/interact_with_db.dart';
import 'models/vocab.dart';

bool handleSearch = false;
Future<List<Vocab>> future;

Future<int> createTodo(Vocab v) async {
  int count = await DBInteract.todosCount();
  count += 1;
  //final v = Vocab(count, word);
  v.id = count;
  v.createdAt = DateTime.now().toString();
  v.updatedAt = DateTime.now().toString();
  await DBInteract.addNewVocab(v);
  return v.id;
}

deleteTodo(Vocab v) async {
  await DBInteract.deleteVocab(v);
}

updateTodo(Vocab v) async {
  v.updatedAt = DateTime.now().toString();
  await DBInteract.updateVocab(v);
}
