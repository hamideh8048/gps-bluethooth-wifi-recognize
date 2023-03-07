import 'package:Prismaa/components/calculate_persian_week.dart';
import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/taradod_list_model.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/morkhasi.dart';
import 'package:Prismaa/screens/kartabl/taradod/widgets/tr_recorded_tasks.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shamsi_date/shamsi_date.dart';

class ViewTaradodTab extends StatefulWidget {
  const ViewTaradodTab({Key? key}) : super(key: key);

  @override
  State<ViewTaradodTab> createState() => ViewTaradodTabState();
}

class ViewTaradodTabState extends State<ViewTaradodTab> {
  bool listLoading = true;
  List<TaradodListModel> taradodList = [];
  List<Jalali> jWeekList = []; // یک هفته شمسی رو در خودش میریزه
  List<bool> selected = [];
  String date = "";
  Jalali jNow = Jalali.now();


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
    date = Jalali.now().year.toString() + "/" + Jalali.now().month.toString() + "/" + Jalali.now().day.toString();
    jWeekList = calculatePersianWeek(jNow); // به طور پیش فرض امروز رو میریزه تو  فانکشن محاسبه یک هفته شمسی

    getTaradodList(1, "", "", date, 0);
  }


  getTaradodList(int companyId, String startDate, String endDate, String date, int imperfect) async {
    listLoading = true;
    taradodList.clear();
    var response = await (Services()).getTaradodList(companyId, startDate, endDate, date, imperfect);
    if(response[0]["res"] == 1){
      setState(() {
        response.forEach((element){
          taradodList.add(TaradodListModel.fromJson(element));
        });
        listLoading = false;
      });
    } else if(response[0]["res"] == -1){
      Navigator.pushReplacementNamed(context, "/login");
      setState(() => listLoading = false);
    } else {
      setState(() => listLoading = false);
    }
  }


  String getToday(Date d) {
    final f = d.formatter;
    return '${f.d} ${f.mN}';
  }



  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // قسمت نمایش روز
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 24.sp, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('امروز : ' + getToday(jNow),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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

          Divider(color: Colors.grey.withOpacity(0.3), height: 30.sp, thickness: 1.sp),

          listLoading
              ?
          const Expanded(child: Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0)))
              :
          taradodList.isEmpty
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
                itemCount: taradodList.length,
                itemBuilder: (context, index){
                  return trRecordedTasks(context, index, taradodList);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  weekDayClick(){
    date = weekDayInMorkhasiPage.year.toString() + "/" + weekDayInMorkhasiPage.month.toString() + "/" + weekDayInMorkhasiPage.day.toString();
    getTaradodList(1, "", "", date, 0);
  }
}
