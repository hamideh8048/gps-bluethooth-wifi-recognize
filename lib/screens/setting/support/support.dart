import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/support_model.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/setting/support/detail_of_items.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shamsi_date/shamsi_date.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => SupportState();
}

class SupportState extends State<Support> {
  List<SupportModel> supportItemsList = [];
  bool pageLoading = true;


  @override
  void initState() {
    super.initState();
    getSupportItems();
  }

  getSupportItems() async {
    var response = await (Services()).getSupportItems(UserModel.mainToken);

    supportItemsList.clear();
    if(response[0]["res"] == 1){
      setState(() {
        response.forEach((element){
          supportItemsList.add(SupportModel.fromJson(element));
        });
        pageLoading = false;
      });
    } else if(response[0]["res"] == -1){
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result, style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
            )),
        background: Colors.red,
      );
      setState(() => pageLoading = false);
    }
  }

  backAction(){
    setState(() {
      getSupportItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                        height: 45.sp,
                        width: 45.sp,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black87),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset("assets/images/arrow_back.png")
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text("پشتیبانی",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.sp,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 30.sp,
                    width: 28.sp,
                    child: Image.asset("assets/images/notification_kartabl.png", fit: BoxFit.fill),
                  )
                ],
              ),
            ),
          )
      ),

      body: pageLoading
      ?   const Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0))
      :
          supportItemsList.isEmpty
          ?
              Center(
                child: Text("آیتمی برای نمایش وجود ندارد",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
              )
          :
              Padding(
                padding: EdgeInsets.all(16.sp),
                child: ListView.builder(
                    itemCount: supportItemsList.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOfItems(supportItemsList, index))).then((value) {backAction();});
                        },
                        child: cardItems(supportItemsList, index)
                      );
                    }
                ),
              ),

      bottomNavigationBar: pageLoading
      ?   SizedBox(height: 105.sp)
      :
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 105.sp,
              color: const Color(0xFFFBFBFD),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),

              // دکمه ثبت مرخصی
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, "/setting_support_request").then((value) {backAction();});
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text("درخواست پشتیبانی",
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
          ),
    );
  }


  Widget cardItems(List<SupportModel> supportItemsList, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 0.8),
        borderRadius: BorderRadius.circular(15.sp),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عناوین بالای کارد
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.only(topRight: Radius.circular(15.sp), topLeft: Radius.circular(15.sp))
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // عنوان و تاریخ
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(supportItemsList[index].subject,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.sp),
                    Text(supportItemsList[index].date,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14.sp,
                          color: Colors.black.withOpacity(0.7)
                      ),
                    ),
                  ],
                ),

                // وضعیت انتظار
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 6.sp),
                  decoration: BoxDecoration(
                    // border: Border.all(color: cardItemModelList[index].colorButton!, width: 0.5),
                    border: Border.all(
                      color: supportItemsList[index].status == "در انتظار پاسخ" ? Colors.grey : supportItemsList[index].status == "پاسخ داده شده" ? Colors.green : Colors.red,
                      width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(30.sp),
                    color: supportItemsList[index].status == "در انتظار پاسخ" ? Colors.grey.withOpacity(0.1) : supportItemsList[index].status == "پاسخ داده شده" ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(supportItemsList[index].status,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 11.sp,
                        color: supportItemsList[index].status == "در انتظار پاسخ" ? Colors.grey : supportItemsList[index].status == "پاسخ داده شده" ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 12.sp),

          // متن درون کارد
          Padding(
            padding: EdgeInsets.only(left: 16.0.sp, right: 16.0.sp, top: 8.0.sp, bottom: 16.0.sp),
            child: Text(supportItemsList[index].messages.first.message,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13.sp,
                  color: Colors.black.withOpacity(0.8)
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

}


// String dateCalc(Jalali? date){
//   String dateCalc = date!.year.toString() + "/" + date.month.toString() + "/" + date.day.toString();
//   String timeCalc = date.hour.toString() + ":" + date.minute.toString();
//   return timeCalc + " - " + dateCalc;
// }
