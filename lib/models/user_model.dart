
import 'package:Prismaa/models/company_list_model.dart';

import 'current_shift_model.dart';

class UserModel {
  // static bool isLogin = false;
  static String mainToken = "";
  static String phoneNumber = "";
  static int presence_type=0 ;
  static int isRegister = 0;
  static String name = "";
  static String family = "";
  static String picPath = "";
  static String nationalCode = "";
  static String mobile = "";
  static String email = "";
  static String userRoleId = "";
  static String username = "";
  static List<CompanyListModel> companies = [];
  static CurrentShiftModel? currentShiftModel ;
}