import 'dart:io';
import 'package:Prismaa/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


Widget calculateProfilePic(String imgFileSrc, bool imageLoading) {
  return Stack(
    alignment: AlignmentDirectional.center,
    children: [
      // تصویر پروفایل
      imgFileSrc == "" && UserModel.picPath != ""
          ?
      CachedNetworkImage(
        imageUrl: UserModel.picPath,
        imageBuilder: (context, imageProvider) => Container(
          height: 135.sp,
          width: 135.sp,
          // padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: NetworkImage(UserModel.picPath),
              fit: BoxFit.fill,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0)),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      )
          :
      imgFileSrc != "" && UserModel.picPath == ""
          ?
      imageLoading
          ? const Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0))
          :
      Container(
        height: 135.sp,
        width: 135.sp,
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            image: FileImage(File(imgFileSrc)),
            fit: BoxFit.fill,
          ),
        ),
      )
          :
      imgFileSrc != "" && UserModel.picPath != ""
          ?
      imageLoading
          ? const Center(child: SpinKitThreeBounce(color: Colors.black12, size: 25.0))
          :
      Container(
        height: 135.sp,
        width: 135.sp,
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            image: FileImage(File(imgFileSrc)),
            fit: BoxFit.fill,
          ),
        ),
      )
          :
      Container(
        height: 135.sp,
        width: 135.sp,
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: const DecorationImage(
            image: AssetImage("assets/images/user_avatar.png"),
            fit: BoxFit.fill,
          ),
        ),
      )
      ,

      // آیکن ادیت
      Container(
        height: 35.sp,
        width: 35.sp,
        padding: EdgeInsets.all(6.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white.withOpacity(0.4),
        ),
        child: Center(
          child: Image.asset("assets/images/edit_icon.png", fit: BoxFit.cover),
        ),
      ),
    ],
  );
}