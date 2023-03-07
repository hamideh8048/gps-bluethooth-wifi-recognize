import 'package:shamsi_date/shamsi_date.dart';


List<Jalali> calculatePersianWeek(Jalali jNow){
  List<Jalali> jList = [];

  switch (jNow.weekDay) { // شنبه ۱ و جمعه ۷ می باشد
    case 1:
      jList.insert(0, jNow);
      jList.insert(1, jNow + 1);
      jList.insert(2, jNow + 2);
      jList.insert(3, jNow + 3);
      jList.insert(4, jNow + 4);
      jList.insert(5, jNow + 5);
      jList.insert(6, jNow + 6);
      break;
    case 2:
      jList.insert(0, jNow - 1);
      jList.insert(1, jNow);
      jList.insert(2, jNow + 1);
      jList.insert(3, jNow + 2);
      jList.insert(4, jNow + 3);
      jList.insert(5, jNow + 4);
      jList.insert(6, jNow + 5);
      break;
    case 3:
      jList.insert(0, jNow - 2);
      jList.insert(1, jNow - 1);
      jList.insert(2, jNow);
      jList.insert(3, jNow + 1);
      jList.insert(4, jNow + 2);
      jList.insert(5, jNow + 3);
      jList.insert(6, jNow + 4);
      break;
    case 4:
      jList.insert(0, jNow - 3);
      jList.insert(1, jNow - 2);
      jList.insert(2, jNow - 1);
      jList.insert(3, jNow);
      jList.insert(4, jNow + 1);
      jList.insert(5, jNow + 2);
      jList.insert(6, jNow + 3);
      break;
    case 5:
      jList.insert(0, jNow - 4);
      jList.insert(1, jNow - 3);
      jList.insert(2, jNow - 2);
      jList.insert(3, jNow - 1);
      jList.insert(4, jNow);
      jList.insert(5, jNow + 1);
      jList.insert(6, jNow + 2);
      break;
    case 6:
      jList.insert(0, jNow - 5);
      jList.insert(1, jNow - 4);
      jList.insert(2, jNow - 3);
      jList.insert(3, jNow - 2);
      jList.insert(4, jNow - 1);
      jList.insert(5, jNow);
      jList.insert(6, jNow + 1);
      break;
    case 7:
      jList.insert(0, jNow - 6);
      jList.insert(1, jNow - 5);
      jList.insert(2, jNow - 4);
      jList.insert(3, jNow - 3);
      jList.insert(4, jNow - 2);
      jList.insert(5, jNow - 1);
      jList.insert(6, jNow);
      break;
  }

  return jList;
}