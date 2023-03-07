import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/morkhasi_list_model.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/widgets/morkhasi_filter_on_click.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shamsi_date/shamsi_date.dart';

class RequestListTab extends StatefulWidget {
  const RequestListTab({Key? key}) : super(key: key);

  @override
  State<RequestListTab> createState() => RequestListTabState();
}

class RequestListTabState extends State<RequestListTab> {
  List<MorkhasiListModel> morkhasiListModel = [];
  bool listLoading = true;
  bool startDateError = false;
  bool endDateError = false;
  String idCompanySelected = UserModel.companies[0].id;
  final TextEditingController _specificDateCtrl = TextEditingController();
  bool buttonLoading = false;
  // String date = Jalali.now().year.toString() + "/" + Jalali.now().month.toString() + "/" + Jalali.now().day.toString();
  String date = "";


  @override
  void initState() {
    super.initState();
    getMorkhasiList(date);
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

  // showDetail(String id, String date) async {
  //   listLoading = true;
  //   morkhasiListModel.clear();
  //
  //   var response = await (Services()).getMorkhasiList(date);
  //
  //   if(response[0]["res"] == 1){
  //     setState(() {
  //       Get.back();
  //       response.forEach((element){
  //         morkhasiListModel.add(MorkhasiListModel.fromJson(element));
  //       });
  //       listLoading = false;
  //     });
  //   } else if(response[0]["res"] == -1){
  //     Navigator.pushReplacementNamed(context, "/login");
  //     setState(() => listLoading = false);
  //   } else {
  //     setState(() => listLoading = false);
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return morkhasiListModel.isEmpty
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
        child: Container(
          padding: EdgeInsets.all(16.sp),
          // color: const Color(0xFFFBFBFD),
          child: Column(
            children: [
              // عنوان لیست مرخصی و فیلتر
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("لیست مرخصی ها",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // دکمه فیلتر
                  GestureDetector(
                    onTap: (){
                      morkhasiFilterOnClick(
                        context,
                        startDateError,
                        endDateError,
                        idCompanySelected,
                        _specificDateCtrl,
                        buttonLoading,
                        (){getMorkhasiList(_specificDateCtrl.text); Get.back();},
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
                ],
              ),
              SizedBox(height: 8.sp),

              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: morkhasiListModel.length,
                    itemBuilder: (context, index){
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          // height: 170,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          // padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.2), width: 0.3),
                            borderRadius: BorderRadius.circular(20),
                            color: backgroundColor,
                          ),

                          child: Column(
                            children: [
                              // عنوان نام شرکت و آدرس
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 70.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    border: Border.all(color: Colors.black.withOpacity(0.2), width: 0.1),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 2.sp),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 6.sp),
                                      Text("نام شرکت : " + morkhasiListModel[index].companyName!,
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          fontSize: 13.sp,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      SizedBox(height: 4.sp),
                                      Text("آدرس : " + morkhasiListModel[index].companyAddress!,
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          fontSize: 13.sp,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  )
                              ),

                              Container(
                                padding: EdgeInsets.all(16.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: backgroundColor,
                                ),
                                child: Column(
                                  children: [
                                    // نوع مرخصی
                                    Row(
                                      children: [
                                        Container(
                                          width: 18.sp, height: 18.sp,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/images/copy-success.png"),
                                                fit: BoxFit.cover,
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 8.sp),
                                        Text("نوع مرخصی : " + morkhasiListModel[index].type!,
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            fontSize: 13,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8.sp),
                                    // ساعت شروع و  پایان
                                    Row(
                                      children: [
                                        Container(
                                          width: 18.sp, height: 18.sp,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/images/clock.png"),
                                                fit: BoxFit.cover,
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 8.sp),
                                        morkhasiListModel[index].type == "ساعتی"
                                            ?
                                        Text("ساعت شروع : " + morkhasiListModel[index].startTime!,
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            fontSize: 13,
                                          ),
                                        )
                                            :
                                        Text("تاریخ شروع : " + morkhasiListModel[index].startDate!,
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(width: 16.sp),
                                        morkhasiListModel[index].type == "ساعتی"
                                            ?
                                        Text("ساعت پایان : " + morkhasiListModel[index].endTime!,
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            fontSize: 13,
                                          ),
                                        )
                                            :
                                        Text("تاریخ پایان : " + morkhasiListModel[index].endDate!,
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12.sp),
                                    // زمان ثبت مرخصی
                                    Row(
                                      children: [
                                        morkhasiListModel[index].type == "ساعتی"
                                            ?
                                        Text(" زمان ثبت مرخصی : " + morkhasiListModel[index].startDate!,
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            fontSize: 13,
                                          ),
                                        )
                                            :   const SizedBox(),
                                        const Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 3.sp, horizontal: 8.sp),
                                          decoration: BoxDecoration(
                                              color: morkhasiListModel[index].status == 1 ? Colors.green.withOpacity(0.2) : morkhasiListModel[index].status == 2 ? Colors.red.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(20.sp),
                                              border: Border.all(color: morkhasiListModel[index].status == 1 ? Colors.green : morkhasiListModel[index].status == 2 ? Colors.red : Colors.grey)
                                          ),
                                          child: Center(
                                            child: Text(morkhasiListModel[index].status == 1 ? "تایید شده" : morkhasiListModel[index].status == 2 ? "رد شده" : "در انتظار تایید",
                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                  fontSize: 12.sp,
                                                  color: morkhasiListModel[index].status == 1 ? Colors.green : morkhasiListModel[index].status == 2 ? Colors.red : Colors.grey
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                    morkhasiListModel[index].status == 2
                                        ? Divider(color: Colors.grey.withOpacity(0.3), height: 24.sp, thickness: 0.5,)
                                        : const SizedBox(height: 0),

                                    morkhasiListModel[index].status == 2
                                        ?
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("دلیل رد شدن درخواست : ",
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            color: Colors.red,
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.55,
                                          child: Text(morkhasiListModel[index].rejectReason!,
                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                              fontSize: 11,
                                            ),
                                            softWrap: true,
                                            // maxLines: 3,
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    )
                                        :
                                    const SizedBox(height: 0),
                                  ],
                                ),
                              )
                            ],
                          )
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
