import 'dart:async';

import 'package:Prismaa/components/receive_code_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Widget confirmResetPasswordWidget(
    BuildContext context,
    String phoneNumber,
    final formKey,
    StreamController<ErrorAnimationType>? errorController,
    TextEditingController textEditingController,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("تایید ورود",
              style: Theme.of(context).textTheme.bodyText1
          ),
          // IconButton(
          //     onPressed: (){
          //       Navigator.pop(context);
          //     },
          //     icon: const Icon(Icons.arrow_forward, size: 30)
          // )
        ],
      ),
      SizedBox(height: 85.sp),
      Text("کد ۴ رقمی ارسال شده را وارد کنید.",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 25.sp,
        ),
        softWrap: true,
        maxLines: 2,
      ),
      SizedBox(height: 16.sp),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("کد به شماره ",
              style: Theme.of(context).textTheme.bodyText1
          ),
          Text(phoneNumber,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
          Text(" ارسال شده است",
              style: Theme.of(context).textTheme.bodyText1
          ),
          const Spacer(),
          InkWell(
            onTap: (){},
            child: SizedBox(
              width: 30.sp,
              height: 30.sp,
              child: Image.asset("assets/images/edit_icon.jpg", fit: BoxFit.fill),
            ),
          ),
        ],
      ),
      SizedBox(height: 100.sp),

      ReceiveCodeForm(
        formKey: formKey,
        errorController: errorController,
        textEditingController: textEditingController,
      ),
    ],
  );
}