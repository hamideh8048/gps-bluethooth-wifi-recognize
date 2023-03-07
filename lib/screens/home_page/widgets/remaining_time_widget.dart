import 'dart:async';


import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:poly_geofence_service/models/lat_lng.dart';
import 'package:poly_geofence_service/models/poly_geofence.dart';
import 'package:poly_geofence_service/models/poly_geofence_status.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart';

import 'enter_app.dart';

// Widget remainingTimeWidget(BuildContext context, StateSetter state, CountdownTimerController controller,bool isEnter) {
//   bool isEnter2=isEnter;

  class RemainingTimeWidget extends StatefulWidget {
    RemainingTimeWidget
  ({ Key? key,
  required this. context,required this. controller,required this.isEnter,required this.type,required this.point, this.callback})
      : super(key: key);
    BuildContext context;
    List<LatLng>point=[];
    CountdownTimerController controller;
    final Function()? callback;
    bool isEnter;
    String type;
    @override
    State<RemainingTimeWidget> createState() => RemainingTimeWidgetState();
  }

class RemainingTimeWidgetState extends State<RemainingTimeWidget> {
  final _streamController = StreamController<PolyGeofence>();
    bool isEnter2=false;
    bool isDialogOpen=false;
    bool isAllowed=false;
    String name="";
    var dt = DateTime.now();
    ShowExitModal() {
      Future.delayed(Duration.zero, () async {
        showDialog(
            context: context,
            builder: (context) {
              Future.delayed(Duration(seconds: 10), () {});

              return
                Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.all(10),
                    child:
                    Center(child:
                    EnterApp(

                      isEnter: false,
                      deviceType: " نوع ثبت : ${name} ",
                      subtitle: "خروج :${dt.hour}:${dt.minute}",
                      token: UserModel.mainToken,
                      hasDelay: false,)
                    )
                );
            }).then((valueFromDialog) {
          // setState(() {
          //   beforEnter=valueFromDialog==null?true:valueFromDialog;
          // });
          // use the value as you wish
          print(valueFromDialog);
        })

        ;
      });
    }

    gps()
    {

      if(widget.type.contains("gps")&&widget.point!=null&&widget.point.length>0){
        showMessage('در حال جستجوی جی پی اس', Colors.green, 10);
        final _polyGeofenceList = <PolyGeofence>[
          PolyGeofence(
              id: 'This is the ID',
              data: {
                'address': 'Address',
                'about': 'About',
              },
              polygon:widget. point

            // <LatLng>[
            //   const LatLng(31.3384904,48.67316),//(34.654375, 50.895237),
            //   const LatLng(31.3384453,48.6731774),//(34.654221, 50.895426),
            //   const LatLng(31.3384481,48.6731974),//(34.654373, 50.895701),
            //   const LatLng(31.3384553,48.6731974)//(34.654575, 50.895482),
            // ],

            // polygon: <LatLng>[
            //   const LatLng(31.3384904,48.67316),//(34.654375, 50.895237),
            //   const LatLng(31.3384453,48.6731774),//(34.654221, 50.895426),
            //   const LatLng(31.3384481,48.6731974),//(34.654373, 50.895701),
            //   const LatLng(31.3384553,48.6731974)//(34.654575, 50.895482),
            // ],
          ),
        ];
        final _polyGeofenceService = PolyGeofenceService.instance.setup(
            interval: 5000,
            accuracy: 200,
            loiteringDelayMs: 60000,
            statusChangeDelayMs: 10000,
            allowMockLocations: false,
            printDevLog: false
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _polyGeofenceService.addPolyGeofenceStatusChangeListener(_onPolyGeofenceStatusChanged);
          _polyGeofenceService.addLocationChangeListener(_onLocationChanged);
          _polyGeofenceService.addLocationServicesStatusChangeListener(_onLocationServicesStatusChanged);
          _polyGeofenceService.addStreamErrorListener(_onError);
          _polyGeofenceService.start(_polyGeofenceList).catchError(_onError);
        });
      }
    }
    @override
    void initState() {
      super.initState();
      if(widget.type.contains("blue"))
      {name="بلوتوث";}
      else if(widget.type.contains("wifi"))
      {name="وای فای";}
      else if (widget.type.contains("gps"))
      {name="جی پی اس";}
    }
    Future<void> _onPolyGeofenceStatusChanged(
        PolyGeofence polyGeofence,
        PolyGeofenceStatus polyGeofenceStatus,
        Location location) async {
      print('polyGeofence: ${polyGeofence.toJson()}');
      print('polyGeofenceStatus: ${polyGeofenceStatus.toString()}');

      _streamController.sink.add(polyGeofence);
      //todo
    //  if(UserModel.currentShiftModel!=null &&UserModel.currentShiftModel!.presenceType==2&& !isDialogOpen){

      if(UserModel.currentShiftModel!=null &&UserModel.currentShiftModel!.presenceType==0&& !isDialogOpen){

      //setState(() => isAllowed=true);
      isDialogOpen=true;
        showMessage('جی پی اس پیدا شد ', buttonGreenColor, 15);
        ShowExitModal();
      }
    }
    // This function is to be called when the location has changed.
    int index=0;
    void _onLocationChanged(Location location) {
      index=1+ index;
      if(index<4)
        showMessage('your current  location is : ${location.toJson()}\n db location is => lat : ${widget.point[0].latitude},long:${widget.point[0].longitude}', Colors.orange, 10);
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
        showMessage('Undefined error: $error', redColor, 15);
        return;
      }
      print('ErrorCode: $errorCode');
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
    @override
    Widget build(BuildContext context) {

      return Padding(padding: EdgeInsets.symmetric(vertical: 20), child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 270.sp,
                width: 270.sp,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(150),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3A3D49),
                      Color(0xFF3F424F),
                    ],
                    begin: FractionalOffset(0.0, 0.5),
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 113.sp,
                backgroundColor: backgroundColor,
              ),
              GestureDetector(
                onTap: () {
                  if(isEnter2)
                  {
                    // Future.delayed(Duration.zero, () async {
                    //   showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         Future.delayed(Duration(seconds: 10), () {
                    //         });
                    //
                    //         return
                    //           Dialog(
                    //               backgroundColor: Colors.transparent,
                    //               insetPadding: EdgeInsets.all(10),
                    //               child:
                    //               Center(child:
                    //               EnterApp( isEnter: false,deviceType: "نوع ثبت : بلوتوث",subtitle: "خروج :${dt.hour}:${dt.minute}",token:  UserModel.mainToken,hasDelay: false,)
                    //               )
                    //           );
                    //
                    //       }).then((valueFromDialog){
                    //     // setState(() {
                    //     //   beforEnter=valueFromDialog==null?true:valueFromDialog;
                    //     // });
                    //     // use the value as you wish
                    //     print(valueFromDialog);
                    //   })
                    //
                    //   ;
                    // });
                    widget.callback!();
                  }
                  else   setState(() {
                    isEnter2 = true;
                    print('hii');
                  });

            // else if ( widget.type.contains("gps") && widget.point!=null&& widget.point.length>0)
            //     {
            //       gps();
            //     }
            },
                child:
              CircularPercentIndicator(
                radius: 105.sp,
                //210.sp,
                lineWidth: 12.0,
                backgroundWidth: 1,
                animation: true,
                percent: 0.7,
                backgroundColor: Colors.black12,
                linearGradient: LinearGradient(
                  colors:
                isEnter2==false&&   widget.isEnter ? [
                    Color(0xFF4BA9B4),
                    Color(0xFF61D38F),
                  ] :
                  [
                    Color(0xFFFB435A),
                    Color(0xFFFF213C),
                  ]
                  ,
                  begin: FractionalOffset(0.0, 0.5),
                  end: FractionalOffset(0.5, 0.0),
                  stops: [0.2, 0.7],
                ),
                center: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: 28,
                    //   width: 26,
                    //   child: Image.asset("assets/images/briefcase_grey.png", fit: BoxFit.fill),
                    // ),
                    Text("نوع ثبت : ${name}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                        color: Colors.black87,
                        // fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // شماره معکوس
                isEnter2==false&&   widget. isEnter ?

                    CountdownTimer(
                      widgetBuilder: (BuildContext? context,
                          CurrentRemainingTime? time) {
                        var textStyle = Theme
                            .of(context!)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp
                        );

                        if (time == null) {
                          return Text("00:00:00", style: textStyle);
                        }
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(time.sec! < 10 ? "0${time.sec}" : "${time
                                  .sec}", style: textStyle),
                              Text(":", style: textStyle),
                              Text(time.min != null ? time.min! < 10 ? "0${time
                                  .min}" : "${time.min}" : "00",
                                  style: textStyle),
                              Text(":", style: textStyle),
                              Text(time.hours != null ? time.hours! < 10
                                  ? "0${time.hours}"
                                  : "${time.hours}" : "00", style: textStyle),
                            ]
                        );
                      },
                      controller: widget. controller,

                    ) :

                    Text("برای خروج کلیک کنید",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                          color: redColor, //Colors.red.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    )
                    ,
                    const SizedBox(height: 4),
                    isEnter2==false&&       widget. isEnter ? Text("مانده تا پایان کار",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                        // fontSize: 25
                      ),
                    ) :
                    CountdownTimer(
                      widgetBuilder: (BuildContext? context,
                          CurrentRemainingTime? time) {
                        var textStyle = Theme
                            .of(context!)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 26.sp
                        );

                        if (time == null) {
                          return Text("00:00:00", style: textStyle);
                        }
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(time.sec! < 10 ? "0${time.sec}" : "${time
                                  .sec}", style: textStyle),
                              Text(":", style: textStyle),
                              Text(time.min != null ? time.min! < 10 ? "0${time
                                  .min}" : "${time.min}" : "00",
                                  style: textStyle),
                              Text(":", style: textStyle),
                              Text(time.hours != null ? time.hours! < 10
                                  ? "0${time.hours}"
                                  : "${time.hours}" : "00", style: textStyle),
                            ]
                        );
                      },
                      controller:  widget.controller,
                    ),
                    const SizedBox(height: 6),
                    Text("شرکت نو اندیش",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                          color: const Color(0xFF8097a0),
                          // fontWeight: FontWeight.bold,
                          fontSize: 12.sp
                      ),
                    ),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
              )),
            ],
          ),

        ],
      ));
    }}