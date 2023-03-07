import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/services/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => SettingState();
}

class SettingState extends State<Setting> {
  bool pageLoading = false;


  refresh() {
    setState(() {
      if(mounted){
        UserModel.name;
        UserModel.family;
        getProfilePic();
      }
    });
  }

  getProfilePic() async {
    setState(() => pageLoading = true);
    var response = await (Services()).getOtherPersonelItems(UserModel.mainToken);
    if(response[0]["res"] == 1){
      setState(() {
        UserModel.picPath = response[0]["pic_path"];
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
                color: Colors.white
            )),
        background: Colors.red,
      );
      setState(() => pageLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text("تنظیمات",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 26.sp,
                            ),
                          ),
                          Text("تنظیمات و پروفایل کاربری",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              // fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: Colors.black38
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 30.sp,
                        width: 28.sp,
                        child: Image.asset("assets/images/notification_kartabl.png", fit: BoxFit.fill),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
      ),

      body: pageLoading
      ? const Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0))
      :
      NestedScrollView(
        headerSliverBuilder: (context, value){
          return [
            SliverAppBar(
              floating: false,
              pinned: false,
              expandedHeight: MediaQuery.of(context).size.height.sp * 0.4,
              backgroundColor: Colors.white,
              centerTitle: false,
              stretch: true,
              leading: const SizedBox(),
              leadingWidth: 0,

              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0.sp),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // عکس پروفایل
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                // حاشیه سفید عکس پروفایل
                                Container(
                                  height: 150.sp,
                                  width: 150.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),

                                UserModel.picPath != ""
                                ?
                                CachedNetworkImage(
                                  imageUrl: UserModel.picPath,
                                  imageBuilder: (context, imageProvider) => Container(
                                    height: 135.sp,
                                    width: 135.sp,
                                    // padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                        image: NetworkImage(UserModel.picPath),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0)),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                )
                                :
                                // تصویر پروفایل
                                Container(
                                  height: 135.sp,
                                  width: 135.sp,
                                  // padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: const DecorationImage(
                                      image: AssetImage("assets/images/user_avatar.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.sp),
                            Text(UserModel.name + " " + UserModel.family,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.sp),
                            Text("کد پرسنلی : " + UserModel.userRoleId,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),


            ),
          ];
        },

        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.sp),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/setting_user_account").then((value) => refresh()),
                style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 24.sp)),
                child: itemsWidget("assets/images/frame.png", "پروفایل کاربری", false, false),
              ),
              const Divider(thickness: 0.6, indent: 60, endIndent: 20, color: Colors.black12, height: 0),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/setting_notification"),
                style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 24.sp)),
                child: itemsWidget("assets/images/notification2.png", "اطلاع رسانی", false, false),
              ),
              const Divider(thickness: 0.6, indent: 60, endIndent: 20, color: Colors.black12, height: 0),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/setting_support"),
                style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 24.sp)),
                child: itemsWidget("assets/images/headphone.png", "پشتیبانی", false, false),
              ),
              const Divider(thickness: 0.6, indent: 60, endIndent: 20, color: Colors.black12, height: 0),
              TextButton(
                onPressed: () {}, // Navigator.pushNamed(context, "/setting_notification"),
                style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 24.sp)),
                child: itemsWidget("assets/images/people.png", "درباره ما", false, false),
              ),
              const Divider(thickness: 0.6, indent: 60, endIndent: 20, color: Colors.black12, height: 0),
              TextButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, "/");
                  logOut();
                },
                style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 24.sp)),
                child: itemsWidget("assets/images/logout.png", "خروج", true, false),
              ),
            ],
          ),
        ),
      )


    );
  }



  Widget itemsWidget(String imageIcon, String text, bool textColor, bool notify){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const SizedBox(width: 10),
          SizedBox(
            width: 24.sp,
            height: 24.sp,
            child: Image.asset(imageIcon,
              fit: BoxFit.fill,
              color: textColor ? Colors.red : Colors.black
            ),
          ),
          const SizedBox(width: 20),
          Text(text,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: textColor ? Colors.red : Colors.black
            ),
          ),
          const Spacer(),
          notify
              ? Container(
            width: 35.sp,
            height: 18.sp,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFF4BB40),
            ),
            child: Center(
              child: Text("۲", style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.sp
              )
              ),
            ),
          )
              : const SizedBox(),
          SizedBox(
            width: 25.sp,
            height: 25.sp,
            child: Image.asset("assets/images/arrow-left.png", fit: BoxFit.fill, color: Colors.black),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
