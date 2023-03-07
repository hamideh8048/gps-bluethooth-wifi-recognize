import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/mission_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void showDialogInMission(BuildContext context, MissionModel missionItems) {
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // تصویر بالای صفحه
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
              const SizedBox(height: 30),
              Text(missionItems.companyName,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 34,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // color: setButtonBgColor(0, missionItems)
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.sp),

              // لوکیشن و آدرس
              SizedBox(
                height: 90,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100.sp, width: 100.sp,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.sp),
                        child: Image.asset("assets/images/piece_of_map2.png", fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 8.sp),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Text("آدرس: " + missionItems.companyAddress,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 13
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )
                        ),
                        Text("مسیریابی به محل  >",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14.sp,
                              color: Colors.blue
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 16.sp),

              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 32, width: 32,
                                  child: Image.asset("assets/images/calender.png", fit: BoxFit.cover,)
                              ),
                              SizedBox(width: 12.sp),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("۲۵ اردیبهشت ۱۴۰۰",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text("تاریخ انجام",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.black54
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                  ),
                  SizedBox(width: 16.sp),
                  Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 27, width: 27,
                                  child: Image.asset("assets/images/clock.png", fit: BoxFit.cover,)
                              ),
                              SizedBox(width: 12.sp),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("۱۳:۳۰ تا ۱۵:۳۰",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text("ساعت انجام",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.black54
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(height: 24.sp),
              Text("شرح کار :",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.sp),
              Text(missionItems.explain,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 14.sp,
                ),
                maxLines: 9,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}