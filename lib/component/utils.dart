import 'package:intl/intl.dart';

class Utils {

  static String getCurrentDateTime(String pattern) {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat(pattern);
    return format.format(now);
  }

  static String getDateTime() {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    return format.format(now);
  }
}