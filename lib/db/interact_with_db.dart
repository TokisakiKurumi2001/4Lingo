import '../models/vocab.dart';
import 'database_creator.dart';

class DBInteract {
  static Future<List<Vocab>> getAllVocabs({bool isSorted = true}) async {
    final sql = '''
    SELECT * FROM ${DatabaseCreator.tableName}
    ''';
    final sq2 = sql + ' ORDER BY ${DatabaseCreator.word} ASC';
    final data =
        (isSorted == true) ? await db.rawQuery(sq2) : await db.rawQuery(sql);
    List<Vocab> vocabs = List();

    for (final node in data) {
      final todo = Vocab.fromJson(node);
      vocabs.add(todo);
    }

    return vocabs;
  }

//  static Future<bool> checkExistence(String word) async
//  {
//      final sql = '''
//    SELECT * FROM ${DatabaseCreator.tableName} where EXISTS(SELECT * FROM ${DatabaseCreator.tableName}
//    WHERE ${DatabaseCreator.word} = $word)
//    ''';
//      final data = await db.query(sql);
//      if (data.isEmpty)
//        return false;
//      return true;
//
//  }
  static Future<Vocab> getVocab(int id) async {
    final sql = '''
    SELECT * FROM ${DatabaseCreator.tableName}
    WHERE ${DatabaseCreator.id} = $id
    ''';
    final data = await db.rawQuery(sql);
    final vocab = Vocab.fromJson(data[0]);

    return vocab;
  }

  static Future<List<Vocab>> getPattern(String query) async {
    final sq1 = '''
        SELECT * FROM ${DatabaseCreator.tableName}
        WHERE ${DatabaseCreator.word} LIKE '$query%'
        ORDER BY ${DatabaseCreator.word} ASC
    ''';

    final data = await db.rawQuery(sq1);
    List<Vocab> vocabs = List();
    for (final node in data) {
      final todo = Vocab.fromJson(node);
      vocabs.add(todo);
    }
    return vocabs;
  }

  static Future<void> addNewVocab(Vocab myVocab) async {
    final sql = '''
    INSERT INTO ${DatabaseCreator.tableName} (
      ${DatabaseCreator.id},
      ${DatabaseCreator.word},
      ${DatabaseCreator.meaning},
      ${DatabaseCreator.sentence},
      ${DatabaseCreator.createdAt},
      ${DatabaseCreator.updatedAt}
    ) VALUES
    (?,?,?,?,?,?)
    ''';
    List<dynamic> params = [
      myVocab.id,
      myVocab.word,
      myVocab.meaning,
      myVocab.sentence,
      myVocab.createdAt,
      myVocab.updatedAt
    ];
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
    SET ${DatabaseCreator.word} = ?, ${DatabaseCreator.meaning} = ?, ${DatabaseCreator.sentence} = ?, ${DatabaseCreator.updatedAt} = ?
    WHERE ${DatabaseCreator.id} = ?
    ''';
    List<dynamic> params = [
      newVocab.word,
      newVocab.meaning,
      newVocab.sentence,
      newVocab.updatedAt,
      newVocab.id
    ];
    final result = await db.rawUpdate(sql, params);
    DatabaseCreator.databaseLog('Update vocab', sql, null, result, params);
  }

  static Future<int> todosCount() async {
    final data = await db
        .rawQuery('''SELECT MAX(id) FROM ${DatabaseCreator.tableName}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count == null ? 0 : count;
    return idForNewItem;
  }
}

//static Future<Vocab> getVocabfromString(String s) async {
//final sql = '''
//    SELECT * FROM ${DatabaseCreator.tableName}
//    WHERE ${DatabaseCreator.word} = '${s}'
//    ''';
//final data = await db.rawQuery(sql);
//final vocab = Vocab.fromJson(data[0]);
//return vocab;
//}
