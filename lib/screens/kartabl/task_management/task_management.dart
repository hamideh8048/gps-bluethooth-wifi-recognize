import 'package:Prismaa/components/calculate_persian_week.dart';
import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/get_persian_date.dart';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/task_management_model.dart';
import 'package:Prismaa/screens/home_page/widgets/hp_recorded_tasks.dart';
import 'package:Prismaa/screens/home_page/widgets/show_general_dialog_function.dart';
import 'package:Prismaa/screens/kartabl/task_management/widgets/ts_appbar_widget.dart';
import 'package:Prismaa/screens/kartabl/task_management/widgets/ts_recorded_tasks.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shamsi_date/shamsi_date.dart';

class TaskManagement extends StatefulWidget {
  const TaskManagement({Key? key}) : super(key: key);

  @override
  State<TaskManagement> createState() => TaskManagementState();
}

class TaskManagementState extends State<TaskManagement> {
  final TextEditingController _morkhasiDateController = TextEditingController();
  List<Jalali> jWeekList = []; // یک هفته شمسی رو در خودش میریزه
  List<bool> selected = [];
  Jalali weekDayInMorkhasiPage = Jalali.now(); // یه متغیر عمومی برای استفاده محتوای ویجت انتخاب تاریخ این صفحه
  String date = Jalali.now().year.toString() + "/" + Jalali.now().month.toString() + "/" + Jalali.now().day.toString();
  Jalali jNow = Jalali.now();
  bool listLoading = true;
  String recordedTasks = "0";
  String? today;
  List<TaskManagementModel> taskManagementList = [];
  bool  popUpLoading = true;
  TaskManagementModel? _taskManagementItem;


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
    getTaskManagementList(date);
    today = getToday(jNow);
  }

  getTaskManagementList(String date) async {
    listLoading = true;
    taskManagementList.clear();
    var response = await (Services()).getTaskManagementList(date);
    if(response[0]["res"] == 1){
      setState(() {
        response.forEach((element){
          taskManagementList.add(TaskManagementModel.fromJson(element));
        });
        listLoading = false;
      });
      recordedTasks = taskManagementList.length.toString();
    } else if(response[0]["res"] == -1){
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
      setState(() => listLoading = false);
    } else {
      recordedTasks = taskManagementList.length.toString();
      setState(() => listLoading = false);
    }
  }

  getDetailOfActivity(String id) async {
    final date = jNow.formatter;
    String today = date.yyyy + "/" + date.m + "/" + date.d;
    popUpLoading = true;
    var response = await (Services()).getDetailOfActivity(id, today);
    if(response[0]["res"] == 1){
      setState(() {
        _taskManagementItem = TaskManagementModel.fromJson(response[0]);
        popUpLoading = false;
      });
      showGeneralDialogFunction(context, _taskManagementItem!, popUpLoading);
    } else if(response[0]["res"] == -1){
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      setState(() => popUpLoading = false);
    }

  }

  @override
  void dispose() {
    _morkhasiDateController.dispose();
    super.dispose();
  }

  String getToday(Date d) {
    final f = d.formatter;
    return '${f.d} ${f.mN}';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: tsAppBarWidget(context),

      body: Container(
        color: const Color(0xFFFBFBFD),
        child: taskManagementWeekWidget(),
      ),
    );
  }

  Widget taskManagementWeekWidget(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // قسمت نمایش روز
          Padding(
            padding: EdgeInsets.only(left: 16.sp, right: 16.sp, top: 16.sp, bottom: 20.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // عنوان تاریخ امروز
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(today!,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(recordedTasks + " وظیفه ثبت شده",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              // fontWeight: FontWeight.bold,
                                color: Colors.black38,
                                fontSize: 15.sp
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // دکمه انتخاب تاریخ
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
                    today = getToday(jWeekList[index]);
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

          Divider(color: Colors.grey.withOpacity(0.3), height: 30.sp, thickness: 1.sp),

          // عنوان لیست وظایف و فیلتر
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("لیست وظایف",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Row(
                //   children: [
                //     SizedBox(
                //       height: 30.sp,
                //       width: 30.sp,
                //       child: Image.asset("assets/images/filter_icon.png"),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                //       child: Text("فیلتر",
                //         style: Theme.of(context).textTheme.bodyText1,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(height: 8.sp),


          listLoading
              ?
          const Expanded(child: Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0)))
              :
          taskManagementList.isEmpty
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
                itemCount: taskManagementList.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      getDetailOfActivity(taskManagementList[index].id!);
                    },
                    // child: tsRecordedTasks(context, index, taskManagementList)
                    child: hpRecordedTasks(context, index, taskManagementList)
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  chooseDateFunction(){
    String controllerText = _morkhasiDateController.text;
    List<String> splitedText = controllerText.split("/");
    Jalali stringToJalali = Jalali(int.parse(splitedText[0]), int.parse(splitedText[1]), int.parse(splitedText[2]));
    String jalaliToString = stringToJalali.year.toString() + "/" + stringToJalali.month.toString() + "/" + stringToJalali.day.toString();
    setState((){
      jWeekList = calculatePersianWeek(stringToJalali);

      selected.clear();
      int idx = stringToJalali.weekDay - 1;
      for(int i=0; i<7; i++){
        if(i == idx){
          selected.insert(i, true);
        } else {
          selected.insert(i, false);
        }
      }
      today = getToday(stringToJalali);

      getTaskManagementList(jalaliToString);
    });
  }

  weekDayClick(){
    date = weekDayInMorkhasiPage.year.toString() + "/" + weekDayInMorkhasiPage.month.toString() + "/" + weekDayInMorkhasiPage.day.toString();
    getTaskManagementList(date);
  }
}

Future<void> openGetDateDialog2(StateSetter setState2, BuildContext context, TextEditingController _controller, Function chooseDateFunction) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
            child: GetPersianDate(dateChangeListener: (String date) {
              setState2(() {
                _controller.text = date;
                chooseDateFunction();
              });
            })
        ),
      );
    },
  );
}
