import 'package:Prismaa/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shamsi_date/shamsi_date.dart';

Widget appBarWidget(String username, BuildContext context, Jalali jNow) {
  return Row(
    children: [
      const SizedBox(width: 8),
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
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$username ، خوش آمدید",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )
          ),
          const SizedBox(height: 6),
          Text("امروز : " + getToday(jNow),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white54,
              fontSize: 14.sp,
            )
          ),
        ],
      ),
      const Spacer(),
      InkWell(
        onTap: (){},
        child: SizedBox(
          width: 33.sp,
          height: 33.sp,
          child: Image.asset("assets/images/export_white.png", fit: BoxFit.fill),
        ),
      ),
      SizedBox(width: 20.sp),
      InkWell(
        onTap: (){},
        child: SizedBox(
          width: 25.sp,
          height: 25.sp,
          child: Image.asset("assets/images/notification_kartabl2.png", fit: BoxFit.fill),
        ),
      ),
      // const SizedBox(width: 16),
      // Container(
      //   height: 45,
      //   width: 45,
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      //   child: Center(
      //     child: SizedBox(
      //       width: 20,
      //       height: 20,
      //       child: Image.asset("assets/images/category.png", fit: BoxFit.fill),
      //     ),
      //   ),
      // )
      const SizedBox(width: 8),
    ],
  );
}

String getToday(Date d) {
  final f = d.formatter;
  return '${f.d} ${f.mN} ${f.yyyy}';
}