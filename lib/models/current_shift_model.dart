
import 'package:poly_geofence_service/models/lat_lng.dart';

class CurrentShiftModel{
  String address = "";
  String deviceType = "";
  String deviceId = "";
  String deviceCode = "";
  int presenceType = 0;
  String deviceAddress = "";
  String devicePass = "";
  String company = "";
  List<ScopModel> scop = [];
  String personelEntryHours = "";
  String shiftEntryHours = "";
  String shiftExitHourse = "";
  String appAction = "";
  int? shiftColor;
  String id = "";
  List<LatLng>point=[];
  CurrentShiftModel.fromJson(Map<String, dynamic> parsedJson){
    address = parsedJson["device_address"] ?? "";
    deviceType = parsedJson["device_type"] ?? "";
    deviceId = parsedJson["device_id"] ?? "";
    deviceCode = parsedJson["device_code"] ?? 0;
  //  presenceType= parsedJson["presence_type"] ?? 0;
    deviceAddress = parsedJson["device_address"] ?? "";
    devicePass = parsedJson["device_pass"] ?? "";
    company = parsedJson["company"] ?? "";
    parsedJson["scop"].forEach((item) {
      scop.add(ScopModel.fromJson(item));
    });

    personelEntryHours = parsedJson["personel_entry_hours"] ?? "";
    shiftEntryHours = parsedJson["shift_entry_hours"] ?? "";
    shiftExitHourse = parsedJson["shift_exit_hourse"] ?? "";
    appAction = parsedJson["app_action"] ?? "";
    shiftColor = parsedJson["shift_color"];
    id = parsedJson["id"] ?? "";
  }
}

class ScopModel{
  String lat = "";
  String long = "";

  ScopModel.fromJson(Map<String, dynamic> parsedJson){
    lat = parsedJson["lat"] ?? "";
    long = parsedJson["long"] ?? "";
  }
}