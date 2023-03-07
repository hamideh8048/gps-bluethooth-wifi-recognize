import 'package:Prismaa/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// خروج از حساب کاربری
logOut() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove("user.api_token");
  // UserModel.isLogin = false;
  UserModel.mainToken = "";
  UserModel.phoneNumber = "";
  UserModel.isRegister = 0;

  UserModel.name  = "";
  UserModel.family  = "";
  UserModel.picPath  = "";
  UserModel.nationalCode  = "";
  UserModel.mobile = "";
  UserModel.email  = "";
  UserModel.userRoleId = "";
  UserModel.username = "";
  UserModel.companies = [];
}

