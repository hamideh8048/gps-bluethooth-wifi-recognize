import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/date_dialog.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/widgets/saati_widget.dart';
import 'package:Prismaa/screens/kartabl/task_management/task_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

morkhasiFilterOnClick(
    BuildContext context,
    bool startDateError,
    bool endDateError,
    String idCompanySelected,
    TextEditingController _specificDateCtrl,
    bool buttonLoadingInRequest,
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

                            // انتخاب تاریخ
                            Material(
                              color: backgroundColor,
                              child: TextFormField(
                                readOnly: true,
                                controller: _specificDateCtrl,
                                onTap: (){
                                  setState(() {
                                    openGetDateDialog(setState, context, _specificDateCtrl);
                                  });
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  suffixIcon: _specificDateCtrl.text != ""
                                      ? IconButton(
                                      onPressed: (){
                                        setState(() => _specificDateCtrl.text = "");
                                      },
                                      icon: const Icon(Icons.cancel_outlined)
                                  )
                                      : const SizedBox(),
                                  labelText: "انتخاب تاریخ",
                                  labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
                                  hintText: "تاریخ مورد نظر خود را وارد کنید",
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

                            SizedBox(height: 150.sp),
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
                          child: buttonLoadingInRequest
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