import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget itemsWidget(BuildContext context, String imageIcon, String text, bool textColor, bool notify){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        const SizedBox(width: 10),
        SizedBox(
          width: 24.sp,
          height: 24.sp,
          child: Image.asset(imageIcon,
              fit: BoxFit.fill,
              color: textColor ? Colors.red : Colors.black
          ),
        ),
        const SizedBox(width: 20),
        Text(text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
              color: textColor ? Colors.red : Colors.black
          ),
        ),
        const Spacer(),
        notify
            ? Container(
          width: 35.sp,
          height: 18.sp,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFF4BB40),
          ),
          child: Center(
            child: Text("۲", style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.sp
            )
            ),
          ),
        )
            : const SizedBox(),
        SizedBox(
          width: 25.sp,
          height: 25.sp,
          child: Image.asset("assets/images/arrow-left.png", fit: BoxFit.fill, color: Colors.black),
        ),
        const SizedBox(width: 10),
      ],
    ),
  );
}