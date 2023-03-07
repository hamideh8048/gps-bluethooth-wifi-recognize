import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/morkhasi_list_model.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/morkhasi.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/widgets/mr_recorded_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shamsi_date/shamsi_date.dart';

Widget morkhasiRecordView(
    BuildContext context,
    List<MorkhasiListModel> morkhasiListModel,
    List<Jalali> jWeekList,
    List<bool> selected,
    Function weekDayClick,
    bool listLoading,
    TextEditingController _morkhasiDateController,
    Function chooseDateFunction,
    String today,
    ){
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState){
      return Expanded(
        child: Container(
          color: const Color(0xFFFBFBFD),
          child: Column(
            children: [
              // قسمت نمایش روز و جدول هفتگی
              Container(
                width: MediaQuery.of(context).size.width,
                // height: 195,
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
                  color: backgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // قسمت نمایش روز
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 24.sp, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("امروز " + today,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          GestureDetector(
                            onTap: (){
                              openGetDateDialog2(setState, context, _morkhasiDateController, chooseDateFunction);
                            },
                            child: SizedBox(
                              height: 60.sp,
                              width: 60.sp,
                              child: Image.asset("assets/images/date_icon.png", fit: BoxFit.fill),
                            ),
                          )
                        ],
                      ),
                    ),

                    // قسمت نمایش جدول هفتگی
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 75.sp,
                      child: ListView.builder(
                        itemCount: jWeekList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: (){
                              setState((){
                                selected.clear();
                                for(int i=0; i<7; i++){
                                  if(i == index){
                                    selected.insert(i, true);
                                  } else {
                                    selected.insert(i, false);
                                  }
                                }
                              });
                              weekDayInMorkhasiPage = jWeekList[index]; // متغیر عمومی صفحه مرخصی رو پر میکنه
                              weekDayClick();
                            },
                            child: Container(
                              height: 70.sp,
                              width: 61.w,
                              decoration: BoxDecoration(
                                color: selected[index] ? Colors.black : backgroundColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 8.sp),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(jWeekList[index].day.toString(),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                        color: selected[index] ? Colors.white : Colors.black
                                    ),
                                  ),
                                  Text(jWeekList[index].formatter.wN,
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 15.sp,
                                        color: selected[index] ? Colors.white : Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },

                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              listLoading
                  ?
              const Expanded(child: Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0)))
                  :
              morkhasiListModel.isEmpty
                  ?
              Expanded(
                  child: Center(
                      child: Text("آیتمی برای نمایش وجود ندارد",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.withOpacity(0.8)
                        ),
                      )
                  )
              )
                  :
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: morkhasiListModel.length,
                    itemBuilder: (context, index){
                      return mrRecordedTasks(context, index, morkhasiListModel);
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    },
  );
}