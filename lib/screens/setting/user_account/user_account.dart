import 'dart:io';
import 'package:Prismaa/screens/setting/user_account/widgets/calculate_profile_pic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/login_text_feild.dart';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => UserAccountState();
}

class UserAccountState extends State<UserAccount> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _familyCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _meliCodeCtrl = TextEditingController();
  final TextEditingController _phoneNoCtrl = TextEditingController();
  final TextEditingController _userNameCtrl = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _familyFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _meliFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();

  bool pageLoading = false;
  bool buttonLoading = false;
  bool imageLoading = false;
  final picker = ImagePicker();
  String imgFileSrc = "";
  File img = File("");
  String fileName = "";


  @override
  void initState() {
    super.initState();
    getPersonelProfile();
  }

  getPersonelProfile() async {
    setState(() => pageLoading = true);
    var response = await (Services()).getOtherPersonelItems(UserModel.mainToken);

    if(response[0]["res"] == 1){
      UserModel.name = response[0]["name"];
      UserModel.family = response[0]["family"];
      UserModel.picPath = response[0]["pic_path"];
      UserModel.nationalCode = response[0]["national_code"];
      UserModel.mobile = response[0]["mobile"];
      UserModel.email = response[0]["email"];
      UserModel.userRoleId = response[0]["user_role_id"];
      UserModel.username = response[0]["username"];

      _nameCtrl.text = UserModel.name;
      _familyCtrl.text = UserModel.family;
      _emailCtrl.text = UserModel.email;
      _meliCodeCtrl.text = UserModel.nationalCode;
      _phoneNoCtrl.text = UserModel.phoneNumber;
      _userNameCtrl.text = UserModel.username;

      setState(() => pageLoading = false);
    } else if(response[0]["res"] == -1){
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
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


  @override
  void dispose() {
    _nameCtrl.dispose();
    _familyCtrl.dispose();
    _emailCtrl.dispose();
    _meliCodeCtrl.dispose();
    _phoneNoCtrl.dispose();
    _userNameCtrl.dispose();

    _nameFocusNode.dispose();
    _familyFocusNode.dispose();
    _emailFocusNode.dispose();
    _meliFocusNode.dispose();
    _phoneFocusNode.dispose();
    _userNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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
                    Text("پروفایل کاربری",
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


        body: pageLoading
        ? const Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0))
        :
        GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: NestedScrollView(
            headerSliverBuilder: (context, value){
              return [
                SliverAppBar(
                  floating: false,
                  pinned: false,
                  expandedHeight: MediaQuery.of(context).size.height.sp * 0.4,
                  backgroundColor: Colors.white,
                  centerTitle: false,
                  stretch: true,
                  leading: const SizedBox(),
                  leadingWidth: 0,

                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0.sp),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // عکس پروفایل
                                GestureDetector(
                                  onTap: (){
                                    getImage();
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // حاشیه سفید عکس پروفایل
                                      Container(
                                        height: 150.sp,
                                        width: 150.sp,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: const Offset(0, 0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                      ),

                                      calculateProfilePic(imgFileSrc, imageLoading),

                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.sp),
                                Text(UserModel.name + " " + UserModel.family,
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.sp),
                                Text("کد پرسنلی : " + UserModel.userRoleId,
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),


                ),
              ];
            },

            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0.sp),
                child: Column(
                  children: [
                    SizedBox(height: 16.sp),

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // نام
                          LoginTextFeild(
                              labelText: 'نام',
                              hintText: 'نام خود را وارد کنید',
                              prefixIcon: const Icon(null),
                              controller: _nameCtrl,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              autofillHints: const Iterable.empty(),
                              validator: (String? value){
                                if(value == ""){
                                  return "این فیلد نباید خالی باشد";
                                } else {
                                  return null;
                                }
                              },
                              focusNode: _nameFocusNode,
                              textDirection: TextDirection.rtl,
                              onFieldSubmitted: _familyFocusNode
                          ),
                          SizedBox(height: 40.sp),

                          // فامیلی
                          LoginTextFeild(
                              labelText: 'نام خانوادگی',
                              hintText: 'نام خانوادگی خود را وارد کنید',
                              prefixIcon: const Icon(null),
                              controller: _familyCtrl,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              autofillHints: const Iterable.empty(),
                              validator: (String? value){
                                if(value == ""){
                                  return "این فیلد نباید خالی باشد";
                                } else {
                                  return null;
                                }
                              },
                              focusNode: _familyFocusNode,
                              textDirection: TextDirection.rtl,
                              onFieldSubmitted: _meliFocusNode
                          ),
                          SizedBox(height: 40.sp),

                          // کد ملی
                          LoginTextFeild(
                              labelText: 'کد ملی',
                              hintText: 'کد ملی خود را وارد کنید',
                              prefixIcon: const Icon(null),
                              controller: _meliCodeCtrl,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              autofillHints: const Iterable.empty(),
                              validator: (String? value){
                                if(value == ""){
                                  return "این فیلد نباید خالی باشد";
                                } else {
                                  return null;
                                }
                              },
                              focusNode: _meliFocusNode,
                              textDirection: TextDirection.ltr,
                              onFieldSubmitted: _emailFocusNode
                          ),
                          SizedBox(height: 40.sp),

                          // ایمیل
                          LoginTextFeild(
                              labelText: 'ایمیل',
                              hintText: 'ایمیل خود را وارد کنید',
                              prefixIcon: const Icon(null),
                              controller: _emailCtrl,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const Iterable.empty(),
                              validator: (String? value){
                                return null;
                              },
                              focusNode: _emailFocusNode,
                              textDirection: TextDirection.ltr,
                              onFieldSubmitted: _userNameFocusNode
                          ),
                          SizedBox(height: 40.sp),

                          // عنوان نام کاربری
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.sp, vertical: 16.0.sp),
                            child: Text("نام کاربری",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.sp),


                          // نام کاربری
                          LoginTextFeild(
                            labelText: 'نام کاربری',
                            hintText: 'نام کاربری را وارد کنید',
                            prefixIcon: const Icon(null),
                            controller: _userNameCtrl,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            autofillHints: const Iterable.empty(),
                            validator: (String? value){
                              if(value == ""){
                                return "این فیلد نباید خالی باشد";
                              } else {
                                return null;
                              }
                            },
                            focusNode: _userNameFocusNode,
                            textDirection: TextDirection.ltr,
                            onFieldSubmitted: null
                          ),
                          SizedBox(height: 40.sp),


                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),

      bottomNavigationBar: pageLoading
      ? const SizedBox(height: 0)
      :
      SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 105.sp,
          color: const Color(0xFFFBFBFD),
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),
          // دکمه ثبت مرخصی
          child: GestureDetector(
            onTap: (){
              if(_formKey.currentState!.validate()){
                if(imageLoading == false){
                  editPersonelProfile(_nameCtrl.text, _familyCtrl.text, _meliCodeCtrl.text, _emailCtrl.text, _userNameCtrl.text, fileName);
                } else {
                  showSimpleNotification(
                    Text("صبر کنید تا عکس پروفایل بارگزاری شود",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black
                        )),
                    background: Colors.grey,
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
                child: buttonLoading
                ? const Center(child: SpinKitThreeBounce(color: Colors.white70, size: 25.0))
                :
                Text("ویرایش",
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


  // دکمه ویرایش
  editPersonelProfile(String name, String family, String nationalCode, String email, String username, String picPath) async {
    setState(() {
      buttonLoading = true;
    });
    var response = await (Services()).editPersonelProfile(name, family, nationalCode, email, username, picPath);
    if (response[0]["res"] == 1) {
      Navigator.of(context).pop();
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white
          )),
        background: Colors.green,
      );
      setState(() {
        buttonLoading = false;
      });
    } else if(response[0]["res"] == -1){
      // setState(() => pageLoading = false);
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white
          )),
        background: Colors.red,
      );
      setState(() {
        buttonLoading = false;
      });
    }
  }


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imgFileSrc = pickedFile.path;
        img = File(imgFileSrc);
        sendImageToServer(img);
      } else {
        print('No image selected.');
      }
    });
  }

  sendImageToServer(File img) async {
    setState(() => imageLoading = true);
    var response = await (Services()).addFile(img);
    if (response[0]["res"] == 1) {
    fileName = response[0]["file_name"];
    setState(() => imageLoading = false);
    } else if(response[0]["res"] == -1){
      // setState(() => pageLoading = false);
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white
          )),
        background: Colors.red,
      );
      setState(() => imageLoading = false);
    }
  }
}
