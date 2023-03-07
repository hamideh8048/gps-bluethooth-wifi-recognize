

class NotificationModel{
  String title = "";
  String explain = "";
  String status = "";
  String reason = "";
  String date = "";

  NotificationModel.fromJson(Map<String, dynamic> parsedJson){
    title = parsedJson["title"] ?? "";
    explain = parsedJson["explain"] ?? "";
    status = parsedJson["status"] ?? "";
    if(parsedJson["reason"] != null) {
      reason = parsedJson["reason"] ?? "";
    } else {
      reason = "";
    }
    date = parsedJson["date"] ?? "";
  }
}