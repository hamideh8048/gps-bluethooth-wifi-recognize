import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/login_text_feild.dart';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/mission_model.dart';
import 'package:Prismaa/screens/kartabl/mission/widgets/get_explain_dialog.dart';
import 'package:Prismaa/screens/kartabl/mission/widgets/view_mission_card_item.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:Prismaa/screens/kartabl/mission/widgets/show_dialog_in_mission.dart';

class RequestsListTab extends StatefulWidget {
  const RequestsListTab({Key? key}) : super(key: key);

  @override
  State<RequestsListTab> createState() => RequestsListTabState();
}

class RequestsListTabState extends State<RequestsListTab> {
  List<MissionModel> requestsList = [];
  bool listLoading = true;
  String date = Jalali.now().year.toString() + "/" + Jalali.now().month.toString() + "/" + Jalali.now().day.toString();
  bool showStopButton = true;
  final TextEditingController _explainCtrl = TextEditingController();
  final FocusNode _explainFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    getRequestsList();
  }

  getRequestsList() async {
    requestsList.clear();
    var response = await (Services()).getMissionList("");
    if(response[0]["res"] == 1){
      setState(() {
        response.forEach((element){
          requestsList.add(MissionModel.fromJson(element));
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
        getRequestsList();
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
    return requestsList.isEmpty
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 30.sp),
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'لیست ماموریت ها',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                const Image(height: 30, image: AssetImage('assets/images/filter_icon.png')),
                                Padding(padding:
                                EdgeInsets.symmetric(horizontal: 4.sp)),
                                Text('فیلتر',
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: requestsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: (){
                            showDialogInMission(context, requestsList[index]);
                          },
                          // child: requestsListCardItems(context, requestsList, index, date)
                          child: viewMissionCardItems(
                            context,
                            requestsList,
                            index,
                            date,
                            (String id){sendStartMission(requestsList[index].id);},
                            (String id){sendEndMission(requestsList[index].id);},
                            showStopButton,
                            (String id, MissionModel missionModel){explainRecord(requestsList[index].id, requestsList[index]);},
                          )
                      );
                    }
                )
            ),
          ],
        )
    );
  }
}


