import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/flutter_datepicker/flutter_datepicker.dart';
import 'package:Prismaa/components/flutter_datepicker/number_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';


class GetPersianDate extends StatefulWidget {
  final Function(String date) dateChangeListener;

  final String startDate;
  final String endDate;
  final String initialDate;

  final String yearText;
  final String monthText;
  final String dayText;

  final bool showLabels;
  final double columnWidth;
  final bool isJalaali;
  final bool showMonthName;

  const GetPersianDate({Key? key,
    this.startDate = "",
    this.endDate = "",
    this.initialDate = "",
    required this.dateChangeListener,
    this.yearText = "سال",
    this.monthText = "ماه",
    this.dayText = "روز",
    this.showLabels = true,
    this.columnWidth = 65.0,
    this.isJalaali = true,
    this.showMonthName = false,
  }) : super(key: key);

  @override
  State<GetPersianDate> createState() => GetPersianDateState();
}

class GetPersianDateState extends State<GetPersianDate> {
  int? _selectedYear;
  int? _selectedMonth;
  late int _selectedDay;

  int? minYear;
  int? maxYear;

  int minMonth = 01;
  int maxMonth = 12;

  int minDay = 01;
  int maxDay = 31;

  @override
  initState() {
    super.initState();
    if (widget.isJalaali) {
      minYear = Jalali.now().year - 100;
      maxYear = Jalali.now().year;
    } else {
      minYear = Gregorian.now().year - 100;
      maxYear = Gregorian.now().year;
    }
    if (widget.initialDate.isNotEmpty) {
      List<String> initList = widget.initialDate.split("/");
      _selectedYear = int.parse(initList[0]);
      _selectedMonth = int.parse(initList[1]);
    } else {
      if (widget.isJalaali) {
        _selectedYear = Jalali.now().year;
        _selectedMonth = Jalali.now().month;
        _selectedDay = Jalali.now().day;
      } else {
        _selectedYear = Gregorian.now().year;
        _selectedMonth = Gregorian.now().month;
        _selectedDay = Gregorian.now().day;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    maxDay = _getMonthLength(_selectedYear, _selectedMonth);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.showLabels,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: widget.columnWidth.sp,
                      child: Text(widget.dayText,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                          // color: Colors.deepOrange,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                      width: widget.columnWidth.sp,
                      child: Text(
                        widget.monthText,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                          // color: Colors.deepOrange,
                        ),
                        textAlign: TextAlign.center,
                      )
                  ),
                  SizedBox(
                      width: widget.columnWidth.sp,
                      child: Text(
                        widget.yearText,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                          // color: Colors.deepOrange,
                        ),
                        textAlign: TextAlign.center,
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberPicker.integer(
                    zeroPad: true,
                    listViewWidth: widget.columnWidth.sp,
                    initialValue: _selectedDay,
                    minValue: _getMinimumDay(),
                    maxValue: _getMaximumDay(),
                    selectedRowStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: Colors.deepOrange,
                    ),
                    onChanged: (value) {
                      setState(() =>_selectedDay = value as int);
                    }),
                NumberPicker.integer(
                    zeroPad: true,
                    listViewWidth: widget.columnWidth.sp,
                    initialValue: _selectedMonth!,
                    minValue: _getMinimumMonth(),
                    maxValue: _getMaximumMonth(),
                    isShowMonthName: widget.showMonthName,
                    isJalali: widget.isJalaali,
                    selectedRowStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: Colors.deepOrange,
                    ),
                    onChanged: (value) {
                      setState(() => _selectedMonth = value as int?);
                    }
                ),
                NumberPicker.integer(
                    zeroPad: true,
                    listViewWidth: widget.columnWidth.sp,
                    initialValue: _selectedYear!,
                    minValue: _getMinimumYear()!,
                    maxValue: _getMaximumYear(),
                    selectedRowStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: Colors.deepOrange,
                    ),
                    onChanged: (value) {
                      setState(() => _selectedYear = value as int?);
                    }
                ),
              ],
            ),

            SizedBox(height: 8.sp),
            // دکمه تایید تاریخ
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: (){
                    widget.dateChangeListener("$_selectedYear/$_selectedMonth/$_selectedDay");
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("تایید تاریخ",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.blue,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _getMonthLength(int? selectedYear, int? selectedMonth) {
    if (widget.isJalaali) {
      if (selectedMonth! <= 6) {
        return 31;
      }
      if (selectedMonth > 6 && selectedMonth < 12) {
        return 30;
      }
      if (Jalali(selectedYear!).isLeapYear()) {
        return 30;
      } else {
        return 29;
      }
    } else {
      DateTime firstOfNextMonth;
      if (selectedMonth == 12) {
        firstOfNextMonth = DateTime(selectedYear! + 1, 1, 1, 12); //year, selectedMonth, day, hour
      } else {
        firstOfNextMonth = DateTime(selectedYear!, selectedMonth! + 1, 1, 12);
      }
      int numberOfDaysInMonth = firstOfNextMonth.subtract(const Duration(days: 1)).day;
      //.subtract(Duration) returns a DateTime, .day gets the integer for the day of that DateTime
      return numberOfDaysInMonth;
    }
  }

  int _getMinimumMonth() {
    if (widget.startDate.isNotEmpty) {
      var startList = widget.startDate.split("/");
      int startMonth = int.parse(startList[1]);

      if (_selectedYear == _getMinimumYear()) {
        return startMonth;
      }
    }

    return minMonth;
  }

  int _getMaximumMonth() {
    if (widget.endDate.isNotEmpty) {
      var endList = widget.endDate.split("/");
      int endMonth = int.parse(endList[1]);
      if (_selectedYear == _getMaximumYear()) {
        return endMonth;
      }
    }
    return maxMonth;
  }

  int? _getMinimumYear() {
    if (widget.startDate.isNotEmpty) {
      var startList = widget.startDate.split("/");
      return int.parse(startList[0]);
    }
    return minYear;
  }

  _getMaximumYear() {
    if (widget.endDate.isNotEmpty) {
      var endList = widget.endDate.split("/");
      return int.parse(endList[0]);
    }
    return maxYear;
  }

  int _getMinimumDay() {
    if (widget.startDate.isNotEmpty) {
      var startList = widget.startDate.split("/");
      int startDay = int.parse(startList[2]);

      if (_selectedYear == _getMinimumYear() && _selectedMonth == _getMinimumMonth()) {
        return startDay;
      }
    }

    return minDay;
  }

  int _getMaximumDay() {
    if (widget.endDate.isNotEmpty) {
      var endList = widget.endDate.split("/");
      int endDay = int.parse(endList[2]);
      if (_selectedYear == _getMaximumYear() && _selectedMonth == _getMaximumMonth()) {
        return endDay;
      }
    }
    return _getMonthLength(_selectedYear, _selectedMonth);
  }
}
