import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/task_management_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget tsRecordedTasks(
    BuildContext context,
    int index,
    List<TaskManagementModel> taskManagementList,
    ) {
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
                Text("نام شرکت : " + taskManagementList[index].company!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 13.sp,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 4.sp),
                Text("آدرس : "  + taskManagementList[index].address!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 13.sp,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            )
        ),

        Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عنوان
                  Text(taskManagementList[index].activityTitle!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 8.sp),

                  // ردیف تعریف آدرس
                  Row(
                    children: [
                      SizedBox(
                        height: 18.sp,
                        width: 18.sp,
                        child: Image.asset("assets/images/location2.png", fit: BoxFit.fill),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.74,
                        child: Text(taskManagementList[index].address!,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 13.sp,
                            // fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.sp),

                  // ردیف تعریف ساعت ورود و خروج
                  Row(
                    children: [
                      SizedBox(
                        height: 18.sp,
                        width: 18.sp,
                        child: Image.asset("assets/images/clock.png", fit: BoxFit.fill),
                      ),
                      const SizedBox(width: 8),
                      Text("ساعت ورود : " + taskManagementList[index].personelEntryHours!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13.sp,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(" | ",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13.sp,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("ساعت خروج : " + taskManagementList[index].personelExitHourse!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13.sp,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.sp),

                  // ردیف تعریف نوع ثبت و وضعیت انجام
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 18.sp,
                        width: 18.sp,
                        child: Image.asset("assets/images/copy-success.png", fit: BoxFit.fill),
                      ),
                      const SizedBox(width: 8),
                      Text("نوع ثبت : " + taskManagementList[index].deviceType!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13.sp,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 34.sp,
                        width: 100.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: taskManagementList[index].activityColor == 1 ? Colors.green.withOpacity(0.2) : taskManagementList[index].activityColor == 2 ? Colors.red.withOpacity(0.2) : Colors.grey.withOpacity(0.2)
                        ),
                        child: Center(
                          child: Text(taskManagementList[index].appAction!,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 13.sp,
                              color: taskManagementList[index].activityColor == 1 ? Colors.green : taskManagementList[index].activityColor == 2 ? Colors.red : Colors.grey
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 5.sp, height: 130.sp,
                color: taskManagementList[index].activityColor == 1 ? Colors.green : taskManagementList[index].activityColor == 2 ? Colors.red : Colors.grey
            )
          ],
        )
      ],
    ),
  );
}