

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget maliReportList(){
  return Expanded(
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index){
            return Column(
              children: [
                ListTile(
                  leading: Container(
                    height: 50.sp,
                    width: 50.sp,
                    decoration: BoxDecoration(
                      image: const DecorationImage(image: AssetImage("assets/images/bardasht_movafagh.png"), fit: BoxFit.fill),
                      color: const Color(0xFFB8EFD8),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  title: Text("برداشت موفق",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("درخواست شماره ۲۴۵۱",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 13.sp,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black38
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("۲۵،۵۰۰،۰۰۰",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("امروز ۲۵ مرداد ۱۴۰۰",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 13.sp,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black26
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.black26, thickness: 0.2, height: 8,),
              ],
            );
          }
      )
  );
}