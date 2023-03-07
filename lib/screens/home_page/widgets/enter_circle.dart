import 'package:Prismaa/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget EnterCircleWidget(BuildContext context,  bool isEnter,) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [

          CircleAvatar(
            radius: 105.sp,
            backgroundColor:blackColor,
          ),
          CircleAvatar(
            radius: 93.sp,
            backgroundColor:backgroundColor,
          ),

          CircularPercentIndicator(
            radius: 91.sp,
            lineWidth: 12.0,
            backgroundWidth: 1,
            animation: true,
            percent: 1,
            backgroundColor: Colors.black12,
            linearGradient:  LinearGradient(
              colors:isEnter? [
                Color(0xFF4BA9B4),
                Color(0xFF61D38F),
              ]:
              [
                Color(0xFFFF001F),
                Color(0xFFFF1F3A),
              ]
              ,
              begin: FractionalOffset(0.0, 0.5),
              end: FractionalOffset(0.5, 0.0),
              stops: [0.2, 0.7],
            ),
            center: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 28,
                  width: 26,
                  child: Image.asset(isEnter?"assets/images/enter.png":"assets/images/exit.png", fit: BoxFit.fill),
                ),
                Text(isEnter?"ورود":"خروج",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color:blackColor55,
                      fontWeight: FontWeight.w700,
                      fontSize: 22.sp,
                  ),
                ),
                const SizedBox(height: 8),

              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),

    ],
  );
}