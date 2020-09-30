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
      final vocab = Vocab.fromJson(node);
      vocabs.add(vocab);
    }

    return vocabs;
  }

  static Future<Vocab> getVocab(int id) async {
    final sql = '''
    SELECT * FROM ${DatabaseCreator.tableName}
    WHERE ${DatabaseCreator.id} == $id
    ''';
    final data = await db.rawQuery(sql);
    //We take the index 0 so only one item matching
    final vocab = Vocab.fromJson(data[0]);

    return vocab;
  }

  static Future<void> addNewVocab(Vocab myVocab) async {
    final sql = '''
    INSERT INTO ${DatabaseCreator.tableName} (
      ${DatabaseCreator.id},
      ${DatabaseCreator.word},
      ${DatabaseCreator.meaning},
      ${DatabaseCreator.sentence},
      ${DatabaseCreator.date_created},
      ${DatabaseCreator.date_updated}
    ) VALUES
    (
    ${myVocab.id},
    "${myVocab.word}",
    "${myVocab.meaning}",
    "${myVocab.sentence}",
    "DATETIME('now', 'localtime')",
    "datetime('now', 'localtime')"
    )
    ''';
    List<dynamic> params = [myVocab.id, myVocab.word];
    final result = await db.rawInsert(sql, params);
    DatabaseCreator.databaseLog('Add new vocab', sql, null, result, params);
  }

  static Future<void> deleteVocab(Vocab myVocab) async {
    final sql = '''
    DELETE FROM ${DatabaseCreator.tableName}
    WHERE ${DatabaseCreator.id} = ${myVocab.id}
    ''';
    List<dynamic> params = [myVocab.id];
    final result = await db.rawDelete(sql, params);
    DatabaseCreator.databaseLog('Delete vocab', sql, null, result, params);
  }

  static Future<void> updateVocab(Vocab newVocab) async {
    final sql = '''
    UPDATE ${DatabaseCreator.tableName}
    SET ${DatabaseCreator.word} = "${newVocab.word}",
    ${DatabaseCreator.date_updated} =  "datetime('now', 'localtime')"
    WHERE ${DatabaseCreator.id} = ${newVocab.id}
    ''';

    List<dynamic> params = [newVocab.word, newVocab.id];
    final result = await db.rawUpdate(sql, params);
    DatabaseCreator.databaseLog('Update vocab', sql, null, result, params);
  }

  static Future<int> vocabsCount() async {
    final data = await db
        .rawQuery('''SELECT MAX(id) FROM ${DatabaseCreator.tableName}''');

    dynamic count = data[0].values.elementAt(0);
    int idForNewItem = count == null ? 1 : count++;
    return idForNewItem;
  }

  static Future<int> finding(Vocab newVocab) async {
    final sql = '''
    SELECT id FROM ${DatabaseCreator.tableName}
    WHERE ${DatabaseCreator.word} == ${newVocab.word}
    ''';
    final data = await db.rawQuery(sql);
    int idx = data[0].values.elementAt(0);
    return idx;
  }

  static Future<String> selectMeaning(Vocab newVocab) async {
    final sql = '''
    SELECT meaning FROM ${DatabaseCreator.tableName}
    WHERE ${DatabaseCreator.id} == ${newVocab.id}
    ''';
    final data = await db.rawQuery(sql);
    String result = data[0].values.elementAt(0);
    return result;
  }

  static Future<String> selectSentence(Vocab newVocab) async {
    final sql = '''
    SELECT sentence FROM ${DatabaseCreator.tableName}
    WHERE ${DatabaseCreator.id} == ${newVocab.id}
    ''';
    final data = await db.rawQuery(sql);
    String result = data[0].values.elementAt(0);
    return result;
  }
}
