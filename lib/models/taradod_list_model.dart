
class TaradodListModel{
  String id = "";
  String companyName = "";
  String companyAddress = "";
  String date = "";
  String inTime = "";
  String inDevice = "";
  String outTime = "";
  String outDevice = "";
  String delay = "";
  String reasonHurry = "";


  TaradodListModel.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson["id"] ?? "";
    companyName = parsedJson["company_name"] ?? "";
    companyAddress = parsedJson["company_address"] ?? "";
    date = parsedJson["date"] ?? "";
    inTime = parsedJson["in_time"] ?? "";
    inDevice = parsedJson["in_device"] ?? "";
    outTime = parsedJson["out_time"] ?? "";
    outDevice = parsedJson["out_device"] ?? "";
    delay = parsedJson["delay"] ?? "";
    reasonHurry = parsedJson["reason_hurry"] ?? "";
  }
}