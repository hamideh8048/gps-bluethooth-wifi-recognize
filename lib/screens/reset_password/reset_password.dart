import 'dart:async';

import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/login_text_feild.dart';
import 'package:Prismaa/components/receive_code_form.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/reset_password/widgets/confirm_reset_password_widget.dart';
import 'package:Prismaa/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  // bool switchWidget = true;
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";
  bool hasError = false;
  final TextEditingController phoneNumber = TextEditingController();
  bool pageLoading = false;
  String msgResponse = "";
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    errorController!.close();
    _focusNode.dispose();
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
          leadingWidth: 0,
          leading: const SizedBox(),
        ),
      ),

      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: backgroundColor,
          // child: switchWidget == true
          child: resetPasswordWidget(context, phoneNumber, formKey, _focusNode)
            // :
            //   confirmResetPasswordWidget(
            //     context,
            //     phoneNumber,
            //     formKey,
            //     errorController,
            //     textEditingController,
            //   ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: () {
              if(formKey.currentState!.validate()){
                resetPassword(phoneNumber.text);
              }
            },
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.all(Radius.circular(40))
              ),
              child: Center(
                child: Text("تایید کد",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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

  resetPassword(String phoneNumber) async {
    setState(() => pageLoading = true);
    var response = await (Services()).resetPassword(phoneNumber);
    if (response[0]["res"] == 1) {
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white
          )),
        background: Colors.green,
      );
      setState(() => pageLoading = false);
      Navigator.pop(context);
    } else {
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white
          )),
        background: Colors.red,
      );
      setState(() => pageLoading = false);
    }
  }

}



