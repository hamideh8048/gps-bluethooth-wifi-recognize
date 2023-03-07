import 'dart:async';
import 'package:flutter/material.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart';

// void main() => runApp(const ExampleApp(lstPoint: []));

class ExampleApp extends StatefulWidget {
  const ExampleApp({Key? key,required this.lstPoint}) : super(key: key);
  final  List<LatLng>? lstPoint;
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {

  static List<LatLng>? lstPoint2;
  final _streamController = StreamController<PolyGeofence>();

  // Create a [PolyGeofenceService] instance and set options.
  final _polyGeofenceService = PolyGeofenceService.instance.setup(
    interval: 5000,
    accuracy: 100,
    loiteringDelayMs: 60000,
    statusChangeDelayMs: 10000,
    allowMockLocations: false,
    printDevLog: false
  );



  // Create a [PolyGeofence] list.
  // final _polyGeofenceList = <PolyGeofence>[
  //   PolyGeofence(
  //     id: 'This is the ID',
  //     data: {
  //       'address': 'Address',
  //       'about': 'About',
  //     },
  //     polygon: lstPoint2!
  //
  //     // <LatLng>[
  //     //   const LatLng(31.3384904,48.67316),//(34.654375, 50.895237),
  //     //   const LatLng(31.3384453,48.6731774),//(34.654221, 50.895426),
  //     //   const LatLng(31.3384481,48.6731974),//(34.654373, 50.895701),
  //     //   const LatLng(31.3384553,48.6731974)//(34.654575, 50.895482),
  //     // ],
  //
  //     // polygon: <LatLng>[
  //     //   const LatLng(31.3384904,48.67316),//(34.654375, 50.895237),
  //     //   const LatLng(31.3384453,48.6731774),//(34.654221, 50.895426),
  //     //   const LatLng(31.3384481,48.6731974),//(34.654373, 50.895701),
  //     //   const LatLng(31.3384553,48.6731974)//(34.654575, 50.895482),
  //     // ],
  //   ),
  // ];

  // This function is to be called when the geofence status is changed.
  Future<void> _onPolyGeofenceStatusChanged(
      PolyGeofence polyGeofence,
      PolyGeofenceStatus polyGeofenceStatus,
      Location location) async {
    print('polyGeofence: ${polyGeofence.toJson()}');
    print('polyGeofenceStatus: ${polyGeofenceStatus.toString()}');

  }
  // This function is to be called when the location has changed.
  void _onLocationChanged(Location location) {
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
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }

    print('ErrorCode: $errorCode');
  }

  @override
  void initState() {
    super.initState();

     lstPoint2=widget.lstPoint;
    final _polyGeofenceList = <PolyGeofence>[
      PolyGeofence(
          id: 'This is the ID',
          data: {
            'address': 'Address',
            'about': 'About',
          },
          polygon: lstPoint2!

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _polyGeofenceService.addPolyGeofenceStatusChangeListener(_onPolyGeofenceStatusChanged);
      _polyGeofenceService.addLocationChangeListener(_onLocationChanged);
      _polyGeofenceService.addLocationServicesStatusChangeListener(_onLocationServicesStatusChanged);
      _polyGeofenceService.addStreamErrorListener(_onError);
      _polyGeofenceService.start(_polyGeofenceList).catchError(_onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // A widget used when you want to start a foreground task when trying to minimize or close the app.
      // Declare on top of the [Scaffold] widget.
      home: WillStartForegroundTask(
        onWillStart: () async {
          // You can add a foreground task start condition.
          return _polyGeofenceService.isRunningService;
        },
        androidNotificationOptions: AndroidNotificationOptions(
          channelId: 'geofence_service_notification_channel',
          channelName: 'Geofence Service Notification',
          channelDescription: 'This notification appears when the geofence service is running in the background.',
          channelImportance: NotificationChannelImportance.LOW,
          priority: NotificationPriority.LOW,
          isSticky: false,
        ),
        iosNotificationOptions: const IOSNotificationOptions(),
        notificationTitle: 'Geofence Service is running',
        notificationText: 'Tap to return to the app',
        foregroundTaskOptions: const ForegroundTaskOptions(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Poly Geofence Service'),
            centerTitle: true,
          ),
          body: _buildContentView(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Widget _buildContentView() {
    return StreamBuilder<PolyGeofence>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        final updatedDateTime = DateTime.now();
        final content = snapshot.data?.toJson().toString() ?? '';

        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          children: [
            Text('•\t\tPolyGeofence (updated: $updatedDateTime)'),
            const SizedBox(height: 10.0),
            Text(content+'uuu',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 15
                )
            ),
          ],
        );
      },
    );
  }
}