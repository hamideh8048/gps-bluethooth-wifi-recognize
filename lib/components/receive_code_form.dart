import 'dart:async';

import 'package:Prismaa/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class ReceiveCodeForm extends StatelessWidget {
  ReceiveCodeForm({
    Key? key,
    required this.formKey,
    required this.errorController,
    required this.textEditingController,
  }) : super(key: key);

  final formKey;
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PinCodeTextField(
              appContext: context,
              length: 4,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                fieldHeight: 80.sp,
                fieldWidth: 80.sp,
                activeFillColor: backgroundColor,
                activeColor: Colors.green,
                disabledColor: Colors.blue,
                errorBorderColor: Colors.red,
                inactiveColor: Colors.black12,
                inactiveFillColor: backgroundColor,
                selectedColor: Colors.black87,
                selectedFillColor: backgroundColor,
              ),
              cursorColor: Colors.blue,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textEditingController,
              keyboardType: TextInputType.number,
              onCompleted: (v) {
                debugPrint("Completed");
              },
              onChanged: (value) {
                debugPrint(value);
              },
            )),
      ),
    );
  }
}