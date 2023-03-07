

class MissionModel{
  String id = "";
  String companyName = "";
  String companyAddress = "";
  int status = 0;
  String startDate = "";
  String endDate = "";
  String startTime = "";
  String endTime = "";
  String type = "";
  String explain = "";
  String explainEmployee = "";
  int statusMission = 0;

  MissionModel.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson["id"] ?? "";
    companyName = parsedJson["company_name"] ?? "";
    companyAddress = parsedJson["company_address"] ?? "";
    status = parsedJson["status"] ?? 0;
    startDate = parsedJson["start_date"] ?? "";
    endDate = parsedJson["end_date"] ?? "";
    startTime = parsedJson["start_time"] ?? "";
    endTime = parsedJson["end_time"] ?? "";
    type = parsedJson["type"] ?? "";
    explain = parsedJson["explain"] ?? "";
    explainEmployee = parsedJson["explain_employee"] ?? "";
    statusMission = parsedJson["status_mission"] ?? "";
  }
}