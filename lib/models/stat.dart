import '../db/statistic_database_creator.dart';
class Stat
{
  int vocabs;
  int remember;
  Stat.fromJSON(Map <String, dynamic> map)
  {
    this.vocabs = map[StatDBCreator.vocabs];
    this.remember = map[StatDBCreator.remember];
  }
}