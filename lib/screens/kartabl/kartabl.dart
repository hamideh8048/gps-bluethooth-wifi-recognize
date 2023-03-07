import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/user_model.dart';
import 'package:Prismaa/screens/kartabl/mission/mission.dart';
import 'package:Prismaa/screens/kartabl/morkhasi/morkhasi.dart';
import 'package:Prismaa/screens/kartabl/taradod/taradod.dart';
import 'package:Prismaa/screens/kartabl/task_management/task_management.dart';
import 'package:Prismaa/screens/kartabl/widgets/kartabl_items.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Kartabl extends StatefulWidget {
  const Kartabl({Key? key}) : super(key: key);

  @override
  State<Kartabl> createState() => KartablState();
}

class KartablState extends State<Kartabl> {
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
                          Text("کارتابل و فعالیت ها",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 26.sp,
                            ),
                          ),
                          Text("مدیریت کارتابل و ثبت مرخصی و تاخیر",
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

      body: Container(
        padding: EdgeInsets.only(top: 40.sp, bottom: 20, right: 20, left: 20),
        color: backgroundColor,
        child: GridView.count(
          primary: false,
          padding: EdgeInsets.zero,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 2,
          children: <Widget> [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/kartabl_task_management"),
              child: kartablItems(context, "فعالیت روزانه", "شرح وظایف فعالیت روزانه و گذشته", "assets/images/briefcase_kartabl.png"),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/kartabl_morkhasi"),
              child: kartablItems(context, "مرخصی", "ثبت و مشاهده مرخصی و تاخیر", "assets/images/task-square_kartabl.png"),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/kartabl_mission"),
              child: kartablItems(context, "ماموریت", "ثبت و مشاهده ماموریت", "assets/images/driving_kartabl.png"),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/kartabl_taradod"),
              child: kartablItems(context, "تردد", "گزارش تردد های ثبت  شده", "assets/images/routing-2_kartabl.png"),
            ),
          ]
        ),
      ),
    );
  }

}
