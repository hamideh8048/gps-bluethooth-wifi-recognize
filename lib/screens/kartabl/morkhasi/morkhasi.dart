import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/get_persian_date.dart';
import 'package:Prismaa/models/company_list_model.dart';
import 'package:Prismaa/models/morkhasi_list_model.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/components/calculate_persian_week.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/requests_list_tab.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/widgets/morkhasi_record_view.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/widgets/mr_appbar_widget.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/widgets/roozane_widget.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/widgets/saati_widget.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shamsi_date/shamsi_date.dart';


class Morkhasi extends StatefulWidget {
  const Morkhasi({Key? key}) : super(key: key);
  @override
  State<Morkhasi> createState() => MorkhasiState();
}

Jalali weekDayInMorkhasiPage = Jalali.now(); // یه متغیر عمومی برای استفاده محتوای ویجت انتخاب تاریخ این صفحه

class MorkhasiState extends State<Morkhasi> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startHourCtrl = TextEditingController();
  final TextEditingController _startMinuteCtrl = TextEditingController();
  final TextEditingController _endHourCtrl = TextEditingController();
  final TextEditingController _endMinuteCtrl = TextEditingController();
  final TextEditingController _startDateCtrl = TextEditingController();
  final TextEditingController _endDateCtrl = TextEditingController();
  final TextEditingController _morkhasiDateController = TextEditingController();
  final TextEditingController _saatiExplainCtrl = TextEditingController();
  final TextEditingController _dayExplainCtrl = TextEditingController();
  final TextEditingController _specificDateCtrl = TextEditingController();
  bool buttonLoading = false;
  String idCompanySelected = UserModel.companies[0].id;
  bool switchTabs = true;
  List<MorkhasiListModel> morkhasiListModel = [];
  bool listLoading = true;
  Jalali jNow = Jalali.now();
  List<Jalali> jWeekList = []; // یک هفته شمسی رو در خودش میریزه
  List<bool> selected = [];
  String date = Jalali.now().year.toString() + "/" + Jalali.now().month.toString() + "/" + Jalali.now().day.toString();
  String? today;
  bool morkhasiKind = true;
  final _dateFormKey = GlobalKey<FormState>();
  final _roozaneFormKey = GlobalKey<FormState>();
  final DateTime _dateTime = DateTime.now();
  final _timeFormKey = GlobalKey<FormState>();
  bool startDateError = false;
  bool endDateError = false;
  bool buttonLoadingInRequest = false;


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

    getMorkhasiList(date);
    today = getToday(jNow);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _startHourCtrl.dispose();
    _startMinuteCtrl.dispose();
    _endHourCtrl.dispose();
    _endMinuteCtrl.dispose();
    _startDateCtrl.dispose();
    _endDateCtrl.dispose();
    _morkhasiDateController.dispose();
    _saatiExplainCtrl.dispose();
    _dayExplainCtrl.dispose();
    _specificDateCtrl.dispose();
    super.dispose();
  }

  String getToday(Date d) {
    final f = d.formatter;
    return '${f.d} ${f.mN}';
  }

  getMorkhasiList(String date) async {
    listLoading = true;
    morkhasiListModel.clear();
    var response = await (Services()).getMorkhasiList(date);
    if(response[0]["res"] == 1){
      setState(() {
        response.forEach((element){
          morkhasiListModel.add(MorkhasiListModel.fromJson(element));
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


  weekDayClick(){
    date = weekDayInMorkhasiPage.year.toString() + "/" + weekDayInMorkhasiPage.month.toString() + "/" + weekDayInMorkhasiPage.day.toString();
    getMorkhasiList(date);
    today = getToday(weekDayInMorkhasiPage);
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

      getMorkhasiList(jalaliToString);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: mrAppBarWidget(context),

      body: Column(
        children: [
          // تب های بالای صفحه
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // تب ثبت مرخصی
              GestureDetector(
                onTap: (){
                  setState(() {
                    switchTabs = true;
                  });
                },
                child: Column(
                  children: [
                    Text("ثبت مرخصی",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8.sp),
                    switchTabs
                    ?
                        Container(
                          width: 70.sp, height: 5.sp,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp), topRight: Radius.circular(10.sp))
                          ),
                        )
                    :
                        SizedBox(height: 5.sp),
                  ],
                ),
              ),

              // تب  لیست درخواست ها
              GestureDetector(
                onTap: (){
                  setState(() {
                    switchTabs = false;
                  });
                },
                child: Column(
                  children: [
                    Text("لیست درخواست ها",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8.sp),
                    switchTabs == false
                    ?
                        Container(
                          width: 70.sp, height: 5.sp,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp), topRight: Radius.circular(10.sp))
                          ),
                        )
                    :
                        SizedBox(height: 5.sp),
                  ],
                ),
              ),

            ],
          ),
          const Divider(color: Colors.black12, thickness: 0.8, height: 0,),

          switchTabs
            ?   morkhasiRecordView(context, morkhasiListModel, jWeekList, selected, (){weekDayClick();}, listLoading, _morkhasiDateController, (){chooseDateFunction();}, today!) // تب ثبت مرخصی
            : const RequestListTab()
        ],
      ),

      bottomNavigationBar: switchTabs
        ?
            SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 105.sp,
                color: const Color(0xFFFBFBFD),
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),
                // دکمه ثبت مرخصی
                child: GestureDetector(
                  onTap: (){
                    _dateController.text = weekDayInMorkhasiPage.year.toString() + "/" + weekDayInMorkhasiPage.month.toString() + "/" + weekDayInMorkhasiPage.day.toString();
                    morkhasiRecordButton();

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text("ثبت مرخصی",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
        :
            const SizedBox(height: 0),

    );
  }

  morkhasiRecordButton(){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (BuildContext context){
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return GestureDetector(
                onTap: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      color: backgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // شکل بالای صفحه
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                          SizedBox(height: 16.sp),

                          // عنوان مرخصی
                          Text("مرخصی",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 27.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // عنوان ثبت و مشاهده مرخصی و تاخیر
                          Text("ثبت و مشاهده مرخصی و تاخیر",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 11.sp,
                                color: Colors.black54
                            ),
                          ),
                          SizedBox(height: 30.sp),

                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 20.sp),
                                  // باکس انتخاب شرکت
                                  Material(
                                    color: backgroundColor,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                        ),
                                        labelText: "انتخاب شرکت ",
                                        labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
                                        hintText: "لطفا یک شرکت انتخاب کنید",
                                        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            fontSize: 14.sp,
                                            color: Colors.black26
                                        ),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                          borderSide: const BorderSide(color: Colors.black12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                          borderSide: const BorderSide(
                                              color: Colors.black12, width: 1.5),
                                        ),
                                        // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                                      ),
                                      icon: Icon(Icons.keyboard_arrow_down, size: 30.sp,),
                                      value: idCompanySelected,
                                      items: UserModel.companies.map((item) => DropdownMenuItem(
                                        value: item.id,
                                        child: Text(item.title, style: Theme.of(context).textTheme.bodyText1),
                                      )).toList(),
                                      onChanged: (String? item) {
                                        setState(() {
                                          idCompanySelected = item!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 50.sp),

                                  // دکمه های مرخصی روزانه و ساعتی
                                  Row(
                                    children: [
                                      // دکمه مرخصی روزانه
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () => setState(() {morkhasiKind = false;}),
                                          child: Container(
                                            height: 60.sp,
                                            decoration: BoxDecoration(
                                                color: backgroundColor,
                                                borderRadius: BorderRadius.circular(40),
                                                border: Border.all(
                                                    color: morkhasiKind == false ? Colors.blue : Colors.black.withOpacity(0.05))
                                            ),
                                            child: Center(
                                              child: Text("مرخصی روزانه",
                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20.sp),

                                      // دکمه مرخصی ساعتی
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () => setState(() {morkhasiKind = true;}),
                                          child: Container(
                                            height: 60.sp,
                                            decoration: BoxDecoration(
                                                color: backgroundColor,
                                                borderRadius: BorderRadius.circular(40),
                                                border: Border.all(
                                                    color: morkhasiKind ? Colors.blue : Colors.black.withOpacity(0.05))
                                            ),
                                            child: Center(
                                              child: Text("مرخصی ساعتی",
                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8.sp),

                                  morkhasiKind
                                      ?   saatiWidget(_dateController, _dateFormKey, _startMinuteCtrl, _startHourCtrl, _endMinuteCtrl, _endHourCtrl, buttonLoading, _dateTime, _timeFormKey, _saatiExplainCtrl)
                                      :   roozaneWidget(_startDateCtrl, _endDateCtrl, _roozaneFormKey, buttonLoading, _dayExplainCtrl)

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),


                    morkhasiKind
                    // دکمه ثبت مرخصی در ساعتی
                    ?
                    GestureDetector(
                      onTap: (){
                        hoursMorkhasiRecord();
                      },
                      child: Container(
                        height: 70.sp,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(40.sp),
                        ),
                        margin: EdgeInsets.only(left: 16.sp, right: 16.sp, bottom: 24.sp, top: 4.sp),
                        child: buttonLoading
                            ?   const Center(child: SpinKitThreeBounce(color: Colors.white60, size: 25.0))
                            :
                        Center(
                          child: Text("ثبت مرخصی",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    )

                :
                        // دکمه ثبت مرخصی در روزانه
                    GestureDetector(
                      onTap: (){
                        dayMorkhasiRecord();
                      },
                      child: Container(
                        height: 70.sp,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(40.sp),
                        ),
                        margin: EdgeInsets.only(left: 16.sp, right: 16.sp, bottom: 24.sp, top: 4.sp),
                        child: buttonLoading
                            ?   const Center(child: SpinKitThreeBounce(color: Colors.white60, size: 25.0))
                            :
                        Center(
                          child: Text("ثبت مرخصی",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          );
        }
    );
  }


  // ثبت مرخصی ساعتی
  hoursMorkhasiRecord() async {
    if(_dateFormKey.currentState!.validate()){
      if(_startHourCtrl.text.isNotEmpty && _startMinuteCtrl.text.isNotEmpty && _endHourCtrl.text.isNotEmpty && _endMinuteCtrl.text.isNotEmpty && _saatiExplainCtrl.text.isNotEmpty){
        setState(() => buttonLoading = true);
        String startTime = "";
        String endTime = "";

        if(_startHourCtrl.text != "" && _startMinuteCtrl.text != "") {
          startTime = _startHourCtrl.text + ":" + _startMinuteCtrl.text;
        }
        if(_endHourCtrl.text != "" && _endMinuteCtrl.text != "") {
          endTime = _endHourCtrl.text + ":" + _endMinuteCtrl.text;
        }

        var response = await (Services()).addHourseLeave(_dateController.text, startTime, endTime, idCompanySelected);
        if(response[0]["res"] == 1) {
          Navigator.of(context).pop();
          _dateController.clear();
          _startHourCtrl.clear();
          _startMinuteCtrl.clear();
          _endHourCtrl.clear();
          _endMinuteCtrl.clear();
          String result = response[0]['msg'];
          showSimpleNotification(
            Text(result,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white
              )),
            background: Colors.green,
          );
          setState(() {
            buttonLoading = false;
            getMorkhasiList(date);
          });
        } else if(response[0]["res"] == 0){
          String result = response[0]['msg'];
          showSimpleNotification(
            Text(result,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white
              )),
            background: Colors.red,
          );
          setState(() => buttonLoading = false);
        } else { // when it is -1
          Navigator.pushReplacementNamed(context, "/");
          setState(() => buttonLoading = false);
        }
      } else {
        showSimpleNotification(
          Text("همه موارد را می بایست پر کنید",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white
            ),
          ),
          background: Colors.red,
        );
      }
    }
  }


  // ثبت مرخصی روزانه
  dayMorkhasiRecord() async {
    if(_roozaneFormKey.currentState!.validate()){
      if(_startDateCtrl.text.isNotEmpty && _endDateCtrl.text.isNotEmpty && _dayExplainCtrl.text.isNotEmpty){
        setState(() => buttonLoading = true);

        var response = await (Services()).addDayLeave(_startDateCtrl.text, _endDateCtrl.text, idCompanySelected);
        if(response[0]["res"] == 1) {
          Navigator.of(context).pop();
          _startDateCtrl.clear();
          _endDateCtrl.clear();
          String result = response[0]['msg'];
          showSimpleNotification(
            Text(result,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white
                )),
            background: Colors.green,
          );
          setState(() => buttonLoading = false);
        } else if(response[0]["res"] == 0){
          String result = response[0]['msg'];
          showSimpleNotification(
            Text(result,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white
                )),
            background: Colors.red,
          );
          setState(() => buttonLoading = false);
        } else { // when it is -1
          Navigator.pushReplacementNamed(context, "/");
          setState(() => buttonLoading = false);
        }
      } else {
        showSimpleNotification(
          Text("همه موارد را می بایست پر کنید",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white
            ),
          ),
          background: Colors.red,
        );
      }

    }
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

