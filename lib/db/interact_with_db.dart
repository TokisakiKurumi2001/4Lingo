import '../models/vocab.dart';
import 'database_creator.dart';

class DBInteract {
  static Future<List<Vocab>> getAllVocabs() async {
    final sql = '''
    SELECT * FROM ${DatabaseCreator.tableName}
    ''';
    final data = await db.rawQuery(sql);
    List<Vocab> vocabs = List();

    for (final node in data) {
      final todo = Vocab.fromJson(node);
      vocabs.add(todo);
    }

    return vocabs;
  }

  static Future<Vocab> getVocab(int id) async {
    final sql = '''
    SELECT * FROM ${DatabaseCreator.tableName}
    WHERE ${DatabaseCreator.id} = $id
    ''';
    final data = await db.rawQuery(sql);
    final vocab = Vocab.fromJson(data[0]);

    return vocab;
  }

  static Future<void> addNewVocab(Vocab myVocab) async {
    final sql = '''
    INSERT INTO ${DatabaseCreator.tableName} (
      ${DatabaseCreator.id},
      ${DatabaseCreator.word}
    ) VALUES
    (?,?)
    ''';
    List<dynamic> params = [myVocab.id, myVocab.word];
    final result = await db.rawInsert(sql, params);
    DatabaseCreator.databaseLog('Add new vocab', sql, null, result, params);
  }

  static Future<void> deleteVocab(Vocab myVocab) async {
    final sql = '''
    DELETE FROM ${DatabaseCreator.tableName}
    WHERE ${DatabaseCreator.id} = ?
    ''';
    List<dynamic> params = [myVocab.id];
    final result = await db.rawDelete(sql, params);
    DatabaseCreator.databaseLog('Delete vocab', sql, null, result, params);
  }

  static Future<void> updateVocab(Vocab newVocab) async {
    final sql = '''
    UPDATE ${DatabaseCreator.tableName}
    SET ${DatabaseCreator.word} = ?
    WHERE ${DatabaseCreator.id} = ?
    ''';
    List<dynamic> params = [newVocab.word, newVocab.id];
    final result = await db.rawUpdate(sql, params);
    DatabaseCreator.databaseLog('Update vocab', sql, null, result, params);
  }

  static Future<int> todosCount() async {
    final data = await db
        .rawQuery('''SELECT MAX(id) FROM ${DatabaseCreator.tableName}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count == null ? 1 : count++;
    return idForNewItem;
  }
}
