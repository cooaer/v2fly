import 'package:intl/intl.dart';

DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

DateFormat dateFormat = DateFormat('yyyy-MM-dd');

DateTime dateTimeFromString(String str) {
  return dateTimeFormat.parse(str);
}

String dateTimeToString(DateTime dateTime) {
  return dateTimeFormat.format(dateTime);
}

String dateTimeToDisplay(DateTime dateTime) {
  final timeDelta = DateTime.now().millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch;
  const minMills = 60 * 1000;
  const hourMills = 60 * minMills;
  const dayMills = 24 * hourMills;

  if (timeDelta >= 8 * dayMills) {
    return dateFormat.format(dateTime);
  } else if (timeDelta >= dayMills) {
    return "${timeDelta ~/ dayMills}天前";
  } else if (timeDelta >= hourMills) {
    return "${timeDelta ~/ hourMills}小时前";
  } else if (timeDelta >= minMills) {
    return "${timeDelta ~/ minMills}分钟前";
  }
  return "刚刚";
}
