import 'package:Prismaa/components/calculate_persian_week.dart';
import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/taradod_list_model.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/morkhasi.dart';
import 'package:Prismaa/screens/kartabl/taradod/widgets/taradod_filter_on_click.dart';
import 'package:Prismaa/screens/kartabl/taradod/widgets/tr_recorded_tasks.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class TaradodListTab extends StatefulWidget {
  const TaradodListTab({Key? key}) : super(key: key);

  @override
  State<TaradodListTab> createState() => TaradodListTabState();
}

class TaradodListTabState extends State<TaradodListTab> {
  bool listLoading = true;
  List<TaradodListModel> taradodList = [];
  List<Jalali> jWeekList = []; // یک هفته شمسی رو در خودش میریزه
  List<bool> selected = [];
  String date = Jalali.now().year.toString() + "/" + Jalali.now().month.toString() + "/" + Jalali.now().day.toString();
  Jalali jNow = Jalali.now();
  String idCompanySelected = UserModel.companies[0].id;

  bool startDateError = false;
  bool endDateError = false;
  final TextEditingController _startDateCtrl = TextEditingController();
  final TextEditingController _endDateCtrl = TextEditingController();
  bool buttonLoading = false;
  bool checkBox = false;
  Jalali weekDayInMorkhasiPage = Jalali.now(); // یه متغیر عمومی برای استفاده محتوای ویجت انتخاب تاریخ این صفحه
  int checkBoxInt = 0;


  @override
  void initState() {
    super.initState();
    getTaradodList(1, "", "", "", 0);
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
  void dispose() {
    _startDateCtrl.dispose();
    _endDateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // قسمت نمایش روز
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getToday(jNow),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),

                TextButton(
                  // گرد کردن لبه های انیمیشن افکت دکمه
                  style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0.sp),))
                  ),
                  onPressed: (){
                    taradodFilterOnClick(
                      context,
                      startDateError,
                      endDateError,
                      idCompanySelected,
                      _startDateCtrl,
                      _endDateCtrl,
                      buttonLoading,
                      checkBoxInt == 0 ? checkBox = false : checkBox = true,
                      (int checkBox){checkBoxInt = checkBox;},
                      (){getTaradodList(int.parse(idCompanySelected), _startDateCtrl.text, _endDateCtrl.text, "", checkBoxInt); Get.back();},
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 30.sp,
                        width: 30.sp,
                        child: Image.asset("assets/images/filter_icon.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                        child: Text("فیلتر",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  height: 80.sp,
                  width: 80.sp,
                  child: Image.asset("assets/images/pdf_excel.png"),
                ),
              ],
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
}
