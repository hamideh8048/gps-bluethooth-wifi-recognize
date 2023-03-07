import 'dart:convert';
import 'dart:io';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';



class Services {
  String baseURL = "http://65.21.119.84:3025";


  // گرفتن اطلاعات شیفت جاری
  Future getCurrentShift() async {
    String token = UserModel.mainToken;
    final response = await http.get(Uri.parse(baseURL + '/current_shift?token=$token'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // گرفتن اطلاعات پروفایل پرسنل
  Future getOtherPersonelItems(String token) async {
    final response = await http.get(Uri.parse(baseURL + '/personel_profile?token=$token'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // گرفتن اطلاعات جزئی یک وظیفه
  Future getDetailOfActivity(String id, String date) async {
    String token = UserModel.mainToken;
    final response = await http.get(Uri.parse(baseURL + '/personel_activity_info?token=$token&id=$id&date=$date'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // ورود
  Future sendLoginDataFormToServer(String username, String password) async {
    final response = await http.get(Uri.parse(baseURL + '/personel_login?username=$username&password=$password'));
    var responseBody = json.decode(response.body);
    // return {"body": responseBody, "code": response.statusCode};
    if(responseBody[0]['res'] == 1) {
      return responseBody;
    } else if(responseBody[0]['res'] == 0){
      return responseBody;
    } else { // when it is -1
      logOut();
      return responseBody;
    }
  }

  // تایید ورود
  Future sendConfirmLoginToServer(String phoneNumber, String confirmCode) async {
    final response = await http.get(Uri.parse(baseURL + '/register_login_personel?mobile=$phoneNumber&register_code=$confirmCode'));
    var responseBody = json.decode(response.body);
    if(responseBody[0]['res'] == 1) {
      // return {"body": responseBody, "code": response.statusCode};
      return responseBody;
    } else if(responseBody[0]['res'] == 0){
      // return {"body": responseBody, "code": response.statusCode};
      return responseBody;
    } else { // when it is -1
      logOut();
      return {"body": responseBody, "code": response.statusCode};
    }
  }

  // فراموشی رمز عبور
  Future resetPassword(String phoneNumber) async {
    final response = await http.get(Uri.parse(baseURL + '/forget_password_personel?mobile=$phoneNumber'));
    var responseBody = json.decode(response.body);
    if(responseBody[0]['res'] == 1) {
      return responseBody;
    } else if(responseBody[0]['res'] == 0){
      return responseBody;
    } else { // when it is -1
      logOut();
      return responseBody;
    }
  }

  // ثبت مرخصی ساعتی
  Future addHourseLeave(String dateController, String startTime, String endTime, String companyId) async {
    var bodyParameter = {
      "token": UserModel.mainToken,
      "start_date": dateController,
      "company_id": companyId,
      "start_time": startTime,
      "end_time": endTime,
    };

    final response = await http.post(Uri.parse(baseURL + '/add_hourse_leave'), body: bodyParameter);
    var responseBody = json.decode(response.body);
    if(responseBody[0]['res'] == 1) {
      return responseBody;
    } else if(responseBody[0]['res'] == 0){
      return responseBody;
    } else { // when it is -1
      logOut();
      return responseBody;
    }
  }

  // ثبت مرخصی روزانه
  Future addDayLeave(String startDateCtrl, String endDateCtrl, String companyId) async {
    var bodyParameter = {
      "token": UserModel.mainToken,
      "start_date": startDateCtrl,
      "end_date": endDateCtrl,
      "company_id": companyId,
    };

    final response = await http.post(
        Uri.parse(baseURL + '/add_day_leave'), body: bodyParameter);
    var responseBody = json.decode(response.body);
    if(responseBody[0]['res'] == 1) {
      return responseBody;
    } else if(responseBody[0]['res'] == 0){
      return responseBody;
    } else { // when it is -1
      logOut();
      return responseBody;
    }
  }


  // گرفتن لیست مرخصی
  Future getMorkhasiList(String date) async {
    String token = UserModel.mainToken;
    final response = await http.get(Uri.parse(baseURL + '/list_of_leave?token=$token&date=$date'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // گرفتن لیست تردد ها
  Future getTaradodList(int companyId, String startDate, String endDate, String date, int imperfect) async {
    String token = UserModel.mainToken;
    final response = await http.get(Uri.parse(baseURL + '/list_of_attendance?token=$token&company_id=$companyId&start_date=$startDate&end_date=$endDate&date=$date&imperfect=$imperfect'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }


  // گرفتن لیست فعالیت روزانه
  Future getTaskManagementList(String date) async {
    String token = UserModel.mainToken;
    final response = await http.get(Uri.parse(baseURL + '/personel_activities?token=$token&date=$date'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }


  // گرفتن لیست ماموریت ها
  Future getMissionList(String date) async {
    String token = UserModel.mainToken;
    final response = await http.get(Uri.parse(baseURL + '/list_of_mission?token=$token&date=$date'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // ارسال دکمه شروع ماموریت
  Future sendStartMission(int missionId) async {
    String token = UserModel.mainToken;
    final response = await http.get(Uri.parse(baseURL + '/start_mission?token=$token&id=$missionId'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // ارسال دکمه توقف ماموریت
  Future sendEndMission(int missionId) async {
    String token = UserModel.mainToken;
    final response = await http.get(Uri.parse(baseURL + '/end_mission?token=$token&id=$missionId'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // ثبت توضیح برای ماموریت
  Future setExplainMission(int missionId, String explain) async {
    String token = UserModel.mainToken;
    final response = await http.get(Uri.parse(baseURL + '/set_explain_mission?token=$token&id=$missionId&explain=$explain'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // گرفتن آیتم های صفحه پشتیبانی
  Future getSupportItems(String token) async {
    final response = await http.get(Uri.parse(baseURL + '/list_of_personel_ticket?token=$token'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // گرفتن پیام های پشتیبانی بر اساس آیدی
  Future getSupportMessagesItems(String token, String id) async {
    final response = await http.get(Uri.parse(baseURL + '/detail_of_ticket?token=$token&id=$id'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }


  // دکمه ثبت درخواست پشتیبانی
  Future sendSupportRequestRecordToServer(String subject, String message, String ticketId) async {
    var bodyParameter = {
      "token": UserModel.mainToken,
      "subject": subject,
      "ticket_id": ticketId,
      "priority": "1",
      "message": message,
    };

    final response = await http.post(Uri.parse(baseURL + '/add_ticket'), body: bodyParameter);
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // گرفتن اطلاع رسانی ها
  Future getNotices() async {
    String token = UserModel.mainToken;
    final response = await http.get(Uri.parse(baseURL + '/list_of_notices?token=$token'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // ویرایش اطلاعات کاربری
  Future editPersonelProfile(String name, String family, String nationalCode, String email, String username, String picPath) async {
    String token = UserModel.mainToken;
    final response = await http.patch(Uri.parse(baseURL + '/edit_personel_profile?token=$token&name=$name&family=$family&national_code=$nationalCode&email=$email&username=$username&pic_path=$picPath'));
    var responseBody = json.decode(response.body);
    return responseBody;
  }

  // اضافه کردن تصویر
  Future addFile(File img) async {
    // برای ارسال عکس تکی به این صورت باید به سمت سرور بفرستیم
    Uri uri = Uri.parse(baseURL + '/add_file');

    var request = http.MultipartRequest("POST", uri);
    // request.headers.addAll(headerParameter);

    // if(kIsWeb) {
    //   Uint8List data = await fileWeb!.readAsBytes();
    //   List<int> list = data.cast();
    //   print("sss" + fileWeb.path.toString());
    //   var multipartFile = http.MultipartFile.fromBytes("photo", list, filename: basename(fileWeb.path));
    //   request.files.add(multipartFile);
    // } else {
      var fileStream = http.ByteStream(DelegatingStream.typed(img.openRead()));
      var length = await img.length();
      var multipartFile = http.MultipartFile("bill", fileStream, length, filename: basename(img.path));
      request.files.add(multipartFile);
    // }

    var response = await http.Response.fromStream(await request.send());
    var responseBody = json.decode(response.body);
    return responseBody;

  }
  Future addAttendance(String token) async {
    var bodyParameter = {
      "token": UserModel.mainToken,
      //"device_id": deviceId,

    };
    final response = await http.post(Uri.parse(baseURL + '/add_attendance'), body: bodyParameter);
    var responseBody = json.decode(response.body);
    return responseBody;
  }



}

