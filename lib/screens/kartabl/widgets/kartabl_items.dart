import 'package:Prismaa/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget kartablItems(
    BuildContext context,
    String title,
    String subtitle,
    String imageIcon,
    ){
  return Container(
    height: MediaQuery.of(context).size.width *  0.5 - 32,
    width: MediaQuery.of(context).size.width *  0.5 - 32,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black12, width: 0.5),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 15,
          offset: const Offset(10, 10), // changes position of shadow
        ),
      ],
      color: backgroundColor,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 52.sp,
          height: 52.sp,
          child: Image.asset(imageIcon, fit: BoxFit.fill),
        ),
        const SizedBox(height: 8),
        Text(title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            )
        ),
        const SizedBox(height: 6),
        Text(subtitle,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 12.sp,
            color: Colors.black38,
            // fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: MediaQuery.of(context).size.width *  0.5 - 32 <= 160 ? 1 : 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
