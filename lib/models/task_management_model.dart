

class TaskManagementModel{
  String? address = "";
  String? company = "";
  String? deviceType = "";
  String? appAction = "";
  int? activityColor = 0;
  String? activityTitle = "";
  String? activityExplain = "";
  String? date = "";
  String? personelEntryHours = "";
  String? personelExitHourse = "";
  String? shiftEntryHours = "";
  String? shiftExitHourse = "";
  String? shiftId = "";
  String? id;

  TaskManagementModel.fromJson(Map<String, dynamic> parsedJson){
    address = parsedJson["address"] ?? "";
    company = parsedJson["company"] ?? "";
    deviceType = parsedJson["device_type"] ?? "";
    appAction = parsedJson["app_action"] ?? 0;
    activityColor = parsedJson["activity_color"] ?? 0;
    activityTitle = parsedJson["activity_title"] ?? "";
    activityExplain = parsedJson["activity_explain"] ?? "";
    date = parsedJson["date"] ?? "";
    personelEntryHours = parsedJson["personel_entry_hours"] ?? "";
    personelExitHourse = parsedJson["personel_exit_hourse"] ?? "";
    shiftEntryHours = parsedJson["shift_entry_hours"] ?? "";
    shiftExitHourse = parsedJson["shift_exit_hourse"] ?? "";
    shiftId = parsedJson["shift_id"] ?? "";
    id = parsedJson["id"] ?? "";
  }
}