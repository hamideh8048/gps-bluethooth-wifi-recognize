import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'enter_circle.dart';
class EnterApp extends StatelessWidget {
  EnterApp
      ({ Key? key,
   required this. isEnter, required this. subtitle, required this. deviceType,required this.token,required this.hasDelay})
      : super(key: key);

  String token;
  String subtitle;
  bool hasDelay;
bool foundDevice=false;
  bool isEnter;
  String deviceType;
  bool res=false;
  final FocusNode _explainFocusNode = FocusNode();
  TextEditingController? _explainCtrl=TextEditingController();



  @override
  Widget build(BuildContext mycontext) {
    return Container(
    //height: MediaQuery.of(context).size.width *  1.3 - 32,
    height:hasDelay? MediaQuery.of(mycontext).size.width *  1.62 - 32:MediaQuery.of(mycontext).size.width *  1.3 - 32,
    width: MediaQuery.of(mycontext).size.width *  0.9- 32,
    padding:const EdgeInsets.all(12), //const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black12, width: 0.5),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 15,
          offset: const Offset(10, 10), // changes position of shadow
        ),
      ],
      color: backgroundColor,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child:
  Container(
  height: 42.sp,
  width:42.sp,
  decoration:  BoxDecoration(
      border: Border.all(color: blackColor56),
  borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  child: Center(child:
            IconButton(
                icon: Icon(Icons.close),iconSize: 18,color: blackColor56, onPressed: () { Navigator.of(mycontext).pop();;  },
            )
        ))),
       EnterCircleWidget(mycontext,isEnter),

        const SizedBox(height: 30),
        Text(isEnter?"شما در حال ورود به پردازشگران پرتو  می باشید  ":"شما در حال  خروج از پردازشگران پرتو  می باشید  ",
            style: Theme.of(mycontext).textTheme.bodyText1!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            )
        ),
        const SizedBox(height: 6),
        Padding(padding:EdgeInsets.symmetric(horizontal:40),child:
      Row(
        mainAxisAlignment:hasDelay? MainAxisAlignment.start:MainAxisAlignment.center,
        children: [
        Text( isEnter?"ورود:${subtitle}":"خروج:${subtitle}" ,
          style: Theme.of(mycontext).textTheme.bodyText1!.copyWith(
            fontSize: 12.sp,
            color: blackColor,
             fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
          maxLines: MediaQuery.of(mycontext).size.width *  0.5 - 32 <= 160 ? 1 : 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
          hasDelay? Text("  1ُساعت تاخیر  ",
            style: Theme.of(mycontext).textTheme.bodyText1!.copyWith(
              fontSize: 12.sp,
              color: redColor,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
            maxLines: MediaQuery.of(mycontext).size.width *  0.5 - 32 <= 160 ? 1 : 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ):Container()
        ])),
        const SizedBox(height: 6),
        Text(deviceType,
          style: Theme.of(mycontext).textTheme.bodyText1!.copyWith(
            fontSize: 12.sp,
            color: blackColor,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
          maxLines: MediaQuery.of(mycontext).size.width *  0.5 - 32 <= 160 ? 1 : 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),   const SizedBox(height: 30),
     hasDelay?   Material(
          color: backgroundColor,
          child: TextFormField(
            controller: _explainCtrl,
            keyboardType: TextInputType.text,
            textDirection: TextDirection.rtl,
            autofillHints: const [AutofillHints.name],
            style: Theme.of(mycontext).textTheme.bodyText1,
            scrollPadding: EdgeInsets.only(bottom: Get.height),
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              labelText:!isEnter ?' توضیح تعجیل':"توضیح تاخیر",
              labelStyle: Theme.of(mycontext).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
              hintText: !isEnter ?'  توضیح بابت تعجیل':'  توضیح بابت تاخیر',
              hintStyle: Theme.of(mycontext).textTheme.bodyText1!.copyWith(
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
            ),
            focusNode: _explainFocusNode,
            onFieldSubmitted: null,
          ),
        ):Container(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 5),
            child: GestureDetector(
              onTap: ()async{
                var response2 = await (Services()).addAttendance(token);
                if(response2.length>0){

                if(!isEnter)
                  res=true;
                if(response2[0]["res"] != 1) {
                  if(isEnter)
                  res=true;
                  else
                    res=false;
                   ScaffoldMessenger.of(mycontext).showSnackBar(
                    SnackBar(
                      content: Text("خطا در ثبت تردد"),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }}
            //   Navigator.of(mycontext);
            // Navigator.pop(mycontext, res);
               //  else
               Navigator.pushReplacementNamed(mycontext, "/main_tab_bar");
              },
              child: Container(
                height: 70.sp,
                width: MediaQuery.of(mycontext).size.width,
                decoration:  BoxDecoration(
                    color:isEnter!?  buttonGreenColor:redColor,
                    borderRadius: BorderRadius.all(Radius.circular(40))
                ),
                child: Center(
                  child: Text(isEnter!?"اعلام ورود":"اعلام خروج",
                    style: Theme.of(mycontext).textTheme.bodyText1!.copyWith(
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
      ],
    ),
  );

}

}
