
class SupportModel{
  String id = "";
  String companyName = "";
  String departmentName =  "";
  String subject = "";
  int priority = 1;
  String status = "";
  List<SupportModelMessages> messages = [];
  String date = "";

  SupportModel.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson["id"] ?? "";
    companyName = parsedJson["company_name"] ?? "";
    departmentName = parsedJson["department_name"] ?? "";
    subject = parsedJson["subject"] ?? "";
    priority = parsedJson["priority"] ?? 1;
    status = parsedJson["status"] ?? "";
    if(parsedJson["messages"] != null){
      parsedJson["messages"].forEach((item) {
        messages.add(SupportModelMessages.fromJson(item));
      });
    } else {
      messages = [];
    }
    date = parsedJson["date"] ?? "";
  }
}



class SupportModelMessages{
  String message = "";
  String sender = "";
  String date = "";

  SupportModelMessages.fromJson(Map<String, dynamic> parsedJson){
    message = parsedJson["message"] ?? "";
    sender = parsedJson["sender"] ?? "";
    date = parsedJson["date"] ?? "";
  }
}