import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/date_dialog.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/widgets/saati_widget.dart';
import 'package:Prismaa/screens/kartabl/task_management/task_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

taradodFilterOnClick(
    BuildContext context,
    bool startDateError,
    bool endDateError,
    String idCompanySelected,
    TextEditingController _startDateCtrl,
    TextEditingController _endDateCtrl,
    bool buttonLoading,
    bool checkBox,
    Function(int checkBox) checkBoxFunction,
    Function() showDetail,
    ) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return GestureDetector(
                onTap: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      // height: MediaQuery.of(context).size.height < 670 ? 660 : 730,
                      color: backgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // شکل بالای صفحه
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
                            SizedBox(height: 16.sp),

                            // عنوان فیلتر
                            Text("فیلتر",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 27.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // عنوان فیلتر بر اساس انتخاب روز و جزئیات
                            Text("فیلتر بر اساس انتخاب روز و جرئیات",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 11.sp,
                                  color: Colors.black54
                              ),
                            ),
                            SizedBox(height: 50.sp),

                            // باکس انتخاب شرکت
                            Material(
                              color: backgroundColor,
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  labelText: "انتخاب شرکت ",
                                  labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
                                  hintText: "لطفا یک شرکت انتخاب کنید",
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
                                icon: Icon(Icons.keyboard_arrow_down, size: 30.sp,),
                                value: idCompanySelected,
                                items: UserModel.companies.map((item) => DropdownMenuItem(
                                  value: item.id,
                                  child: Text(item.title, style: Theme.of(context).textTheme.bodyText1),
                                )).toList(),
                                onChanged: (item) => setState(() => idCompanySelected = item!),
                              ),
                            ),

                            SizedBox(height: 50.sp),

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

                            // پیغام ولیدیشن
                            startDateError == false
                                ? SizedBox(height: 40.sp)
                                : SizedBox(
                              height: 40.sp,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text("فیلد انتخاب تاریخ نمی تواند خالی باشد",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.red,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ),

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

                            // پیغام ولیدیشن
                            endDateError == false
                                ? SizedBox(height: 40.sp)
                                : SizedBox(
                              height: 40.sp,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text("فیلد انتخاب تاریخ نمی تواند خالی باشد",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.red,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20.sp),

                            // بخش نمایش حضور و غیاب ناقص
                            Container(
                              height: 100.sp,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: backgroundColor,
                                border: Border.all(color: Colors.black12, width: 0.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Checkbox(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4)
                                          ),
                                          value: checkBox,
                                          activeColor: Colors.blue,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              checkBox = value!;
                                            });
                                            checkBoxFunction(checkBox ? 1 : 0);
                                          }
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text("فقط نمایش حضور و غیاب ناقص",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 130.sp),
                          ],
                        ),
                      ),
                    ),

                    // دکمه نمایش جزئیات
                    SafeArea(
                      child: GestureDetector(
                        onTap: showDetail,
                        child: Container(
                          height: 70.sp,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),
                          child: buttonLoading
                              ?   const Center(child: SpinKitThreeBounce(color: Colors.white60, size: 25.0))
                              :
                          Center(
                            child: Text("نمایش جزئیات",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            );
          }
      );
    },
  );
}