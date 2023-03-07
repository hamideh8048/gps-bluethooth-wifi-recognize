import 'package:Prismaa/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class TrafficWidget extends StatelessWidget {
   String? text;
   String? imgUrl;
   bool enable;
  // Notice the variable type

   VoidCallback? callback; // Notice the variable type
   TrafficWidget ({ Key? key,required this.text,this.imgUrl,required this.callback,required this.enable
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          // Container(
          //   height: 270.sp,
          //   width: 270.sp,
          //   decoration: BoxDecoration(
          //     color: backgroundColor,
          //     borderRadius: BorderRadius.circular(150),
          //     gradient: const LinearGradient(
          //       colors: [
          //         Color(0xFF3A3D49),
          //         Color(0xFF3F424F),
          //       ],
          //       begin: FractionalOffset(0.0, 0.5),
          //       stops: [0.0, 1.0],
          //     ),
          //   ),
          // ),
          CircleAvatar(
            radius: 80.sp,
            backgroundColor:backgroundColor,child:
          CircleAvatar(
            radius: 55.sp,
            backgroundColor:greyColor,//backgroundColor,//blackColor57,//greyColor,///greyColor,
      child: CircleAvatar(
        backgroundColor:backgroundColor,//backgroundColor,
        radius: 60,
        ),
          )),
          GestureDetector(
            onTap: ()async{

             callback!() ;
            },child:
          CircularPercentIndicator(
            radius: 81.sp,
            lineWidth: 12.0,
            backgroundWidth: 1,
            animation: true,
            percent: 1,
            backgroundColor: Colors.black12,
            linearGradient:  LinearGradient(
              colors: [
                Color(0xFF3A3E4B),
                Color(0xFF424654),
              ]
            ),
            center: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child:

                  Image.asset(imgUrl!, fit: BoxFit.fill,color: blackColor57,),
                ),
            SizedBox(
              height: 5),
                Text(text!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color:blackColor55,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                  ),
                ),
                const SizedBox(height: 8),

              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
          )),
          //SizedBox(height: 250,)
        ],
      ),

    ],
  );

  }
}

// Widget TrafficWidget(BuildContext context,   onClick<String> onChanged) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Stack(
//         alignment: Alignment.center,
//         children: [
//
//           CircleAvatar(
//             radius: 55.sp,
//             backgroundColor:greyColor,///greyColor,
//       child: CircleAvatar(
//         backgroundColor:backgroundColor,
//         radius: 50,
//         ),
//           ),
//           CircularPercentIndicator(
//             radius: 81.sp,
//             lineWidth: 12.0,
//             backgroundWidth: 1,
//             animation: true,
//             percent: 1,
//             backgroundColor: Colors.black12,
//             linearGradient:  LinearGradient(
//               colors: [
//                 Color(0xFF3A3E4B),
//                 Color(0xFF424654),
//               ]
//             ),
//             center: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 28,
//                   width: 26,
//                   child: Image.asset("assets/images/enter.png", fit: BoxFit.fill,color: blackColor57,),
//                 ),
//                 Text("تردد دستی",
//                   style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                     color:blackColor55,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 15.sp,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//
//               ],
//             ),
//             circularStrokeCap: CircularStrokeCap.round,
//           ),
//         ],
//       ),
//
//     ],
//   );
// }