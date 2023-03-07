import 'package:Prismaa/screens/kartabl/mission/requests_list_tab.dart';
import 'package:Prismaa/screens/kartabl/mission/view_mission_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Mission extends StatefulWidget {
  const Mission({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MissionState();
}

class MissionState extends State<Mission> {
  bool switchWidget = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                          height: 45.sp,
                          width: 45.sp,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/images/arrow_back.png")),
                    ),
                    SizedBox(width: 20.sp),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.sp),
                        Text("ماموریت",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 26.sp,
                          ),
                        ),
                        Text("لیست ماموریت های ثبت شده",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            // fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: Colors.black38
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 30.sp,
                      width: 28.sp,
                      child: Image.asset(
                          "assets/images/notification_kartabl.png",
                          fit: BoxFit.fill),
                    )
                  ],
                ),
              ),
            )),

        body: Column(
          children: [
            // تب بار ها
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            switchWidget = false;
                          });
                        },
                        child: Text(
                          'مشاهده ماموریت',
                          style: Theme.of(context).textTheme.bodyText1!,
                        )
                      ),
                      SizedBox(height: 8.sp),
                      switchWidget
                          ? SizedBox(
                              height: 6.sp,
                            )
                          : Container(
                              width: 80.sp,
                              height: 6.sp,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.sp),
                                      topLeft: Radius.circular(20.sp))),
                            )
                      ]
                    ),

                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              switchWidget = true;
                            });
                          },
                          child: Text(
                            'لیست درخواست ها',
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                        ),
                        SizedBox(height: 8.sp),
                        switchWidget
                            ? Container(
                                width: 80.sp,
                                height: 6.sp,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.sp),
                                        topLeft: Radius.circular(20.sp))),
                              )
                            : SizedBox(
                                height: 6.sp,
                              )
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.2.sp, color: Colors.grey.withOpacity(0.2.sp))),
                ),
                const Divider(color: Colors.black12, thickness: 0.8, height: 0,),
              ],
            ),

          switchWidget
              ? const RequestsListTab()   // ویو لیست درخواست ها
              : const ViewMissionTab()   // ویو مشاهده ماموریت
        ]
      )
    );
  }
}

