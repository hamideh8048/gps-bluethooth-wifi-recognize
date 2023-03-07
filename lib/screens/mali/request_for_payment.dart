import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/login_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestForPayment extends StatefulWidget {
  const RequestForPayment({Key? key}) : super(key: key);

  @override
  State<RequestForPayment> createState() => RequestForPaymentState();
}

class RequestForPaymentState extends State<RequestForPayment> {
  final TextEditingController _requestedAmountCtrl = TextEditingController();
  final TextEditingController _accountNumberCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _requestedAmountFocusNode = FocusNode();
  final FocusNode _accountNumberFocusNode = FocusNode();
  String accountBalance = "۱۵،۶۵۰،۰۰۰";


  @override
  void dispose() {
    _requestedAmountCtrl.dispose();
    _accountNumberCtrl.dispose();
    _requestedAmountFocusNode.dispose();
    _accountNumberFocusNode.dispose();
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
                      child: Image.asset("assets/images/arrow_back.png")),
                ),
                SizedBox(width: 20.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.sp),
                    Text("درخواست وجه",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.sp,
                      ),
                    ),
                    Text("ثبت و مشاهده مرخصی و تاخیر",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        // fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ),

      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(accountBalance,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("موجودی حساب شما",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 50.sp),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      LoginTextFeild(
                        labelText: 'مبلغ درخواستی',
                        hintText: 'مبلغ درخواستی خود را انتخاب کنید',
                        prefixIcon: const Icon(null),
                        controller: _requestedAmountCtrl,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        autofillHints: const [AutofillHints.username],
                        validator: (String? value){
                          if(value == ""){
                            return "این فیلد نباید خالی باشد";
                          } else {
                            return null;
                          }
                        },
                        focusNode: _requestedAmountFocusNode,
                        textDirection: TextDirection.ltr,
                        onFieldSubmitted: _accountNumberFocusNode
                      ),
                      SizedBox(height: 8.sp),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _requestedAmountCtrl.text = accountBalance.replaceAll("،", "");
                              });
                            },
                            child: Text("دریافت همه موجودی",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 14.sp,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.sp),
                        ],
                      ),
                      SizedBox(height: 40.sp),

                      LoginTextFeild(
                        labelText: 'شماره حساب واریز',
                        hintText: 'شماره حساب خود را وارد کنید',
                        prefixIcon: const Icon(null),
                        controller: _accountNumberCtrl,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        autofillHints: const [AutofillHints.username],
                        validator: (String? value){
                          if(value == ""){
                            return "این فیلد نباید خالی باشد";
                          } else {
                            return null;
                          }
                        },
                        focusNode: _accountNumberFocusNode,
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
              //
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Text("درخواست برداشت",
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
}
