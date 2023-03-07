import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTextFeild extends StatelessWidget {
  const LoginTextFeild({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.obscureText,
    required this.keyboardType,
    required this.validator,
    required this.autofillHints,
    required this.focusNode,
    required this.textDirection,
    required this.onFieldSubmitted,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final Iterable autofillHints;
  final FocusNode focusNode;
  final TextDirection textDirection;
  final FocusNode? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      textDirection: textDirection,
      autofillHints: const [AutofillHints.name],
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 14.sp,
            color: Colors.black26
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(color: Colors.black12, width: 1.5),
        ),
        prefixIcon: prefixIcon
      ),
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(onFieldSubmitted!);
      },
    );
  }
}