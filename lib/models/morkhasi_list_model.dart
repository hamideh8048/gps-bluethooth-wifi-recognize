

class MorkhasiListModel{
  String? companyName;
  String? companyAddress;
  int? status;
  String? rejectReason;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? type;

  MorkhasiListModel.fromJson(Map<String, dynamic> parsedJson){
    companyName = parsedJson["company_name"];
    companyAddress = parsedJson["company_address"];
    status = parsedJson["status"];
    if(parsedJson["reject_reason"] != null){rejectReason = parsedJson["reject_reason"];} else {rejectReason = "";}
    startDate = parsedJson["start_date"];
    endDate = parsedJson["end_date"];
    if(parsedJson["start_time"] != null){startTime = parsedJson["start_time"];} else {startTime = "";}
    if(parsedJson["end_time"] != null){endTime = parsedJson["end_time"];} else {endTime = "";}
    type = parsedJson["type"];
  }
}