import 'dart:async';

 import 'package:network_info_plus/network_info_plus.dart';
import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/company_list_model.dart';
import 'package:Prismaa/models/current_shift_model.dart';
import 'package:Prismaa/models/task_management_model.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/home_page/widgets/appbar_widget.dart';
import 'package:Prismaa/screens/home_page/widgets/enter_app.dart';
import 'package:Prismaa/screens/home_page/widgets/hp_recorded_tasks.dart';
import 'package:Prismaa/screens/home_page/widgets/position_box_widget.dart';
import 'package:Prismaa/screens/home_page/widgets/remaining_time_widget.dart';
import 'package:Prismaa/screens/home_page/widgets/shimmer_screen.dart';
import 'package:Prismaa/screens/home_page/widgets/show_general_dialog_function.dart';
import 'package:Prismaa/screens/home_page/widgets/traffic_widget.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:poly_geofence_service/errors/error_codes.dart';
import 'package:poly_geofence_service/models/lat_lng.dart';
import 'package:poly_geofence_service/models/poly_geofence.dart';
import 'package:poly_geofence_service/models/poly_geofence_status.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart';
import 'package:shamsi_date/shamsi_date.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool beforEnter=true;//قبل از اینکه ورود یا خروج ثبت شده باشد
  static List<LatLng> lstPoint=[];
  final _streamController = StreamController<PolyGeofence>();
  final formKey = GlobalKey<FormState>();
  List<TaskManagementModel> taskManagementList = [];
  TaskManagementModel? _taskManagementItem;
  List<CurrentShiftModel> currentShiftList = [];
  bool pageLoading = true;
  bool isDialogOpen = false;
  bool  popUpLoading = true;
  double? listHeight;
  String? recordedTasks;
  // List<CurrentActivityModel> currentActivity = [];
  CountdownTimerController? controller; // مربوط به شمارش معکوس دایره وسط
  int? endTime;
  String endOfJob = "23:59:00";
  // double? progress; // محاسبه مقدار ثانیه برای کم شدن دایره تایم
  // Timer? timer;
  Jalali jNow = Jalali.now();
  String deviceName="";
  String nameOfUser = "";
  String today = "";
 //final info = NetworkInfo();
  bool swch = false;
  bool NotfoundDevice=false;
  bool isAllowed = false;
  var dt = DateTime.now();
  //FlutterBluePlus?  flutterBlue;//=FlutterBluePlus .instance;
  @override
  void initState() {
    super.initState();

    if(mounted){
      getCurrentActivity();
    }
    print(UserModel.mainToken);
  }

  @override
  void dispose() {
    super.dispose();
    if(controller!=null)
    controller!.dispose();
  }
  CallBackExit()
  {

    if(UserModel.currentShiftModel!=null&&UserModel.currentShiftModel!.presenceType==2) {
      if (UserModel.currentShiftModel != null &&
          UserModel.currentShiftModel!.deviceType == "bluetooth")

      getBluethooseInfo();
      else if (UserModel.currentShiftModel != null &&
          UserModel.currentShiftModel!.deviceType == "wifi")
        getwifiInfo();
      else if (UserModel.currentShiftModel != null &&
          UserModel.currentShiftModel!.deviceType == "gps")
        gps();
    // setState(() {
    //   // Here you can write your code for open new view
    // })
  }
  //
  }

  showMessage(String msg,Color color,int duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        duration:  Duration(seconds: duration),
      ),
    );
  }
  gps()
  {
    // if(UserModel.currentShiftModel!=null  && UserModel.currentShiftModel!.presenceType==1 && UserModel.currentShiftModel!.scop.length>0)
    //   {
    //   UserModel.currentShiftModel!.scop.forEach((item) {
    //   lstPoint!.add(LatLng(double.parse( item.lat),double.parse( item.long)),);
    // });

    final _polyGeofenceService = PolyGeofenceService.instance.setup(
        interval: 5000,
        accuracy: 200,
        loiteringDelayMs: 60000,
        statusChangeDelayMs: 10000,
        allowMockLocations: false,
        printDevLog: false
    );
    final _polyGeofenceList = <PolyGeofence>[
      PolyGeofence(
          id: 'This is the ID',
          data: {
            'address': 'Address',
            'about': 'About',
          },
          polygon: lstPoint!
      ),
    ];

    //WidgetsBinding.instance.addPostFrameCallback((_) {
      _polyGeofenceService.addPolyGeofenceStatusChangeListener(_onPolyGeofenceStatusChanged);
      _polyGeofenceService.addLocationChangeListener(_onLocationChanged);
      _polyGeofenceService.addLocationServicesStatusChangeListener(_onLocationServicesStatusChanged);
      _polyGeofenceService.addStreamErrorListener(_onError);
      _polyGeofenceService.start(_polyGeofenceList).catchError(_onError);
   // });
        showMessage('در حال جستجوی جی پی اس', buttonGreenColor, 15);
  //}
  }
  Future<void> _onPolyGeofenceStatusChanged(
      PolyGeofence polyGeofence,
      PolyGeofenceStatus polyGeofenceStatus,
      Location location) async {
    print('polyGeofence: ${polyGeofence.toJson()}');
    print('polyGeofenceStatus: ${polyGeofenceStatus.toString()}');

    _streamController.sink.add(polyGeofence);
    if(UserModel.currentShiftModel!=null && !isDialogOpen){
      isDialogOpen=true;
    openEnterModal("gps");
    // _streamController.close();

    showMessage('polyGeofence: ${polyGeofence.toJson()}', buttonGreenColor, 15);
    }
  }
  // This function is to be called when the location has changed.
  int index=0;
  void _onLocationChanged(Location location) {
   index=1+ index;
    if(index<4)
    showMessage('location: ${location.toJson()}', Colors.orange, 10);
    print('location: ${location.toJson()}');
  }

  // This function is to be called when a location services status change occurs
  // since the service was started.
  void _onLocationServicesStatusChanged(bool status) {
    print('isLocationServicesEnabled: $status');
  }

  // This function is used to handle errors that occur in the service.
  void _onError(error) {
    final errorCode = getErrorCodesFromError(error);
   if (errorCode != null) {
     showMessage('error: $error', redColor, 15);
   }else
    if (errorCode == null) {
      print('Undefined error: $error');
      showMessage('Undefined error: $error', redColor, 5);
      return;
    }

    print('ErrorCode: $errorCode');
  }

  getCurrentActivity() async {

    pageLoading = true;
    today = getToday(jNow);
    taskManagementList.clear();

      getCurrentShift();
     // gps();
      //getBluethooseInfo();
//       Future.delayed(const Duration(seconds: 1), () {
// //
// // // Here you can write your code
//         if(UserModel.currentShiftModel!=null&&UserModel.currentShiftModel!.presenceType==1) {
//           if (UserModel.currentShiftModel != null &&
//               UserModel.currentShiftModel!.deviceType == "bluetooth")
//             gps(); ///getBluethooseInfo();
//           else if (UserModel.currentShiftModel != null &&
//               UserModel.currentShiftModel!.deviceType == "wifi")
//             getwifiInfo();
//
//           setState(() {
//             // Here you can write your code for open new view
//           });
//         }
//    });

//hamide
 //  setState(() => pageLoading = false);
    } else if(response[0]["res"] == -1){
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      recordedTasks="0";
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

  getCurrentShift() async {

    var response
    if(response[0]["res"] == 1){
   setState(() {
        response[0]['company_list'].forEach((element){
          UserModel.companies.add(CompanyListModel.fromJson(element));
        });
        if(response[0]['current_shift']!=null &&response[0]['current_shift'].length>0) {
          UserModel.currentShiftModel =
              CurrentShiftModel.fromJson(response[0]['current_shift'][0]);
          UserModel.currentShiftModel!.presenceType =
          response[0]['presence_type'];
          if( UserModel.currentShiftModel!.deviceType.contains("blue"))
          {deviceName="بلوتوث";}
          else if(UserModel.currentShiftModel!.deviceType.contains("wifi"))
          {deviceName="وای فای";}
          else if (UserModel.currentShiftModel!.deviceType.contains("gps"))
          {deviceName="جی پی اس";}
          if(UserModel.currentShiftModel!=null  &&  UserModel.currentShiftModel!.scop.length>0)
            {
            UserModel.currentShiftModel!.scop.forEach((item) {
            lstPoint!.add(LatLng(double.parse( item.lat),double.parse( item.long)),);
          });
          //     lstPoint =<LatLng>[
          //       const LatLng(31.3384562,48.673162),//(34.654375, 50.895237),
          //       const LatLng(31.3384453,48.6731774),//(34.654221, 50.895426),
          //       const LatLng(31.3385644,48.6731512),//(34.654373, 50.895701),
          //       const LatLng(31.3384558,48.673162)//(34.654575, 50.895482),
          //     ];
            }

          if (UserModel.currentShiftModel != null &&
              UserModel.currentShiftModel!.presenceType == 2)
            beforEnter = false;
        else  if (UserModel.currentShiftModel != null &&
              ( UserModel.currentShiftModel!.presenceType == 1|| UserModel.currentShiftModel!.presenceType == 0))
            beforEnter = true;

        }
        else{
          pageLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("خطا!ورود خارج از شیفت کاری تعریف شده امکان پذیر نیست"),
              duration: const Duration(seconds: 2),
            ),
          );
        }
        if (UserModel.currentShiftModel != null &&
            UserModel.currentShiftModel!
                .shiftExitHourse
                .trim()
                .length > 0)
          endOfJob = UserModel.currentShiftModel!.shiftExitHourse;
        endTime = DateTime
            .now()
            .millisecondsSinceEpoch + 1000 * calculateEndTimeOfJob(endOfJob);
        controller = CountdownTimerController(endTime: endTime!);
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


  getwifiInfo()async
  {
    String type="";
    String name="";
    if(UserModel.currentShiftModel!=null)
      type=UserModel.currentShiftModel!.deviceCode;
    if(type.contains("blue"))
    {name="بلوتوث";}
    else if(type.contains("wifi"))
    {name="وای فای";}
    else if (type.contains("gps"))
    {name="جی پی اس";}
    setState(() {
      NotfoundDevice = true;
    });
   final info = NetworkInfo();
    // final wifiName = await info.getWifiName(); // "FooNetwork"
    // final wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    final wifiIP = await info.getWifiIP(); // 192.168.1.43
  // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
  //   final wifiIPv6 = await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
  //   final wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
  //   final wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
  //   final wifiGateway = await info.getWifiGatewayIP();
 //if(UserModel.currentShiftModel!=null&&wifiIP.toString().contains(UserModel.currentShiftModel!.deviceAddress)) {
   if(true) {
     print('wifiIP${wifiIP} success');
     showMessage('wifiIP${wifiIP}', buttonGreenColor, 15);

     setState(() {
       NotfoundDevice = false;
     });

     // setState(() => pageLoading = false);

     Future.delayed(Duration.zero, () async {
       showDialog(
           context: context,
           builder: (context) {
             return
               Dialog(
                   backgroundColor: Colors.transparent,
                   insetPadding: EdgeInsets.all(10),
                   child:
                   Center(child:
                   EnterApp(
                     isEnter: true,
                     deviceType: "نوع ثبت : ${name}",
                     subtitle: "${dt.hour}:${dt.minute}",
                     token: UserModel.mainToken,
                     hasDelay: false,)
                   )
               );
           })
           .then((valueFromDialog) {
         setState(() {


         });
       });
       // use the value as you wish

     });
     // showMessage(msg, buttonGreenColor, 3);
   }
  }

  openEnterModal(String type){

  Future.delayed(Duration.zero, () async {
  showDialog(
  context: context,
  builder: (context) {
  return
  Dialog(
  backgroundColor: Colors.transparent,
  insetPadding: EdgeInsets.all(10),
  child:
  Center(child:
  EnterApp(
  isEnter: UserModel.currentShiftModel!.presenceType==1?true:false,
  deviceType: " نوع ثبت :  ${deviceName}",
  subtitle: "${dt.hour}:${dt.minute}",
  token: UserModel.mainToken,
  hasDelay: false,)
  )
  );
  })
      .then((valueFromDialog) {
  setState(() {


  });
  });
// use the value as you wish

});
}

  getBluethooseInfo() async {
    try {
      String msg="Mac from db : ${UserModel.currentShiftModel!.deviceAddress} ,name: ${UserModel.currentShiftModel!.deviceCode}\n";
      FlutterBluePlus?  flutterBlue= FlutterBluePlus.instance;
      Timer _timer = new Timer(const Duration(seconds:11), () {
        if(  NotfoundDevice == true) {
          showMessage(msg, redColor, 15);
          flutterBlue?.stopScan();
          setState(() {
            pageLoading=false;
            NotfoundDevice = false;
          });
        }
      });

     // flutterBlue!.startScan(timeout: Duration(seconds: 10));

     if(await flutterBlue!.isOn)
       {
        // flutterBlue!.startScan();//(timeout: Duration(seconds: 10));
         //flutterBlue!.startScan(timeout: Duration(seconds: 8));
         flutterBlue!.startScan(timeout: Duration(seconds: 8));

         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content: Text("در حال جستجوی بلوتوث"),
               backgroundColor: buttonGreenColor,
             duration: const Duration(seconds: 2),
           ),
         );
         flutterBlue.connectedDevices
             .asStream()
             .listen((List<BluetoothDevice> devices) {
           for (BluetoothDevice device in devices) {
            String h="";
           }});
         var subscription2 = flutterBlue?.scanResults.listen((results) async {
           setState(() {
             NotfoundDevice = true;
           });
           // do something with scan results
           for (ScanResult r in results) {
             print('${r.device.name} found! rssi: ${r.rssi}');

             msg+='Scan result mac: ${r.device.id},name:${r.device.name}  , type: ${r.device.type==null?"":r.device.type.name}\n ';

             if(UserModel.currentShiftModel!=null && UserModel.currentShiftModel!.deviceAddress!=null &&UserModel.currentShiftModel!.deviceAddress.length>6)
         if(r.device.id.toString().contains(UserModel.currentShiftModel!.deviceAddress)) {
       // if(r.device.id.toString().contains("08:78:08:0A:48:97")) {

              print('${r.device.name} success');
               r.device.connect();

               setState(() {
                 NotfoundDevice = false;
               });
              flutterBlue?.stopScan();
               // setState(() => pageLoading = false);

               Future.delayed(Duration.zero, () async {
                 showDialog(
                     context: context,
                     builder: (context) {
                       return
                         Dialog(
                             backgroundColor: Colors.transparent,
                             insetPadding: EdgeInsets.all(10),
                             child:
                             Center(child:
                             EnterApp(
                               isEnter:UserModel.currentShiftModel!.presenceType==1? true:false,
                               deviceType: "نوع ثبت : ${deviceName}",
                               subtitle: "${dt.hour}:${dt.minute}",
                               token: UserModel.mainToken,
                               hasDelay: false,)
                             )
                         );
                     })
                     .then((valueFromDialog) {
                   setState(() {
                     pageLoading=false;
    });
                 });
                 // use the value as you wish

               });
             // showMessage(msg, buttonGreenColor, 3);
             }}},
             onDone: () async{
               // Scan is finished ****************

               await flutterBlue!.stopScan();

               print("Task Done");
               if(NotfoundDevice==true)
               {
                 print("error in finding bluethooth");
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: Text("خطا در پیدا کردن بلوتوث"),
                     duration: const Duration(seconds: 2),
                   ),
                 );
               }
               setState(() {
                 NotfoundDevice = false;
               });


             }
             , onError: (Object e) {
                flutterBlue!.stopScan();
               setState(() {
                 NotfoundDevice = false;
               });
               print("Some Error "  + e.toString());
             });

       }
   else
     {    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text("خطا بلوتوث خاموش است"),
         duration: const Duration(seconds: 2),
       ),
     );}
