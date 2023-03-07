import 'package:Prismaa/main_tabbar.dart';
import 'package:Prismaa/screens/home_page/home_page.dart';
import 'package:Prismaa/screens/kartabl/kartabl.dart';
import 'package:Prismaa/screens/kartabl/mission/mission.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/morkhasi.dart';
import 'package:Prismaa/screens/kartabl/taradod/taradod.dart';
import 'package:Prismaa/screens/kartabl/task_management/task_management.dart';
import 'package:Prismaa/screens/login/confirm_login.dart';
import 'package:Prismaa/screens/login/login.dart';
import 'package:Prismaa/screens/mali/request_for_payment.dart';
import 'package:Prismaa/screens/mali/variz_bardasht_report.dart';
import 'package:Prismaa/screens/on_board/onboard.dart';
import 'package:Prismaa/screens/reset_password/reset_password.dart';
import 'package:Prismaa/screens/setting/notification/notifications.dart';
import 'package:Prismaa/screens/setting/support/support.dart';
import 'package:Prismaa/screens/setting/support/support_request.dart';
import 'package:Prismaa/screens/setting/user_account/change_password.dart';
import 'package:Prismaa/screens/setting/user_account/user_account.dart';
import 'package:Prismaa/services/localization_service.dart';
import 'package:Prismaa/test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926), // iphone 13 pro max (926 * 428)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return OverlaySupport.global(
          child: GetMaterialApp(
            title: 'Prismaa',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.grey,

                textTheme: TextTheme(
                  bodyText1: Theme.of(context).textTheme.bodyText1!
                      .copyWith(fontSize: 16.sp, fontFamily: "IranSans"), // تیتر های اپ بار

                  bodyText2: Theme.of(context).textTheme.bodyText2!
                      .copyWith(fontSize: 13.sp, fontFamily: "IranSans"), // هینت تکست ها

                ),

                fontFamily: 'IranSans'
            ),

            translations: LocalizationService(),
            locale: const Locale('fa', 'FA'),
            fallbackLocale: const Locale('fa', 'FA'),

            // home: const MainTabBar(),

            // initialRoute: "/test_page",

            routes: {
              "/" : (context) => const Onboard(),
              "/main_tab_bar" : (context) => const MainTabBar(),
              "/login" : (context) => const Login(),
              "/test_page" : (context) => ExampleApp(
                  lstPoint:
                  [
                       LatLng(31.3384904,48.67316),//(34.654375, 50.895237),
                       LatLng(31.3384453,48.6731774),//(34.654221, 50.895426),
                       LatLng(31.3384481,48.6731974),//(34.654373, 50.895701),
                       LatLng(31.3384553,48.6731974)//(34.654575, 50.895482),
              ]
              ),
              "/reset_password" : (context) => const ResetPassword(),
              "/confirm_login" : (context) => const ConfirmLogin(),
              "/home_page" : (context) => const HomePage(),
              "/setting_user_account" : (context) => const UserAccount(),
              "/change_password" : (context) => const ChangePassword(),
              "/setting_notification" : (context) => const Notifications(),
              "/setting_support" : (context) => const Support(),
              "/setting_support_request" : (context) => const SupportRequest(),
              "/kartabl_task_management" : (context) => const TaskManagement(),
              "/kartabl_morkhasi" : (context) => const Morkhasi(),
              "/kartabl_mission" : (context) => const Mission(),
              "/kartabl_taradod" : (context) => const Taradod(),
              "/mali_request_for_payment" : (context) => const RequestForPayment(),
              "/mali_v_b_report" : (context) => const VarizBardashtReport(),
              // "/todo_screen" : (context) => directionality(TodoScreen()),
            },
          ),
        );
      },
    );
  }
}

