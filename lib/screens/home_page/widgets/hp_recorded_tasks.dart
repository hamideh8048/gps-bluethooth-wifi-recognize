import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/task_management_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget hpRecordedTasks(
    BuildContext context,
    int index,
    List<TaskManagementModel> taskManagementList,
    ) {
  return Stack(
    alignment: Alignment.centerLeft,
    children: [
      // این ویجت فقط برای این استفاده شد که بک گراند نارنجی
      // زیرش رو هم اندازه باکس روییش قرار بده وگرنه مقادیرش در صفحه
      // دیده نمیشه و  میشه حذفشون  کرد
      Container(
        width: MediaQuery.of(context).size.width,
        // height: 166,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: setCardBgColor(index, taskManagementList),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 18.sp,
                  width: 18.sp,
                  child: Image.asset("assets/images/location2.png", fit: BoxFit.fill),
                ),
                const SizedBox(width: 8),
                const Text("آدرس: "),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Text("",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14.sp,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  height: 18.sp,
                  width: 18.sp,
                  child: Image.asset("assets/images/clock.png", fit: BoxFit.fill),
                ),
                const SizedBox(width: 8),
                const Text("ساعت ورود: "),
                // Text(currentActivityList[index].shiftEntryHours!,
                //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
                //     fontSize: 14.sp,
                //   ),
                // ),
                Text(" | ",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                const Text(" ساعت خروج: "),
                Text("",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 18.sp,
                  width: 18.sp,
                  child: Image.asset("assets/images/copy-success.png", fit: BoxFit.fill),
                ),
                const SizedBox(width: 8),
                const Text("نوع ثبت: "),
                Text("",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 34,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: setButtonBgColor(index, taskManagementList)
                  ),
                  child: Center(
                    child: Text("",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14.sp,
                        color: setButtonTxtColor(index, taskManagementList),
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
        width: MediaQuery.of(context).size.width - 40,
        // height: 166,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20), topRight: Radius.circular(7), bottomRight: Radius.circular(7)),
          color: backgroundColor,
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.5)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskManagementList[index].activityTitle!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 18.sp,
                  width: 18.sp,
                  child: Image.asset("assets/images/location2.png", fit: BoxFit.fill),
                ),
                const SizedBox(width: 8),
                const Text("آدرس: "),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Text(taskManagementList[index].address!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14.sp,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  height: 18.sp,
                  width: 18.sp,
                  child: Image.asset("assets/images/clock.png", fit: BoxFit.fill),
                ),
                const SizedBox(width: 8),
                const Text("ساعت ورود: "),
                // Text(currentActivityList[index].shiftEntryHours!,
                //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
                //     fontSize: 14.sp,
                //   ),
                // ),
                Text(" | ",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                const Text(" ساعت خروج: "),
                Text(taskManagementList[index].personelExitHourse!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 18.sp,
                  width: 18.sp,
                  child: Image.asset("assets/images/copy-success.png", fit: BoxFit.fill),
                ),
                const SizedBox(width: 8),
                const Text("نوع ثبت: "),
                Text(taskManagementList[index].deviceType!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 34,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: setButtonBgColor(index, taskManagementList)
                  ),
                  child: Center(
                    child: Text(taskManagementList[index].appAction!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14.sp,
                        color: setButtonTxtColor(index, taskManagementList),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Color setButtonBgColor(int index, List<TaskManagementModel> taskManagementList) {
  if(taskManagementList[index].activityColor == 1){
    return const Color(0xFFFAF0EA);
  } else if(taskManagementList[index].activityColor == 2){
    return const Color(0xFFE3F9F0);
  } else {
    return const Color(0xFFE7E7E9);
  }
}

Color setButtonTxtColor(int index, List<TaskManagementModel> taskManagementList) {
  if(taskManagementList[index].activityColor == 1){
    return const Color(0xFFD38345);
  } else if(taskManagementList[index].activityColor == 2){
    return const Color(0xFF528771);
  } else {
    return const Color(0xFF69697B);
  }
}

Color setCardBgColor(int index, List<TaskManagementModel> taskManagementList) {
  if(taskManagementList[index].activityColor == 1){
    return const Color(0xFFF19E38);
  } else if(taskManagementList[index].activityColor == 2){
    return const Color(0xFF59D38F);
  } else {
    return const Color(0xFF676F7E);
  }
}