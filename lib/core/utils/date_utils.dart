// Date utility functions
import 'package:intl/intl.dart';

class AppDateUtils {
  static String formatDateTime(DateTime date) {
    return DateFormat.yMMMd().add_jm().format(date);
  }

  static String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat.jm().format(date);
  }
}
