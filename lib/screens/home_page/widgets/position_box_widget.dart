import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget positionBoxWidget(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    // height: 170,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // ساعت ورود
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40.sp,
              height: 40.sp,
              child: Image.asset("assets/images/frame2.png", fit: BoxFit.fill),
            ),
            const SizedBox(height: 8),
            Text("۸:۳۰",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("ساعت ورود",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 15.sp,
                color: Colors.black38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          height: 90.sp,
          width: 1.sp,
          color: Colors.black12,
        ),
        // ساعت خروج
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40.sp,
              height: 40.sp,
              child: Image.asset("assets/images/export.png", fit: BoxFit.fill),
            ),
            const SizedBox(height: 8),
            Text("۱۹:۳۰",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("ساعت خروج",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 15.sp,
                color: Colors.black38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    ),
  );
}