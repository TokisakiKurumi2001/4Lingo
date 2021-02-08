import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeManager {
  static String getNowToString() {
    tz.initializeTimeZones();
    final hcm = tz.getLocation('Asia/Ho_Chi_Minh');
    tz.TZDateTime now = tz.TZDateTime.now(hcm);
    String result = "";
    result += now.year.toString() + " ";
    result += now.month.toString() + " ";
    result += now.day.toString() + " ";
    result += now.hour.toString() + " ";
    result += now.minute.toString();
    return result;
  }

  static String getNextToString(int alreadyIncreaseGroup, String currentTime) {
    List<int> list =
        currentTime.split(" ").map((string) => int.parse(string)).toList();
    DateTime newTime = DateTime(list[0], list[1], list[2], list[3], list[4]);
    newTime = newTime.add(Duration(days: alreadyIncreaseGroup));
    String result = "";
    result += newTime.year.toString() + " ";
    result += newTime.month.toString() + " ";
    result += newTime.day.toString() + " ";
    result += newTime.hour.toString() + " ";
    result += newTime.minute.toString();
    return result;
  }

  // this algorithm is to generate the id from the time to schedule
  static int timeToUniqueId(String aTime) {
    // we use id = (month * 12 * 24 + day * 25) % 16
    List<int> list =
        aTime.split(" ").map((string) => int.parse(string)).toList();
    int month = list[1];
    int day = list[2];
    return (month * 12 * 24 + day * 25) % 16;
  }

  static DateTime str2Date(String aTime) {
    List<int> list =
        aTime.split(" ").map((string) => int.parse(string)).toList();
    DateTime theTime = DateTime(list[0], list[1], list[2], list[3], list[4]);
    return theTime;
  }
}
