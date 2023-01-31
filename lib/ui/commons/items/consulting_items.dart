import 'package:flutter/material.dart';

class ConsultingTime {
  TimeOfDay? start;
  TimeOfDay? end;
  ConsultingTime({this.start, this.end});
}

enum Day { mon, tue, wed, thu, fri, sat, sun }

String dayToStr(Day day) {
  switch (day) {
    case Day.mon:
      return "1";
    case Day.tue:
      return "2";
    case Day.wed:
      return "3";
    case Day.thu:
      return "4";
    case Day.fri:
      return "5";
    case Day.sat:
      return "6";
    case Day.sun:
      return "7";
    default:
      return dayToStr(Day.mon);
  }
}

String dayStrToDisplayStr(String dayStr) {
  switch (dayStr) {
    case "1":
      return "월";
    case "2":
      return "화";
    case "3":
      return "수";
    case "4":
      return "목";
    case "5":
      return "금";
    case "6":
      return "토";
    case "7":
      return "일";
    default:
      return "";
  }
}
