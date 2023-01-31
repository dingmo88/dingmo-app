import 'package:flutter/material.dart';

class TimeUtils {
  static String toHourValid(int hour) {
    return hour.toString().length >= 2 ? "${hour % 12}" : "0${hour % 12}";
  }

  static String toMinValid(int min) {
    return min.toString().length >= 2 ? "$min" : "0$min";
  }

  static String toPeriodValid(DayPeriod dayPeriod) {
    return dayPeriod.toString().split(".").last;
  }

  static String getTime(TimeOfDay time) {
    return "${TimeUtils.toHourValid(time.hour)}:${TimeUtils.toMinValid(time.minute)}"
        " ${TimeUtils.toPeriodValid(time.period)}";
  }

  static String dtToDisplayStr(DateTime dateCreated) {
    final diff = DateTime.now().difference(dateCreated);

    if (diff.inDays > 0) {
      return "${diff.inDays}일 전";
    } else if (diff.inHours > 0) {
      return "${diff.inHours}시간 전";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes}분 전";
    } else if (diff.inSeconds > 10) {
      return "${diff.inSeconds}초 전";
    } else {
      return "방금 전";
    }
  }

  static String toDisplayTime(String? time) {
    final timeHms = time?.split(":");

    if (timeHms != null) {
      final numHour = int.parse(timeHms[0]);
      if (numHour > 12) {
        return "오후 ${numHour - 12}:${timeHms[1]}";
      } else {
        return "오전 ${numHour == 0 ? "12" : numHour}:${timeHms[1]}";
      }
    } else {
      return "-";
    }
  }
}
