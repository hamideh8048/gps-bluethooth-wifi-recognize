import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/notifications_model.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  List<NotificationModel> notificationList = [];
  bool pageLoading = true;

  @override
  void initState() {
    super.initState();
    getNotices();

  }

  getNotices() async {
    var response = await (Services()).getNotices();

    if(response[0]["res"] == 1){
    setState(() {
      response.forEach((element){
        notificationList.add(NotificationModel.fromJson(element));
      });
      pageLoading = false;
    });
    } else if(response[0]["res"] == -1){
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.white,
          )),
        background: Colors.red,
      );
      setState(() => pageLoading = false);
    }
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
                  Text("اطلاع رسانی ها",
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
          Container(
            height: 600,
            width: 400,
            padding: EdgeInsets.all(16.sp),
            child: ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (context, index){
                return cardItems(notificationList, index);
              }
            ),
          ),
    );
  }


  Widget cardItems(List<NotificationModel> notificationList, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.all(16.sp),
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
                    Text(notificationList[index].title,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.sp),
                    Text(notificationList[index].date,
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
                      color: notificationList[index].status == "در انتظار تائید" ? Colors.grey : notificationList[index].status == "تایید شده" ? Colors.green : Colors.red,
                      width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(30.sp),
                    color: notificationList[index].status == "در انتظار تائید" ? Colors.grey.withOpacity(0.1) : notificationList[index].status == "تایید شده" ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    // color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(notificationList[index].status,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 11.sp,
                        // color: cardItemModelList[index].colorButton,
                        color: notificationList[index].status == "در انتظار تائید" ? Colors.grey : notificationList[index].status == "تایید شده" ? Colors.green : Colors.red,
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
            child: Text(notificationList[index].explain,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13.sp,
                  color: Colors.black.withOpacity(0.8)
              ),
              softWrap: true,
            ),
          ),


          // در صورت عدم تایید شدن نمایش داده می شود
          if(notificationList[index].status == "عدم تائید")
            Divider(height: 30.sp, color: Colors.grey.withOpacity(0.5), thickness: 1.sp, indent: 16.sp, endIndent: 16.sp),

          if(notificationList[index].status == "عدم تائید")
            Padding(
              padding: EdgeInsets.only(left: 16.0.sp, right: 16.0.sp, bottom: 16.0.sp),
              child: Text(notificationList[index].reason,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 13.sp,
                    color: Colors.black.withOpacity(0.4)
                ),
                softWrap: true,
              ),
            ),

        ],
      ),
    );
  }
}
