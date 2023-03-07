import 'dart:async';
import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/reset_password/widgets/confirm_reset_password_widget.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmLogin extends StatefulWidget {
  const ConfirmLogin({Key? key}) : super(key: key);

  @override
  State<ConfirmLogin> createState() => ConfirmLoginState();
}

class ConfirmLoginState extends State<ConfirmLogin> {
  String phoneNumber = UserModel.phoneNumber;
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  final TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  bool hasError = false;
  bool pageLoading = false;


  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    textEditingController.dispose();
    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
        ),
      ),

      body: pageLoading
        ? const Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0))
        : GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: backgroundColor,
              child: confirmResetPasswordWidget(
                context,
                phoneNumber,
                formKey,
                errorController,
                textEditingController,
              ),
            ),
          ),

      bottomNavigationBar: pageLoading
        ? const SizedBox()
        : SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: GestureDetector(
              onTap: () {
                formKey.currentState!.validate();
                // conditions for validating
                if (textEditingController.text == "" || textEditingController.text.length < 3) {
                  errorController!.add(ErrorAnimationType.shake); // Triggering error shake animation
                  setState(() => hasError = true);
                } else {
                  setState(() => hasError = false);
                  sendConfirmLoginToServer(phoneNumber, textEditingController.text);
                }
              },
              child: Container(
                height: 70.sp,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(40))
                ),
                child: Center(
                  child: Text("تایید کد",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }

  sendConfirmLoginToServer(String phoneNumber, String confirmCode) async {
    var response = await (Services()).sendConfirmLoginToServer(phoneNumber, confirmCode);

    // response["body"][0]["res"] == 1
    if (response[0]["res"] == 1) {
      String tokenResult = response[0]['token'];
      storeUserToken(tokenResult);
      UserModel.mainToken = response[0]["token"];

      Navigator.pushReplacementNamed(context, "/main_tab_bar");
    } else {
      errorController!.add(ErrorAnimationType.shake); // Triggering error shake animation
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white
          )),
        background: Colors.red,
      );
    }
  }

  void storeUserToken(String tokenResult) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user.api_token", tokenResult);
    // getUserInfo(tokenResult);
  }

}
