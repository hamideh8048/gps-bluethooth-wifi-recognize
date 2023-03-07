import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

tsAppBarWidget(BuildContext context) {
  return PreferredSize(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text("فعالیت روزانه",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.sp,
                    ),
                  ),
                  Text("شرح وظایف فعالیت روزانه و گذشته",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      // fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Colors.black38
                    ),
                  ),
                ],
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
  );
}