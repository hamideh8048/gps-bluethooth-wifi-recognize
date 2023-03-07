import 'package:Prismaa/components/calculate_persian_week.dart';
import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/get_persian_date.dart';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/taradod_list_model.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/kartabl/taradod/view_taradod_tab.dart';
import 'package:Prismaa/screens/kartabl/taradod/widgets/tr_appbar_widget.dart';
import 'package:Prismaa/screens/kartabl/taradod/widgets/tr_recorded_tasks.dart';
import 'package:Prismaa/screens/kartabl/taradod/widgets/taradod_filter_on_click.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'taradod_list_tab.dart';

class Taradod extends StatefulWidget {
  const Taradod({Key? key}) : super(key: key);

  @override
  State<Taradod> createState() => TaradodState();
}

class TaradodState extends State<Taradod> {
  bool switchWidget = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: trAppBarWidget(context),

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
                                'مشاهده تردد',
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
                            'لیست تردد ها',
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
                ? const TaradodListTab()   // ویو لیست تردد ها
                : const ViewTaradodTab()   // ویو مشاهده تردد
          ]
      )
    );
  }

}
