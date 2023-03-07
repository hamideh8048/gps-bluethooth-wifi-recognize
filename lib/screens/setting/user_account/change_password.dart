import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/login_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmPasswordCtrl = TextEditingController();
  final FocusNode _currentPassFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _confirmFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();

    _passFocusNode.dispose();
    _confirmFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                        height: 45.sp,
                        width: 45.sp,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black87),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset("assets/images/arrow_back.png")
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text("تغییر رمز عبور",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.sp,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 30.sp,
                    width: 28.sp,
                    child: Image.asset("assets/images/notification_kartabl.png", fit: BoxFit.fill),
                  )
                ],
              ),
            ),
          )
      ),

      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              children: [
                SizedBox(height: 16.sp),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // رمز عبور فعلی
                      LoginTextFeild(
                          labelText: 'رمز عبور فعلی',
                          hintText: 'رمز عبور فعلی را وارد کنید',
                          prefixIcon: const Icon(null),
                          controller: _currentPasswordCtrl,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          autofillHints: const Iterable.empty(),
                          validator: (String? value){
                            if(value == ""){
                              return "این فیلد نباید خالی باشد";
                            } else {
                              return null;
                            }
                          },
                          focusNode: _currentPassFocusNode,
                          textDirection: TextDirection.ltr,
                          onFieldSubmitted: _passFocusNode
                      ),
                      SizedBox(height: 40.sp),

                      // رمز عبور جدید
                      LoginTextFeild(
                          labelText: 'رمز عبور جدید',
                          hintText: 'رمز جدید را وارد کنید',
                          prefixIcon: const Icon(null),
                          controller: _passwordCtrl,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          autofillHints: const Iterable.empty(),
                          validator: (String? value){
                            if(value == ""){
                              return "این فیلد نباید خالی باشد";
                            } else {
                              return null;
                            }
                          },
                          focusNode: _passFocusNode,
                          textDirection: TextDirection.ltr,
                          onFieldSubmitted: _confirmFocusNode
                      ),
                      SizedBox(height: 40.sp),

                      // تکرار رمز عبور جدید
                      LoginTextFeild(
                          labelText: 'تکرار رمز عبور جدید',
                          hintText: 'تکرار رمز جدید را وارد کنید',
                          prefixIcon: const Icon(null),
                          controller: _confirmPasswordCtrl,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          autofillHints: const Iterable.empty(),
                          validator: (String? value){
                            if(value == ""){
                              return "این فیلد نباید خالی باشد";
                            } else {
                              return null;
                            }
                          },
                          focusNode: _confirmFocusNode,
                          textDirection: TextDirection.ltr,
                          onFieldSubmitted: null
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 105.sp,
          color: const Color(0xFFFBFBFD),
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),
          // دکمه ثبت مرخصی
          child: GestureDetector(
            onTap: (){
              if(_formKey.currentState!.validate()){
                if(_passwordCtrl.text == _confirmPasswordCtrl.text){
                  // editPersonelProfile(_nameCtrl.text, _familyCtrl.text, _meliCodeCtrl.text, _emailCtrl.text, _userNameCtrl.text, _passwordCtrl.text, imageSrc);
                  changePassword();
                } else {
                  showSimpleNotification(
                    Text("رمز عبور و تکرار آن  باهم برابر نیست",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white
                        )),
                    background: Colors.red,
                  );
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Text("ویرایش رمز عبور",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  changePassword() async {
    print("OK");
  }
}