// Stop scanning


    }
    catch(e)
    {
      String f=e.toString();
    }
  }


  String getToday(Date d) {
    final f = d.formatter;
    return '${f.yyyy}/${f.mm}/${f.d}';
  }

  String getToday2(Date d) {
    final f = d.formatter;
    return '${f.d} ${f.mN} ${f.yyyy}';
  }

  // فانکشن محاسبه زمان باقی مانده تا پایان کار
  int calculateEndTimeOfJob(String endOfJob) {
if(endOfJob.split(":").length==2)
  endOfJob=endOfJob+":00";
    var time = DateFormat('HH:mm:s').parse(endOfJob);
    int timeStampDate = time.millisecondsSinceEpoch;
    DateTime a = DateTime.fromMillisecondsSinceEpoch(timeStampDate);
    DateTime serverTime = DateTime(2020,01,01,a.hour,a.minute,a.second);

    int time2 = DateTime.now().millisecondsSinceEpoch;
    DateTime b = DateTime.fromMillisecondsSinceEpoch(time2);
    DateTime currentTime = DateTime(2020,01,01,b.hour,b.minute,b.second);

    return serverTime.difference(currentTime).inSeconds;
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacementNamed(context, "/test_page");
         // Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage()));
        },
      ),
      extendBody: true,
      backgroundColor: backgroundColor,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(24.sp),
        child: AppBar(
          backgroundColor: const Color(0xFF2B2E34),
          elevation: 0,
          leadingWidth: 0,
          leading: const SizedBox(),
        ),
      ),

      //body:foundDevice==true?LoadingIndicator(text: 'waiting'): pageLoading//CircularProgressIndicator
      body:NotfoundDevice==true?ShimmerScreen(): pageLoading
        ?  ShimmerScreen()
        : Stack(
    children: [
    //  EnterApp(key: formKey,title: "شما در حال ورود به پردازشگران پرتو  می باشید  ", isEnter: true,deviceType: "blue",subtitle: "ورود : 8:30 قبل از ظهر")
   // تصویر بک گراند
   //   hamide
    SizedBox(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Image.asset("assets/images/home_page_background.png", fit: BoxFit.fill),
    ),

    SizedBox(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    // padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    appBarWidget(nameOfUser, context, jNow),
    SizedBox(height: 0.sp),
      beforEnter? Padding(padding:EdgeInsets.symmetric(horizontal: 30),child:
    Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TrafficWidget(text: "تردد دستی",imgUrl: "assets/images/traffic.png",callback:  () => {
    isDialogOpen=false,
        if(UserModel.currentShiftModel!=null&&UserModel.currentShiftModel!.presenceType==1) {
          if (UserModel.currentShiftModel != null &&
              UserModel.currentShiftModel!.deviceType == "bluetooth")
         getBluethooseInfo()

          else if (UserModel.currentShiftModel != null &&
              UserModel.currentShiftModel!.deviceType == "wifi")
            getwifiInfo()
    else if (UserModel.currentShiftModel != null &&
    UserModel.currentShiftModel!.deviceType == "gps")
    gps(),
          // setState(() {
          //   // Here you can write your code for open new view
          // })
        }
            },enable: NotfoundDevice),
            TrafficWidget(text: "تردد با qr",imgUrl: "assets/images/barcode.png",callback:  () => {
            Navigator.pop(context)
            },enable: NotfoundDevice,)
          ])):

    // دایره وسط، تایم باقی مانده تا پایان کار

  RemainingTimeWidget(context: context, controller:  controller!,isEnter: true,type:UserModel.currentShiftModel==null?"":  UserModel.currentShiftModel!.deviceType,point: lstPoint,callback:  () => {  CallBackExit()}),

    SizedBox(height: 40.sp),

    // آدرس به پایین
    Expanded(
    child: SingleChildScrollView(
    child: Column(
    children: [
    //SizedBox(height: 30.sp),
      beforEnter?
    Text(  "ورود بلوتوث و وایرلس اتومات اتفاق خواهد افتاد",
    style: Theme.of(context).textTheme.bodyText1!.copyWith(
     fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 15.sp
    )):Container(),
      beforEnter?SizedBox(height: 50,):Container(),
      // باکس آدرس
  ! beforEnter? Container(
    width: MediaQuery.of(context).size.width,
    height: 40.sp,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
    color: const Color(0xFFF9F9F9),
    borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
    children: [
    const SizedBox(width: 10),
    SizedBox(
    width: 20,
    height: 20,
    child: Image.asset("assets/images/location2.png", fit: BoxFit.fill),
    ),
    const SizedBox(width: 6),

    ],
    )
    ):Container(),
    const SizedBox(height: 16),

    // طراحی ویجت سمت کارمندان
    !beforEnter? null:Container(),

    // عنوان تاریخ امروز
    Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 10),
    child:
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(getToday2(jNow),
    style: Theme.of(context).textTheme.bodyText1!.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    ),
    ),

    ],
    ),
      SizedBox(height: 5,),
      Text(recordedTasks! + " وظیفه ثبت شده",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
          // fontWeight: FontWeight.bold,
            color: Colors.black38,
            fontSize: 15.sp
        ),
      ),
    ])
    ),

    // وظایف ثبت شده

    ],
    ),
    )
    ),
    ],
    )
    ),
      //hamide
    ],
    ),

    );
  }

}


