import 'package:Prismaa/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fade_shimmer/fade_shimmer.dart';


// ignore: must_be_immutable
class ShimmerScreen extends StatelessWidget {
  Color highlightColor = Colors.grey;
  Color baseColor = const Color(0xffE6E8EB);
  int millisecondsDelay = 300;

  ShimmerScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(23.0),
        child: AppBar(
          backgroundColor: const Color(0xFF2B2E34),
          elevation: 0,
          leadingWidth: 0,
          leading: const SizedBox(),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        child: Stack(
          children: [
            // تصویر بک گراند
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/images/home_page_background.png", fit: BoxFit.fill),
            ),

            SizedBox(
                height: Get.height,
                width: Get.width,
                // padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        FadeShimmer.round(
                          size: 60.sp,
                          fadeTheme: FadeTheme.light,
                          millisecondsDelay: millisecondsDelay,
                          highlightColor: highlightColor,
                          baseColor: baseColor,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeShimmer(
                              height: 10.sp,
                              width: 150.sp,
                              radius: 4.sp,
                              millisecondsDelay: millisecondsDelay,
                              highlightColor: highlightColor,
                              baseColor: baseColor,
                            ),
                            const SizedBox(height: 6),
                            FadeShimmer(
                              height: 10.sp,
                              width: 120.sp,
                              radius: 4.sp,
                              millisecondsDelay: millisecondsDelay,
                              highlightColor: highlightColor,
                              baseColor: baseColor,
                            ),
                          ],
                        ),
                        const Spacer(),
                        FadeShimmer.round(
                          size: 30.sp,
                          fadeTheme: FadeTheme.light,
                          millisecondsDelay: millisecondsDelay,
                          highlightColor: highlightColor,
                          baseColor: baseColor,
                        ),
                        SizedBox(width: 20.sp),
                        FadeShimmer.round(
                          size: 30.sp,
                          fadeTheme: FadeTheme.light,
                          millisecondsDelay: millisecondsDelay,
                          highlightColor: highlightColor,
                          baseColor: baseColor,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    SizedBox(height: 20.sp),

                    // دایره وسط، تایم باقی مانده تا پایان کار
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            FadeShimmer.round(
                              size: 230.sp,
                              fadeTheme: FadeTheme.light,
                              millisecondsDelay: millisecondsDelay,
                              highlightColor: highlightColor.withOpacity(0.1),
                              baseColor: baseColor,
                            ),
                            CircleAvatar(
                              radius: 93.sp,
                              backgroundColor: backgroundColor,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeShimmer(
                                  height: 12.sp,
                                  width: 100.sp,
                                  radius: 4.sp,
                                  millisecondsDelay: millisecondsDelay,
                                  highlightColor: highlightColor.withOpacity(0.1),
                                  baseColor: baseColor,
                                ),
                                const SizedBox(height: 16),

                                FadeShimmer(
                                  height: 16.sp,
                                  width: 120.sp,
                                  radius: 8.sp,
                                  millisecondsDelay: millisecondsDelay,
                                  highlightColor: highlightColor.withOpacity(0.1),
                                  baseColor: baseColor,
                                ),



                                const SizedBox(height: 16),
                                FadeShimmer(
                                  height: 10.sp,
                                  width: 80.sp,
                                  radius: 4.sp,
                                  millisecondsDelay: millisecondsDelay,
                                  highlightColor: highlightColor.withOpacity(0.1),
                                  baseColor: baseColor,
                                ),
                                const SizedBox(height: 16),
                                FadeShimmer(
                                  height: 10.sp,
                                  width: 50.sp,
                                  radius: 4.sp,
                                  millisecondsDelay: millisecondsDelay,
                                  highlightColor: highlightColor.withOpacity(0.1),
                                  baseColor: baseColor,
                                ),
                              ],
                            )
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 60.sp),

                    Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 20.sp),
                              // باکس آدرس
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 32.sp),
                                child: FadeShimmer(
                                  height: 40.sp,
                                  width: Get.width,
                                  radius: 12.sp,
                                  millisecondsDelay: millisecondsDelay,
                                  highlightColor: highlightColor.withOpacity(0.1),
                                  baseColor: baseColor,
                                ),
                              ),
                              const SizedBox(height: 32),

                              // طراحی ویجت سمت کارمندان
                              Container(
                                width: MediaQuery.of(context).size.width,
                                // height: 170,
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    // ساعت ورود
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        FadeShimmer.round(
                                          size: 60.sp,
                                          fadeTheme: FadeTheme.light,
                                          millisecondsDelay: millisecondsDelay,
                                          highlightColor: highlightColor.withOpacity(0.1),
                                          baseColor: baseColor,
                                        ),
                                        const SizedBox(height: 16),
                                        FadeShimmer(
                                          height: 16.sp,
                                          width: 130.sp,
                                          radius: 4.sp,
                                          millisecondsDelay: millisecondsDelay,
                                          highlightColor: highlightColor.withOpacity(0.1),
                                          baseColor: baseColor,
                                        ),
                                        const SizedBox(height: 20),
                                        FadeShimmer(
                                          height: 12.sp,
                                          width: 100.sp,
                                          radius: 4.sp,
                                          millisecondsDelay: millisecondsDelay,
                                          highlightColor: highlightColor.withOpacity(0.1),
                                          baseColor: baseColor,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 90.sp,
                                      width: 1.sp,
                                      color: Colors.black12,
                                    ),
                                    // ساعت خروج
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        FadeShimmer.round(
                                          size: 60.sp,
                                          fadeTheme: FadeTheme.light,
                                          millisecondsDelay: millisecondsDelay,
                                          highlightColor: highlightColor.withOpacity(0.1),
                                          baseColor: baseColor,
                                        ),
                                        const SizedBox(height: 16),
                                        FadeShimmer(
                                          height: 16.sp,
                                          width: 130.sp,
                                          radius: 4.sp,
                                          millisecondsDelay: millisecondsDelay,
                                          highlightColor: highlightColor.withOpacity(0.1),
                                          baseColor: baseColor,
                                        ),
                                        const SizedBox(height: 20),
                                        FadeShimmer(
                                          height: 12.sp,
                                          width: 100.sp,
                                          radius: 4.sp,
                                          millisecondsDelay: millisecondsDelay,
                                          highlightColor: highlightColor.withOpacity(0.1),
                                          baseColor: baseColor,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )

                            ],
                          ),
                        )
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
