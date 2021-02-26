import 'package:ForLingo/db/interact_with_db.dart';
import 'package:ForLingo/models/vocab.dart';
import 'package:ForLingo/notification/time_manager.dart';
import 'package:ForLingo/notification/notify.dart' as notify;

bool handleSearch = false;
Future<List<Vocab>> future;

Future<int> createNewVocabModel(Vocab v) async {
  int count = await DBInteract.todosCount();
  count += 1;
  v.id = count;
  v.createdAt = DateTime.now().toString();
  v.updatedAt = DateTime.now().toString();

  //NOTE: notification part for storing into the database
  String nowStr = TimeManager.getNowToString();
  String nextStr = TimeManager.getNextToString(1, nowStr);
  v.next = nextStr;
  v.group = 1;
  v.level = 0;
  v.updateNotifyDate = nowStr;
  //NOTE: end notification part for storing into the database

  await DBInteract.addNewVocab(v);

  //NOTE: schedule notification
  int notifyId = TimeManager.timeToUniqueId(nextStr);
  DateTime notifyDate = TimeManager.str2Date(nextStr);
  // set the hour to exactly 8 o'clock in the morning
  notifyDate =
      new DateTime(notifyDate.year, notifyDate.month, notifyDate.day, 8, 0, 0);
  notify.notifyCenter.scheduleAtThisTime(notifyId, notifyDate);
  //NOTE: end schedule notification

  return v.id;
}

deleteVocabModel(Vocab v) async {
  await DBInteract.deleteVocab(v);
}

updateVocabModel(Vocab v) async {
  v.updatedAt = DateTime.now().toString();
  await DBInteract.updateVocab(v);
}

updateNotifyVocabModel(
    Vocab v, int group, int level, String updateNotifyDate) async {
  v.group = group;
  v.level = level;
  v.updateNotifyDate = updateNotifyDate;

  String nextStr = TimeManager.getNextToString(group, updateNotifyDate);
  v.next = nextStr;
  await DBInteract.updateNotifyVocab(v);

  //NOTE: schedule notification
  int notifyId = TimeManager.timeToUniqueId(nextStr);
  DateTime notifyDate = TimeManager.str2Date(nextStr);
  // set the hour to exactly 8 o'clock in the morning
  notifyDate =
      new DateTime(notifyDate.year, notifyDate.month, notifyDate.day, 8, 0, 0);
  notify.notifyCenter.scheduleAtThisTime(notifyId, notifyDate);
  //NOTE: end schedule notification
}
