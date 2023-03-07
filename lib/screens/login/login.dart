import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/login_text_feild.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool pageLoading = false;
  bool obscurePassword = true;
  String passCtrl = "";
  bool showPass = true;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  // AnimationController? _animationController;

  // =======================================
  @override
  void initState() {
    super.initState();
    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus) {
    //     _animationController!.forward();
    //   } else {
    //     _animationController!.reverse();
    //   }
    // });
    // _username.text = "mehdi";
    // _password.text = "635241";
  }
  // =======================================

  @override
  void dispose() {
    // _animationController!.dispose();
    _username.dispose();
    _password.dispose();
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          leadingWidth: 0,
          leading: const SizedBox(),
        ),
      ),

      body: pageLoading
        ? const Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0))
        : SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.sp),
                SizedBox(
                  width: 76.sp,
                  height: 81.sp,
                  child: Image.asset("assets/images/shutterstockConverted_ImageView_86-76x81.png", fit: BoxFit.fill),
                ),
                SizedBox(height: 30.sp),
                Text("پریسما، مدیریت و سازماندهی",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                  ),
                ),
                Text("تردد منابع انسانی.",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                  ),
                ),
                SizedBox(height: 50.sp),
                Text("نام کاربری و رمز عبور خود را وارد کنید",
                  style: Theme.of(context).textTheme.bodyText1
                ),
                SizedBox(height: 60.sp),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoginTextFeild(
                        labelText: 'نام کاربری',
                        hintText: 'نام کاربری خود را وارد کنید',
                        prefixIcon: const Icon(Icons.account_circle_outlined, color: Colors.black12,),
                        controller: _username,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        autofillHints: const [AutofillHints.username],
                        validator: (String? value){
                          if(value == ""){
                            return "این فیلد نباید خالی باشد";
                          } else {
                            return null;
                          }
                        },
                        focusNode: _focusNode,
                        textDirection: TextDirection.ltr,
                        onFieldSubmitted: _focusNode2
                      ),
                      SizedBox(height: 40.sp),

                      // فیلد رمز عبور
                      TextFormField(
                        controller: _password,
                        obscureText: showPass,
                        keyboardType: TextInputType.number,
                        validator: (String? value){
                          if(value == ""){
                            return "این فیلد نباید خالی باشد";
                          } else {
                            return null;
                          }
                        },
                        textDirection: TextDirection.ltr,
                        autofillHints: const [AutofillHints.password],
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          labelText: 'رمز عبور',
                          labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
                          hintText: 'رمز عبور خود را وارد کنید',
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
                          prefixIcon: const Icon(Icons.lock_outlined, color: Colors.black12),
                          suffixIcon: GestureDetector(
                            onTap: () => setState(() => showPass = !showPass),
                            child: showPass
                            ?
                              Container(
                                height: 25.sp, width: 30.sp,
                                margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/doesn't_show_pass.png"))),
                              )
                            :
                              Container(
                                height: 22.sp, width: 27.sp,
                                margin: EdgeInsets.symmetric(horizontal: 13.0.sp),
                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/show_pass.png"))),
                              )
                          )
                        ),
                        focusNode: _focusNode2,
                        onFieldSubmitted: null,
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 40.sp),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/reset_password");
                  },
                  child: Text("رمز عبور خود را فراموش کرده اید؟",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14.sp,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: pageLoading
        ? const SizedBox()
        :
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: (){
                if(_formKey.currentState!.validate()){
                  sendLoginDataFormToServer(_username.text, _password.text);
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
                  child: Text("ورود به پنل کاربری",
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

  sendLoginDataFormToServer(String username, String password) async {
    setState(() => pageLoading = true);
    var response = await (Services()).sendLoginDataFormToServer(username, password);

    if (response[0]["res"] == 1) {
      if(response[0]["is_register"] == 0) {
        UserModel.phoneNumber = response[0]["mobile"];
        UserModel.isRegister = response[0]["is_register"];
        Navigator.pushReplacementNamed(context, "/confirm_login");
      } else if(response[0]["is_register"] == 1){
        getOtherPersonelItems(response[0]['token']);

        String tokenResult = response[0]['token'];
        storeUserToken(tokenResult);
        UserModel.mainToken = response[0]["token"];
        UserModel.phoneNumber = response[0]["mobile"];
        UserModel.isRegister = response[0]["is_register"];
        Navigator.pushReplacementNamed(context, "/main_tab_bar");
      }
      setState(() => pageLoading = false);
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

  getOtherPersonelItems(String token) async {
    var response = await (Services()).getOtherPersonelItems(token);

    if(response[0]["res"] == 1){
      UserModel.name = response[0]["name"];
      UserModel.family = response[0]["family"];
      UserModel.picPath = response[0]["pic_path"];
      UserModel.nationalCode = response[0]["national_code"];
      UserModel.mobile = response[0]["mobile"];
      UserModel.email = response[0]["email"];
      UserModel.userRoleId = response[0]["user_role_id"];
      UserModel.username = response[0]["username"];

    }
  }

  void storeUserToken(String tokenResult) async {
    print("dfdf : " + tokenResult);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user.api_token", tokenResult);
    // getUserInfo(tokenResult);
  }

}

