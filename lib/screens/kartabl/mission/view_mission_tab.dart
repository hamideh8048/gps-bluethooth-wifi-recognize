import 'package:Prismaa/components/calculate_persian_week.dart';
import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/mission_model.dart';
import 'package:Prismaa/screens/kartabl/mission/widgets/get_explain_dialog.dart';
import 'package:Prismaa/screens/kartabl/mission/widgets/show_dialog_in_mission.dart';
import 'package:Prismaa/screens/kartabl/mission/widgets/view_mission_card_item.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shamsi_date/shamsi_date.dart';

class ViewMissionTab extends StatefulWidget {
  const ViewMissionTab({Key? key}) : super(key: key);

  @override
  State<ViewMissionTab> createState() => ViewMissionTabbState();
}

class ViewMissionTabbState extends State<ViewMissionTab> {
  List<Jalali> jWeekList = []; // یک هفته شمسی رو در خودش میریزه
  List<MissionModel> missionsList = [];

  List<bool> selected = [];
  Jalali weekDayInMorkhasiPage = Jalali.now(); // یه متغیر عمومی برای استفاده محتوای ویجت انتخاب تاریخ این صفحه
  String date = Jalali.now().year.toString() + "/" + Jalali.now().month.toString() + "/" + Jalali.now().day.toString();
  bool listLoading = true;
  Jalali jNow = Jalali.now();
  bool showStopButton = true;
  final TextEditingController _explainCtrl = TextEditingController();
  final FocusNode _explainFocusNode = FocusNode();



  @override
  void initState() {
    super.initState();
    int idx = Jalali.now().weekDay - 1;
    for(int i=0; i<7; i++){
      if(i == idx){
        selected.insert(i, true);
      } else {
        selected.insert(i, false);
      }
    }

    jWeekList = calculatePersianWeek(jNow); // به طور پیش فرض امروز رو میریزه تو  فانکشن محاسبه یک هفته شمسی
    getMissionList(date);
  }

  getMissionList(String date) async {
    date = "1401/7/12"; ///////////////////////
    listLoading = true;
    missionsList.clear();
    var response = await (Services()).getMissionList(date);
    if(response[0]["res"] == 1){
      setState(() {
        response.forEach((element){
          missionsList.add(MissionModel.fromJson(element));
        });
        listLoading = false;
      });
    } else if(response[0]["res"] == -1){
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      setState(() => listLoading = false);
    }
  }

  sendStartMission(String missionId) async {
    var response = await (Services()).sendStartMission(int.parse(missionId));
    if(response[0]["res"] == 1){
      setState(() {
        getMissionList(date);
      });
      showSimpleNotification(
        Text("شروع ماموریت شما ثبت شد",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white
            )),
        background: Colors.green,
      );
    } else if(response[0]["res"] == -1) {
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      setState(() => listLoading = false);
    }
  }


  sendEndMission(String missionId) async {
    var response = await (Services()).sendEndMission(int.parse(missionId));
    if(response[0]["res"] == 1){
      setState((){
        showStopButton = false;
      });
      showSimpleNotification(
        Text("ماموریت متوقف شد",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white
            )),
        background: Colors.green,
      );
    } else if(response[0]["res"] == -1) {
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      setState(() => listLoading = false);
    }
  }


  explainRecord(String missionId, MissionModel requestsList) async {
    getExplainDialog(context, requestsList, _explainCtrl, _explainFocusNode, (String explain){
      Get.back();
      sendExplainAndId(missionId, explain);
    });
  }

  sendExplainAndId(String missionId, String explain) async {
    var response = await (Services()).setExplainMission(int.parse(missionId), explain);
    if(response[0]["res"] == 1){
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.green
            )),
        background: Colors.green,
      );
    } else if(response[0]["res"] == -1) {
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white
            )),
        background: Colors.red,
      );
      setState(() => listLoading = false);
    }
  }

  @override
  void dispose() {
    _explainCtrl.dispose();
    _explainFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          children: [
            Container(height: 16.sp, color: backgroundColor),
            // قسمت نمایش جدول هفتگی
            Container(
              width: MediaQuery.of(context).size.width,
              height: 75.sp,
              color: backgroundColor,
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
            Container(height: 16.sp, color: backgroundColor),

            SizedBox(height: 8.sp),

            listLoading
                ?
            const Expanded(child: Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0)))
                :
            missionsList.isEmpty
                ?
            // تکست آیتمی برای نمایش وجود ندارد
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
                child: ListView.builder(
                    itemCount: missionsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          showDialogInMission(context, missionsList[index]);
                        },
                        child: viewMissionCardItems(
                          context,
                          missionsList,
                          index,
                          date,
                          (String id){sendStartMission(missionsList[index].id);},
                          (String id){sendEndMission(missionsList[index].id);},
                          showStopButton,
                          (String id, MissionModel missionModel){explainRecord(missionsList[index].id, missionsList[index]);},
                        ),
                      );
                    }
                )
            ),
          ],
        ));
  }

  weekDayClick(){
    date = weekDayInMorkhasiPage.year.toString() + "/" + weekDayInMorkhasiPage.month.toString() + "/" + weekDayInMorkhasiPage.day.toString();
    getMissionList(date);
  }
}
