import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/get_persian_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

Widget roozaneWidget(
    TextEditingController _startDateCtrl,
    TextEditingController _endDateCtrl,
    final _roozaneFormKey,
    bool buttonLoading,
    TextEditingController _dayExplainCtrl,
    ){
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.sp),

          Form(
            key: _roozaneFormKey,
            child: Column(
              children: [
                // تاریخ شروع مرخصی
                Material(
                  color: backgroundColor,
                  child: TextFormField(
                    readOnly: true,
                    controller: _startDateCtrl,
                    onTap: (){
                      setState(() {
                        openGetDateDialog(setState, context, _startDateCtrl);
                      });
                    },
                    validator: (String? value){
                      if(value == ""){
                        return "این فیلد نباید خالی باشد";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      suffixIcon: _startDateCtrl.text != ""
                          ? IconButton(
                          onPressed: (){
                            setState(() => _startDateCtrl.text = "");
                          },
                          icon: const Icon(Icons.cancel_outlined)
                      )
                          : const SizedBox(),
                      labelText: "تاریخ شروع مرخصی",
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
                SizedBox(height: 40.sp),

                // تاریخ پایان مرخصی
                Material(
                  color: backgroundColor,
                  child: TextFormField(
                    readOnly: true,
                    controller: _endDateCtrl,
                    onTap: (){
                      setState(() {
                        openGetDateDialog(setState, context, _endDateCtrl);
                      });
                    },
                    validator: (String? value){
                      if(value == ""){
                        return "این فیلد نباید خالی باشد";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      suffixIcon: _endDateCtrl.text != ""
                          ? IconButton(
                          onPressed: (){
                            setState(() => _endDateCtrl.text = "");
                          },
                          icon: const Icon(Icons.cancel_outlined)
                      )
                          : const SizedBox(),
                      labelText: "تاریخ پایان مرخصی",
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
            ),
          ),
          SizedBox(height: 40.sp),

          // باکس توضیحات
          Material(
            color: backgroundColor,
            child: TextFormField(
              controller: _dayExplainCtrl,
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
    }
  );
}



Future<void> openGetDateDialog(StateSetter setState2, BuildContext context, TextEditingController _controller) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
            child: GetPersianDate(dateChangeListener: (String date) {
              setState2(() {
                _controller.text = date;
              });
            })
        ),
      );
    },
  );
}