

// آیتم کارد مشاهده ماموریت
import 'package:Prismaa/models/mission_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget viewMissionCardItems(
    BuildContext context,
    List<MissionModel> missionsList,
    int index,
    String jNow,
    Function(String id) sendStartMission,
    Function(String id) sendEndMission,
    bool showStopButton,
    Function(String id, MissionModel missionModel) explainRecord
    ) {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState){
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 5.sp),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                ),
                child: Column(
                  children: [
                    // کادر خاکستری بالای کارد
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 5.sp),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.sp),
                              topRight: Radius.circular(15.sp)
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('نام شرکت : ' + missionsList[index].companyName,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(height: 6.sp),
                          Text('آدرس : ' + missionsList[index].companyAddress,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 13.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // محتوای درون کارد
                    Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(right: 16.sp)),
                              Image(
                                  height: 16.sp,
                                  image: const AssetImage(
                                      'assets/images/copy-success.png')
                              ),
                              SizedBox(width: 4.sp),
                              Text('نوع ماموریت : ' + missionsList[index].type,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),

                          // ردیف تاریخ یا ساعت شروع و پایان
                          missionsList[index].type == "روزانه"
                          ?
                              Row(
                                children: [
                                  Padding(padding: EdgeInsets.only(right: 16.sp)),
                                  Image(height: 16.sp, image: const AssetImage('assets/images/clock.png')),
                                  SizedBox(width: 4.sp,),
    
                                  Text('تاریخ شروع : ' + missionsList[index].startDate,
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12.sp),
                                  ),
                                  SizedBox(width: 30.sp,),
    
                                  Text('تاریخ پایان : ' + missionsList[index].endDate,
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12.sp)
                                  )
                                ],
                              )
                          :
                              Row(
                                children: [
                                  Padding(padding: EdgeInsets.only(right: 16.sp)),
                                  Image(
                                      height: 16.sp,
                                      image: const AssetImage('assets/images/clock.png')),
                                  SizedBox(width: 4.sp),
                                  Text('ساعت شروع :' + missionsList[index].startTime,
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12.sp),
                                  ),
                                  SizedBox(
                                    width: 30.sp,
                                  ),
                                  Text('ساعت پایان :' + missionsList[index].endTime,
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12.sp)
                                  )
                                ],
                              ),
                          SizedBox(height: 24.sp),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 3.sp),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(16.sp),
                                    color: Colors.green.withOpacity(0.1)
                                ),
                                child: Text('تایید شده',
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 12.sp,
                                      color: Colors.green
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.sp),

                          missionsList[index].statusMission == 0
                          ? startButton(context, setState, sendStartMission, missionsList, index)  // ویو دکمه شروع
                          : missionsList[index].statusMission == 1
                          ? endButton(context, setState, sendEndMission, missionsList, index, showStopButton, explainRecord) // ویو دکمه توقف و ثبت توضیح
                          : const SizedBox(),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      );
    },
  );
}

// ویو دکمه شروع
Widget startButton(BuildContext context, StateSetter setState, Function(String id) sendStartMission, List<MissionModel> missionsList, int index){
  return GestureDetector(
      onTap: () {
        setState(() {
          sendStartMission(missionsList[index].id);
        });
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.sp),
            color: Colors.blue,
          ),
          child: Center(
              child: Text('شروع',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16.sp,
                    color: Colors.white
                ),
              )
          )
      )
  );
}


// ویو دکمه توقف و ثبت توضیح
Widget endButton(BuildContext context, StateSetter setState, Function(String id) sendEndMission, List<MissionModel> missionsList, int index, bool showStopButton, Function(String id, MissionModel missionModel) explainRecord){
  return Column(
    children: [
      // ردیف نمایش مدت زمان گذشته
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('مدت زمان گذشته',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14.sp,
                color: Colors.black.withOpacity(0.6)
            ),
          ),
          const Spacer(),

          // باکس نمایش مدت دقیقه گذشته
          Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(color: Colors.black.withOpacity(0.2))
                  ),
                  child: Text("- -",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 17.sp),
                  )
              ),
              Text('دقیقه',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 12.sp,
                    color: Colors.black.withOpacity(0.3)
                ),
              )
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.sp),
            child: Text(' : ',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 17.sp),
            ),
          ),

          // باکس نمایش مدت ساعت گذشته
          Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(color: Colors.black.withOpacity(0.2))
                  ),
                  child: Text("- -",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 17.sp),
                  )
              ),
              Text('ساعت',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 12.sp,
                    color: Colors.black.withOpacity(0.3)
                ),
              )
            ],
          ),
        ],
      ),
      SizedBox(height: 8.sp),

      // دکمه های توقف و ثبت توضیح
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // دکمه توقف
          if(showStopButton)
            GestureDetector(
              onTap: () {
                setState((){
                  sendEndMission(missionsList[index].id);
                });
              },
              child: Container(
                width: Get.width * 0.58,
                decoration: BoxDecoration(
                  color: const Color(0xfff19e38),
                  borderRadius: BorderRadius.circular(30.sp)
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Center(
                  child: Text('توقف',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16.sp,
                        color: Colors.white
                    ),
                  )
                )
              )
          ),

          // دکمه ثبت توضیح
          GestureDetector(
              onTap: () {
                explainRecord(missionsList[index].id, missionsList[index]);
              },
              child: Container(
                width: Get.width * 0.25,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.sp),
                color: Colors.black.withOpacity(0.6),
                ),
                child: Center(
                  child: Text('ثبت توضیح',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16.sp,
                        color: Colors.white
                    ),
                  )
                )
              )
          ),
        ],
      )
    ],
  );
}