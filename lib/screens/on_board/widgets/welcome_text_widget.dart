import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget welcomeTextWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.45),
        Text("به پریسما",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 60.sp,
              color: Colors.white
          ),

        ),
        const SizedBox(height: 4),
        Text("خوش آمدید",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 38.sp,
              color: Colors.white
          ),
        ),
        SizedBox(height: 24.sp),
        Text("سامانه حضور و غیاب پرسنل با امکان دورکاری و ماموریت",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            // fontWeight: FontWeight.bold,
            // fontSize: 38,
              color: Colors.white
          ),
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.visible,
        ),

      ],
    ),
  );
}
