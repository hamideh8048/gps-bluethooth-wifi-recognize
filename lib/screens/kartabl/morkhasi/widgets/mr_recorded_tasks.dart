import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/morkhasi_list_model.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/morkhasi.dart';
import 'package:Prismaa/screens/kartabl/task_management/task_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget mrRecordedTasks(
    BuildContext context,
    int index,
    List<MorkhasiListModel> morkhasiListModel,
    ) {
  String status = morkhasiListModel[index].status == 0 ? "در انتظار تایید" : morkhasiListModel[index].status == 1 ? "تایید شده" : "رد شده";

  return Container(
    width: MediaQuery.of(context).size.width,
    // height: 170,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    // padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.3),
      borderRadius: BorderRadius.circular(20),
      color: backgroundColor,
    ),

    child: Column(
      children: [
        // عنوان نام شرکت و آدرس
        Container(
            width: MediaQuery.of(context).size.width,
            height: 70.sp,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              border: Border.all(color: Colors.black.withOpacity(0.2), width: 0.1),
              borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 2.sp),
            child: Column(
              children: [
                SizedBox(height: 6.sp),
                Text("نام شرکت : " + morkhasiListModel[index].companyName!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 13.sp,
                    // fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 4.sp),
                Text("آدرس : " + morkhasiListModel[index].companyAddress!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 13.sp,
                    // fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            )
        ),

        Container(
          padding: EdgeInsets.all(16.sp),
          margin: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.sp),
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(3, 5), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              // نوع مرخصی
              Row(
                children: [
                  Container(
                    width: 18.sp, height: 18.sp,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/copy-success.png"),
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                  SizedBox(width: 8.sp),
                  Text("نوع مرخصی : " + morkhasiListModel[index].type!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 13,
                    ),
                  )
                ],
              ),
              SizedBox(height: 8.sp),
              // ساعت شروع و  پایان
              Row(
                children: [
                  Container(
                    width: 18.sp, height: 18.sp,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/clock.png"),
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                  SizedBox(width: 8.sp),
                  morkhasiListModel[index].type == "ساعتی"
                  ?
                      Text("ساعت شروع : " + morkhasiListModel[index].startTime!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13,
                        ),
                      )
                  :
                      Text("تاریخ شروع : " + morkhasiListModel[index].startDate!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13,
                        ),
                      ),
                  SizedBox(width: 16.sp),
                  morkhasiListModel[index].type == "ساعتی"
                  ?
                      Text("ساعت پایان : " + morkhasiListModel[index].endTime!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13,
                        ),
                      )
                  :
                      Text("تاریخ پایان : " + morkhasiListModel[index].endDate!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13,
                        ),
                      ),
                ],
              ),
              SizedBox(height: 12.sp),
              // زمان ثبت مرخصی
              Row(
                children: [
                  morkhasiListModel[index].type == "ساعتی"
                  ?
                      Text(" زمان ثبت مرخصی : " + morkhasiListModel[index].startDate!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13,
                        ),
                      )
                  :   const SizedBox(),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3.sp, horizontal: 8.sp),
                    decoration: BoxDecoration(
                      color: morkhasiListModel[index].status == 1 ? Colors.green.withOpacity(0.2) : morkhasiListModel[index].status == 2 ? Colors.red.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.sp),
                      border: Border.all(color: morkhasiListModel[index].status == 1 ? Colors.green : morkhasiListModel[index].status == 2 ? Colors.red : Colors.grey)
                    ),
                    child: Center(
                      child: Text(status,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12.sp,
                          color: morkhasiListModel[index].status == 1 ? Colors.green : morkhasiListModel[index].status == 2 ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
        )
      ],
    )
  );
}