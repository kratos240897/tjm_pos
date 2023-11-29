import 'package:intl/intl.dart';

class Utils {
  static String getFormattedDate(DateTime dateTime, {bool? isTimeNeeded}) {
    late DateFormat dateFormat;
    if (isTimeNeeded != null && isTimeNeeded) {
      dateFormat = DateFormat('dd MMM y hh:mm a');
    } else {
      dateFormat = DateFormat('dd MMM y');
    }
    return dateFormat.format(dateTime);
  }
}
