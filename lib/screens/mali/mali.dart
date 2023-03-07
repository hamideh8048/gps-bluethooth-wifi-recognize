import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/mali/widgets/mali_report_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Mali extends StatefulWidget {
  const Mali({Key? key}) : super(key: key);

  @override
  State<Mali> createState() => MaliState();
}

class MaliState extends State<Mali> {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text("مالی و پورسانت",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 26.sp,
                            ),
                          ),
                          Text("موجودی و درخواست  پورسانت",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              // fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: Colors.black38
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      UserModel.picPath != ""
                      ?
                      CachedNetworkImage(
                        imageUrl: UserModel.picPath,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(UserModel.picPath),
                        ),
                        placeholder: (context, url) => const Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0)),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      )
                      :
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("assets/images/user_avatar.png"),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        height: 30.sp,
                        width: 28.sp,
                        child: Image.asset("assets/images/notification_kartabl.png", fit: BoxFit.fill),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
      ),


      body: NestedScrollView(
        headerSliverBuilder: (context, value){
          return [
            SliverAppBar(
              floating: false,
              pinned: false,
              expandedHeight: MediaQuery.of(context).size.height.sp * 0.4,
              backgroundColor: Colors.white,
              centerTitle: false,
              stretch: true,

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
                            Text("۱۵،۶۵۰،۰۰۰",
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
                            SizedBox(height: 24.sp),

                            // دکمه های درخواست برداشت و گزارش واریزی ها
                            Row(
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: SizedBox()
                                ),

                                // دکمه درخواست برداشت
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, "/mali_request_for_payment");
                                    },
                                    child: Container(
                                      height: 55.sp,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2E62F6),
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Center(
                                        child: Text("درخواست برداشت",
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const Expanded(
                                    flex: 1,
                                    child: SizedBox()
                                ),

                                // گزارش واریزی ها
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, "/mali_v_b_report");
                                    },
                                    child: Container(
                                      height: 55.sp,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF19E38),
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Center(
                                        child: Text("گزارش واریزی ها",
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const Expanded(
                                    flex: 2,
                                    child: SizedBox()
                                ),

                              ],
                            ),
                            SizedBox(height: 30.sp),


                          ],
                        )
                      ),
                    )
                  ],
                ),
              ),


            ),
          ];
        },


        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Column(
            children: [
              // عنوان واریز و برداشت
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("واریز و برداشت",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("مشاهده همه",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      // fontWeight: FontWeight.bold,
                        color: Colors.black38,
                        fontSize: 16.sp
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.sp),

              // لیست آیتم های واریز و برداشت
              maliReportList(),

            ],
          ),
        ),
      ),

    );
  }



}


