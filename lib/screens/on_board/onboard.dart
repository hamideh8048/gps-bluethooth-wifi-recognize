import 'dart:async';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/on_board/widgets/back_picture_widget.dart';
import 'package:Prismaa/screens/on_board/widgets/welcome_text_widget.dart';
import 'package:Prismaa/services/services.dart';
import 'package:Prismaa/test_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => OnboardState();
}

class OnboardState extends State<Onboard> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;
  bool buttonLoading = false;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() => this.result = result);
    });

    internetSubscription = InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternet);
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    internetSubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: [
            // رنگ پس زمینه
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xff4091E7),
                      Color(0xff2046D0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                ),
            ),

            // عکس تصویر زمینه
            backPictureWidget(),

            // متن پایین صفحه
            welcomeTextWidget(context),

          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: () async {
              hasInternet = await InternetConnectionChecker().hasConnection;

              result = await Connectivity().checkConnectivity();

              final color = hasInternet ? Colors.green : Colors.red;
              final text = hasInternet ? "Internet" : "No Internet";

              // if(result == ConnectivityResult.mobile){
              //   showSimpleNotification(
              //     Text(text + ": Mobile Network"),
              //     background: color,
              //     position: NotificationPosition.bottom,
              //   );
              // } else if(result == ConnectivityResult.wifi){
              //   showSimpleNotification(
              //     Text(text + ": Wifi Network"),
              //     background: color,
              //     position: NotificationPosition.bottom,
              //   );
              // } else {
              if(result == ConnectivityResult.none) {
                showSimpleNotification(
                  Text(text + ": No Network",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white
                    )),
                  background: Colors.red,
                  // position: NotificationPosition.bottom,
                );
              } else {
                try {
                  setState(() {
                    buttonLoading = true;
                    checkLogin();
                  });
                }
                catch(e)
              {}
              }
              // }
            },
            child: Container(
              height: 70.sp,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40))
              ),
              child: Center(
                child: buttonLoading
                ?
                    const Center(child: SpinKitThreeBounce(color: Colors.black87, size: 25.0))
                :
                    Text("ورود به اپلیکیشن",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        //   color: Colors.white
                      ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  checkLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove("user.api_token");
    String? apiToken = prefs.getString("user.api_token");
    if(apiToken == null){
      // if(kIsWeb){
      //   context.vxNav.clearAndPush(Uri.parse("/main_tabbar"));
      // } else {
      navigationToLogin();
      buttonLoading = false;
      // }
    } else {
      UserModel.mainToken = apiToken;
      navigationToHome();
      buttonLoading = false;
      // await getUserInfo(apiToken);
    }
  }

  // getUserInfo(String token) async{
  //   var response = await (Services()).getUserInfo(token);
  //
  //   if (response["status"] == "success") {
  //     //
  //   } else if(response["status"] == "error"){
  //     navigationToHome();
  //     String? result = response['msg'];
  //     toast(result!, duration: Toast.LENGTH_SHORT);
  //   }
  // }

  navigationToLogin () {
    if(mounted) {
      Navigator.pushReplacementNamed(context, "/login");
      // context.vxNav.clearAndPush(Uri.parse("/main_tabbar"));
      // context.vxNav.clearAndPush(Uri.parse("/test_page"));
    }
  }

  navigationToHome(){
    if(mounted) {
      Navigator.pushReplacementNamed(context, "/main_tab_bar");
    }
  }

}
