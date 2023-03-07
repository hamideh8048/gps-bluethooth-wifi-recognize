import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget backPictureWidget() {
  return Positioned(
    left: -30.sp,
    top: -140.sp,
    child: Container(
      width: 518.sp,
      height: 528.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children:[
            // Component Rectangle_ImageView_97   1
            Positioned(
              left: 0.sp,
              top: 89.sp,
              child: SizedBox(
                width: 153.sp,
                height: 200.sp,
                child: Image.asset("assets/images/Rectangle_ImageView_97-125x172.png", fit: BoxFit.fill),
              ),
            ),
            // End Rectangle_ImageView_97
            // Component Rectangle_ImageView_104   2
            Positioned(
              left: 130.sp,
              top: -3.sp,
              child: SizedBox(
                width: 153.sp,
                height: 200.sp,
                child: Image.asset("assets/images/Rectangle_ImageView_104-125x172.png", fit: BoxFit.fill),
              ),
            ),
            // End Rectangle_ImageView_104
            // Component Rectangle_ImageView_105   3
            Positioned(
              left: 258.sp,
              top: -3.sp,
              child: SizedBox(
                width: 153.sp,
                height: 200.sp,
                child: Image.asset("assets/images/Rectangle_ImageView_105-125x172.png", fit: BoxFit.fill),
              ),
            ),
            // End Rectangle_ImageView_105
            // Component Rectangle_ImageView_100   4
            Positioned(
              left: 0.sp,
              top: 267.sp,
              child: SizedBox(
                width: 153.sp,
                height: 200.sp,
                child: Image.asset("assets/images/Rectangle_ImageView_100-125x172.png", fit: BoxFit.fill),
              ),
            ),
            // End Rectangle_ImageView_100
            // Component Rectangle_ImageView_98   5
            Positioned(
              left: 130.sp,
              top: 175.sp,
              child: SizedBox(
                width: 153.sp,
                height: 200.sp,
                child: Image.asset("assets/images/Rectangle_ImageView_98-125x172.png", fit: BoxFit.fill),
              ),
            ),
            // End Rectangle_ImageView_98

            Positioned(
              left: 305.sp,
              top: 195.sp,
              child: SizedBox(
                width: 65.sp,
                height: 65.sp,
                child: Image.asset("assets/images/briefcase_white.png", fit: BoxFit.fill),
              ),
            ),

            // Component Rectangle_ImageView_102   6
            Positioned(
              left: 393.sp,
              top: 129.sp,
              child: SizedBox(
                width: 153.sp,
                height: 200.sp,
                child: Image.asset("assets/images/Rectangle_ImageView_102-125x172.png", fit: BoxFit.fill),
              ),
            ),
            // End Rectangle_ImageView_102
            // Component Rectangle_ImageView_99   7
            Positioned(
              left: 130.sp,
              top: 356.sp,
              child: SizedBox(
                width: 153.sp,
                height: 200.sp,
                child: Image.asset("assets/images/Rectangle_ImageView_99-125x172.png", fit: BoxFit.fill),
              ),
            ),
            // End Rectangle_ImageView_99
            // Component Rectangle_ImageView_101   8
            Positioned(
              left: 261.sp,
              top: 281.sp,
              child: SizedBox(
                width: 153.sp,
                height: 200.sp,
                child: Image.asset("assets/images/Rectangle_ImageView_101-125x172.png", fit: BoxFit.fill),
              ),
            ),
            // End Rectangle_ImageView_101
            // Component Rectangle_ImageView_103   9
            Positioned(
              left: 393.sp,
              top: 311.sp,
              child: SizedBox(
                width: 153.sp,
                height: 200.sp,
                child: Image.asset("assets/images/Rectangle_ImageView_103-125x172.png", fit: BoxFit.fill),
              ),
            ),
            // End Rectangle_ImageView_103

          ]
      ),
    ),
  );
}