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

