import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/mission_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shamsi_date/shamsi_date.dart';



void getExplainDialog(BuildContext context, MissionModel missionItems, TextEditingController _explainCtrl, FocusNode _explainFocusNode, Function(String explain) explainRecord) {
  Jalali jNow = Jalali.now();

  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              color: backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // تصویر بالای صفحه
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 47,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.08),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  Text('ثبت توضیح ماموریت',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.sp),
                  Text("نام شرکت : " + missionItems.companyName,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 12.sp,
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(height: 35.sp),

                  Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // کارد ویو وسط صفحه
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                                  color: backgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(5, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    // کادر خاکستری بالای کارد
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.sp),
                                            topRight: Radius.circular(15.sp)
                                        ),
                                      ),
                                      child: Text('تاریخ و ساعت توضیحات : ' + getToday(jNow),
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),

                                    // محتوای درون کارد
                                    Padding(
                                      padding: EdgeInsets.all(16.sp),
                                      child: Text(missionItems.explain,
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ),
                            SizedBox(height: 42.sp),

                            //  توضیحات
                            Material(
                              color: backgroundColor,
                              child: TextFormField(
                                controller: _explainCtrl,
                                keyboardType: TextInputType.text,
                                textDirection: TextDirection.rtl,
                                autofillHints: const [AutofillHints.name],
                                style: Theme.of(context).textTheme.bodyText1,
                                scrollPadding: EdgeInsets.only(bottom: Get.height),
                                maxLines: 3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  labelText: ' توضیح ماموریت',
                                  labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
                                  hintText: 'توضیح بابت ماموریت',
                                  hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14.sp,
                                      color: Colors.black26
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(color: Colors.black12, width: 1.5),
                                  ),
                                ),
                                focusNode: _explainFocusNode,
                                onFieldSubmitted: null,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.4),
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),

          // دکمه ثبت توضیحات
          SafeArea(
            child: GestureDetector(
              onTap: (){
                if(_explainCtrl.text.isNotEmpty){
                  explainRecord(_explainCtrl.text);
                } else {
                  showSimpleNotification(
                    Text("فیلد توضیح را می بایست پر کنید",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white
                      ),
                    ),
                    background: Colors.red,
                  );
                }
              },
              child: Container(
                height: 70.sp,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(40))
                ),
                margin: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
                child: Center(
                  child: Text("ثبت توضیح",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

String getToday(Date d) {
  final f = d.formatter;
  return '${f.yyyy}/${f.m}/${f.d} | ${f.date.hour}:${f.date.minute}';
}