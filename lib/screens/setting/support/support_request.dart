import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/login_text_feild.dart';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

class SupportRequest extends StatefulWidget {
  const SupportRequest({Key? key}) : super(key: key);

  @override
  State<SupportRequest> createState() => SupportRequestState();
}

class SupportRequestState extends State<SupportRequest> {
  String selectedItems = 'شرکت نواندیش';
  List<String> companyItems = ['شرکت نواندیش'];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _topicCtrl = TextEditingController();
  final TextEditingController _explainCtrl = TextEditingController();
  final FocusNode _topicFocusNode = FocusNode();
  final FocusNode _explainFocusNode = FocusNode();
  bool buttonLoading = false;

  @override
  void dispose() {
    _topicCtrl.dispose();
    _explainCtrl.dispose();
    _topicFocusNode.dispose();
    _explainFocusNode.dispose();
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
                  Text("درخواست پشتیبانی",
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

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 16.sp, left: 16.sp, top: 16.sp),
          child: Column(
            children: [
              // باکس انتخاب شرکت
              Material(
                color: backgroundColor,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    labelText: "انتخاب شرکت ",
                    labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
                    hintText: "لطفا یک شرکت انتخاب کنید",
                    hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14.sp,
                        color: Colors.black26
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(
                          color: Colors.black12, width: 1.5),
                    ),
                    prefixIcon: const Icon(null),
                    // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                  ),
                  icon: Icon(Icons.keyboard_arrow_down, size: 30.sp,),
                  value: selectedItems,
                  items: companyItems.map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item, style: Theme.of(context).textTheme.bodyText1),
                  )).toList(),
                  onChanged: (item) => setState(() => selectedItems = item!),
                ),
              ),
              SizedBox(height: 40.sp),

              // موضوع و توضیح پشتیبانی
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // موضوع پشتیبانی
                    LoginTextFeild(
                      labelText: 'موضوع پشتیبانی',
                      hintText: 'موضوع خود را وارد کنید',
                      prefixIcon: const Icon(null),
                      controller: _topicCtrl,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      autofillHints: const [AutofillHints.name],
                      validator: (String? value){
                        if(value == ""){
                          return "این فیلد نباید خالی باشد";
                        } else {
                          return null;
                        }
                      },
                      focusNode: _topicFocusNode,
                      textDirection: TextDirection.rtl,
                      onFieldSubmitted: _explainFocusNode
                    ),
                    SizedBox(height: 40.sp),

                    // توضیح پشتیبانی
                    TextFormField(
                      controller: _explainCtrl,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      validator: (String? value){
                        if(value == ""){
                          return "این فیلد نباید خالی باشد";
                        } else {
                          return null;
                        }
                      },
                      maxLines: 5,
                      textDirection: TextDirection.rtl,
                      autofillHints: const [AutofillHints.name],
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'توضیح پشتیبانی',
                        labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
                        hintText: 'توضیح بابت مرخصی',
                        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14.sp,
                            color: Colors.black26
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.black12, width: 1.5),
                        ),
                        prefixIcon: const Icon(null),
                      ),
                      focusNode: _explainFocusNode,
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(null);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 105.sp,
          color: const Color(0xFFFBFBFD),
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),
          // دکمه ثبت پشتیبانی
          child: GestureDetector(
            onTap: (){
              if(_formKey.currentState!.validate()){
                sendSupportRequestRecordToServer(_topicCtrl.text, _explainCtrl.text);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Text("ثبت پشتیبانی",
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

  sendSupportRequestRecordToServer(String subject, String message) async {
    setState(() => buttonLoading = true);
    var response = await (Services()).sendSupportRequestRecordToServer(subject, message, "0");

    if(response[0]["res"] == 1){
      setState(() => buttonLoading = false);
      Navigator.of(context).pop();
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result, style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.white,
        )),
        background: Colors.lightGreen,
      );
    } else if(response[0]["res"] == -1) {
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      setState(() => buttonLoading = false);
      Navigator.of(context).pop();
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result, style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.white,
        )),
        background: Colors.red,
      );
    }

  }
}
















