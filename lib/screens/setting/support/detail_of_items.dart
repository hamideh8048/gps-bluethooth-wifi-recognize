import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/components/user_controller.dart';
import 'package:Prismaa/models/support_model.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/setting/support/support.dart';
import 'package:Prismaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shamsi_date/shamsi_date.dart';

// ignore: must_be_immutable
class DetailOfItems extends StatefulWidget {
  List<SupportModel> supportItemsList;
  int index;

  DetailOfItems(this.supportItemsList, this.index, {Key? key}) : super(key: key);

  @override
  State<DetailOfItems> createState() => DetailOfItemsState();
}

class DetailOfItemsState extends State<DetailOfItems> {
  bool buttonLoading = false;
  final TextEditingController _responseCtrl = TextEditingController();
  final FocusNode _responseFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  List<SupportModelMessages> supportMessagesItemsList = [];
  bool pageLoading = true;


  @override
  void initState() {
    super.initState();
    getSupportMessagesItems();
  }

  getSupportMessagesItems() async {
    var response = await (Services()).getSupportMessagesItems(UserModel.mainToken, widget.supportItemsList[widget.index].id);

    supportMessagesItemsList.clear();
    // if(response[0]["res"] == 1){
    setState(() {
      response.forEach((element){
        supportMessagesItemsList.add(SupportModelMessages.fromJson(element));
      });
      pageLoading = false;
    });
    // } else if(response[0]["res"] == -1){
    //   logOut();
    //   Navigator.pushReplacementNamed(context, "/login");
    // } else {
    //   String result = response[0]['msg'];
    //   showSimpleNotification(
    //     Text(result, style: Theme.of(context).textTheme.bodyText1!.copyWith(
    //           color: Colors.white,
    //         )),
    //     background: Colors.red,
    //   );
    //   setState(() => pageLoading = false);
    // }
  }

  @override
  void dispose() {
    _responseFocusNode.dispose();
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
                  Text("تیکت",
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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
        child: Column(
          children: [
            // بخش عنوان تیکت
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.supportItemsList[widget.index].subject,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.sp),
                    Text(widget.supportItemsList[widget.index].departmentName,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 13.sp,
                        color: Colors.grey
                      ),
                    )
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(widget.supportItemsList[widget.index].date,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14.sp,
                          color: Colors.black54
                      ),
                    ),
                    SizedBox(height: 8.sp),

                    // وضعیت انتظار
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 6.sp),
                      decoration: BoxDecoration(
                        // border: Border.all(color: cardItemModelList[index].colorButton!, width: 0.5),
                        border: Border.all(
                            color: widget.supportItemsList[widget.index].status == "در انتظار پاسخ" ? Colors.grey : widget.supportItemsList[widget.index].status == "پاسخ داده شده" ? Colors.green : Colors.red,
                            width: 0.5
                        ),
                        borderRadius: BorderRadius.circular(30.sp),
                        color: widget.supportItemsList[widget.index].status == "در انتظار پاسخ" ? Colors.grey.withOpacity(0.1) : widget.supportItemsList[widget.index].status == "پاسخ داده شده" ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Text(widget.supportItemsList[widget.index].status,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 11.sp,
                            color: widget.supportItemsList[widget.index].status == "در انتظار پاسخ" ? Colors.grey : widget.supportItemsList[widget.index].status == "پاسخ داده شده" ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 24.sp),

            pageLoading
            ?   const Expanded(child: Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0)))
            :
                Expanded(
                  child: ListView.builder(
                    itemCount: supportMessagesItemsList.length,
                    itemBuilder: (context, index){
                      return cardItems(supportMessagesItemsList, index);
                    }
                  ),
                ),
          ],
        ),
      ),

      bottomNavigationBar: pageLoading
      ?   SizedBox(height: 105.sp)
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
                  openButtonSheet();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text("ارسال پاسخ",
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

  // String dateCalc(Jalali? date){
  //   String dateCalc = date!.year.toString() + "/" + date.month.toString() + "/" + date.day.toString();
  //   String timeCalc = date.hour.toString() + ":" + date.minute.toString();
  //   return timeCalc + " - " + dateCalc;
  // }

  Widget cardItems(List<SupportModelMessages> supportMessagesItemsList, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.all(16.sp),
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 0.8),
        borderRadius: BorderRadius.circular(15.sp),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عناوین بالای کارد
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.only(topRight: Radius.circular(15.sp), topLeft: Radius.circular(15.sp))
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // آواتار
                Container(
                  width: 45.sp, height: 45.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.sp),
                    image: const DecorationImage(
                      // image: AssetImage("assets/images/" + cardItemModelList2[index].avatar!),
                      image: AssetImage("assets/images/user_avatar.png"),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                SizedBox(width: 12.sp),

                // عنوان
                Text(supportMessagesItemsList[index].sender,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 13.sp,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),

                // تاریخ
                Text(supportMessagesItemsList[index].date,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 13.sp,
                      color: Colors.black.withOpacity(0.7)
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.sp),

          // متن درون کارد
          Padding(
            padding: EdgeInsets.only(left: 16.0.sp, right: 16.0.sp, top: 8.0.sp, bottom: 16.0.sp),
            child: Text(supportMessagesItemsList[index].message,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13.sp,
                  color: Colors.black.withOpacity(0.8)
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }


  void openButtonSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  // height: MediaQuery.of(context).size.height < 670 ? 660 : 730,
                  color: backgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // شکل بالای صفحه
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 47,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black.withOpacity(0.08),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.sp),

                        Text("ارسال پاسخ به تیکت، عدم واریز وجه پورسانت",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          softWrap: true,
                        ),
                        SizedBox(height: 32.sp),

                        // پاسخ شما
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _responseCtrl,
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
                              labelText: ' پاسخ شما ',
                              labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.sp),
                              hintText: 'پاسخ خود را کامل وارد کنید',
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
                            focusNode: _responseFocusNode,
                            onFieldSubmitted: (String value) {
                              FocusScope.of(context).requestFocus(null);
                            },
                          ),
                        ),
                        SizedBox(height: 140.sp),
                      ],
                    ),
                  ),
                ),

                SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      if(_formKey.currentState!.validate()){
                        sendTicketResponseToServer(_responseCtrl.text);
                      }
                    },
                    child: Container(
                      height: 70.sp,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 4),
                      child: buttonLoading
                          ? const Center(child: SpinKitThreeBounce(color: Colors.white60, size: 25.0))
                          :
                      Center(
                        child: Text("ثبت پاسخ",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        );
      }
    );
  }

  sendTicketResponseToServer(String message) async {
    setState(() => buttonLoading = true);
    var response = await (Services()).sendSupportRequestRecordToServer(widget.supportItemsList[widget.index].subject, message, widget.supportItemsList[widget.index].id);

    if(response[0]["res"] == 1){
      setState(() => buttonLoading = false);
      Navigator.of(context).pop();
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.white,
          )),
        background: Colors.lightGreen,
      );
      setState(() {
        getSupportMessagesItems();
      });
    } else if(response[0]["res"] == -1) {
      logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      setState(() => buttonLoading = false);
      Navigator.of(context).pop();
      String result = response[0]['msg'];
      showSimpleNotification(
        Text(result,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.white,
          )),
        background: Colors.red,
      );
    }

  }

}

