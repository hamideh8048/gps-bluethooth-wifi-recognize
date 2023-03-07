import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/date_dialog.dart';
import 'package:Prismaa/components/get_persian_date.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shamsi_date/shamsi_date.dart';

Widget saatiWidget(
    TextEditingController _dateController,
    final _dateFormKey,
    TextEditingController _startMinuteCtrl,
    TextEditingController _startHourCtrl,
    TextEditingController _endMinuteCtrl,
    TextEditingController _endHourCtrl,
    bool buttonLoading,
    DateTime _dateTime,
    final _timeFormKey,
    TextEditingController _saatiExplainCtrl,
    ){
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.sp),

          Form(
              key: _dateFormKey,
              child: Column(
                children: [
                  // انتخاب بازه تاریخ
                  Material(
                    color: backgroundColor,
                    child: TextFormField(
                      readOnly: true,
                      controller: _dateController,
                      onTap: (){
                        setState(() {
                          openGetDateDialog(setState, context, _dateController);
                        });
                      },
                      validator: (String? value){
                        if(value == ""){
                          return "این فیلد نباید خالی باشد";
                        } else {
                          return null;
                        }
                      },
                      textDirection: TextDirection.ltr,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: _dateController.text != ""
                            ? IconButton(
                            onPressed: (){
                              setState(() => _dateController.text = "");
                            },
                            icon: const Icon(Icons.cancel_outlined)
                        )
                            : const SizedBox(),
                        labelText: "انتخاب تاریخ",
                        labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
                        hintText: "لطفا یک تاریخ انتخاب کنید",
                        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14.sp,
                            color: Colors.black26
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: const BorderSide(
                              color: Colors.black12, width: 1.5),
                        ),
                        // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                      ),
                    ),
                  ),
                ],
              )
          ),
          SizedBox(height: 40.sp),

          // زمان شروع و پایان
          Row(
            children: [
              // زمان شروع
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("زمان شروع",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 12.sp),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            chooseTime(context, _startMinuteCtrl, _startHourCtrl, _dateTime);
                          },
                          child: timeTextForm(_startHourCtrl, context)
                      ),
                      Text("  :  ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            chooseTime(context, _startMinuteCtrl, _startHourCtrl, _dateTime);
                          },
                          child: timeTextForm(_startMinuteCtrl, context)
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),

              // زمان پایان
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("زمان پایان",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          chooseTime2(context, _endHourCtrl, _endMinuteCtrl, _dateTime);
                        },
                        child: timeTextForm(_endMinuteCtrl, context)
                      ),
                      Text("  :  ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          chooseTime2(context, _endHourCtrl, _endMinuteCtrl, _dateTime);
                        },
                        child: timeTextForm(_endHourCtrl, context),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),

          SizedBox(height: 40.sp),

          // باکس توضیحات
          Material(
            color: backgroundColor,
            child: TextFormField(
              controller: _saatiExplainCtrl,
              validator: (String? value){
                if(value == ""){
                  return "این فیلد نباید خالی باشد";
                } else {
                  return null;
                }
              },
              scrollPadding: EdgeInsets.only(bottom: Get.height),
              maxLines: 5,
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: "توضیحات",
                labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
                hintText: "توضیحات خود را وارد کنید",
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14.sp,
                    color: Colors.black26
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: const BorderSide(
                      color: Colors.black12, width: 1.5),
                ),
                // prefixIcon: Icon(prefixIcon, color: Colors.black12),
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.4),
        ],
      );
    },
  );
}

chooseTime(BuildContext context, TextEditingController _startHourCtrl, TextEditingController _startMinuteCtrl, DateTime _dateTime) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              color: backgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(flex: 1, child: SizedBox()),
                  // مشاهده دکمه  تایید ساعت
                  Expanded(
                    flex: 5,
                    child: InkWell(
                        onTap: (){
                          _startHourCtrl.text = _dateTime.toJalali().hour.toString();
                          _startMinuteCtrl.text = _dateTime.toJalali().minute.toString();
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0.sp),
                          child: Text("تایید ساعت",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        )
                    ),
                  ),


                  // مشاهده زمان برای انتخاب
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SizedBox(height: 8.sp),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 26.sp, vertical: 8.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("دقیقه",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 30.sp),

                              Text("ساعت",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.grey.withOpacity(0.3), indent: 16.sp, height: 12.sp, thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: TimePickerSpinner(
                                is24HourMode: true,
                                normalTextStyle: TextStyle(
                                  fontSize: 20.0.sp,
                                ),
                                highlightedTextStyle: TextStyle(
                                  fontSize: 20.0.sp,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                                // spacing: 50,
                                itemHeight: 55.sp,
                                isForce2Digits: true,
                                onTimeChange: (time) {
                                  setState(() {
                                    _dateTime = time;
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),

                ],
              ),
            );
          }
        );
      }
  );
}



chooseTime2(BuildContext context, TextEditingController _endHourCtrl, TextEditingController _endMinuteCtrl, DateTime _dateTime) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context){
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                color: backgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 1, child: SizedBox()),
                    // مشاهده دکمه  تایید ساعت
                    Expanded(
                      flex: 5,
                      child: InkWell(
                          onTap: (){
                            _endHourCtrl.text = _dateTime.toJalali().hour.toString();
                            _endMinuteCtrl.text = _dateTime.toJalali().minute.toString();
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0.sp),
                            child: Text("تایید ساعت",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          )
                      ),
                    ),


                    // مشاهده زمان برای انتخاب
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          SizedBox(height: 8.sp),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 26.sp, vertical: 8.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("دقیقه",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 30.sp),

                                Text("ساعت",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey.withOpacity(0.3), indent: 16.sp, height: 12.sp, thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: TimePickerSpinner(
                                  is24HourMode: true,
                                  normalTextStyle: TextStyle(
                                    fontSize: 20.0.sp,
                                  ),
                                  highlightedTextStyle: TextStyle(
                                    fontSize: 20.0.sp,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // spacing: 50,
                                  itemHeight: 55.sp,
                                  isForce2Digits: true,
                                  onTimeChange: (time) {
                                    setState(() {
                                      _dateTime = time;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),

                  ],
                ),
              );
            }
        );
      }
  );
}



Widget timeTextForm(TextEditingController controller, BuildContext context) {
  return SizedBox(
    height: 60.sp, width: 60.sp,
    child: Material(
      color: backgroundColor,
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp
        ),
        enabled: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: "- -",
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
          contentPadding: const EdgeInsets.only(top: 20),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
                color: Colors.black12, width: 1.5),
          ),
        ),
      ),
    ),
  );
}
