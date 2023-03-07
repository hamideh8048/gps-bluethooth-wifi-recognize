
class CompanyListModel{
  String id = "";
  String title = "";
  CompanyListModel.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson["id"] ?? "";
    title = parsedJson["title"] ?? "";

  }
}