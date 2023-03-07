import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/models/taradod_list_model.dart';
import 'package:Prismaa/screens/kartabl/taradod/taradod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget trRecordedTasks(
    BuildContext context,
    int index,
    List<TaradodListModel> taradodList,
    ) {
  return Container(
    width: MediaQuery.of(context).size.width,
    // height: 170,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    // padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.3),
      borderRadius: BorderRadius.circular(20),
      color: backgroundColor,
    ),
    child: Column(

      children: [
        // عنوان نام شرکت و آدرس و ساعت ورود و خروج
        Container(
          width: MediaQuery.of(context).size.width,
          height: 80.sp,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            border: Border.all(color: Colors.black.withOpacity(0.2), width: 0.1),
            borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 2.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('نام شرکت : ' + taradodList[index].companyName,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13.sp,
                  // fontWeight: FontWeight.bold,
                ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 4.sp),
              Text('آدرس : ' + taradodList[index].companyAddress,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13.sp,
                  // fontWeight: FontWeight.bold,
                ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 4.sp),

              // ردیف ساعت ورود و خروج
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ساعت ورود : " + taradodList[index].inTime,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 13.sp,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(" | ",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 13.sp,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("ساعت خروج : " + taradodList[index].outTime,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 13.sp,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )

            ],
          )
        ),
        SizedBox(height: 16.sp),

        // کادر های رنگی ورود و خروج از شرکت
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                height: 90.sp,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 5,
                      blurRadius: 8,
                      offset: const Offset(5, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBFAF4),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 0.1, color: const Color(0xFF50BC85))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("ورود به شرکت",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 11.sp,
                                color: const Color(0xFF50BC85)
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(taradodList[index].inTime,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 25.sp,
                              color: const Color(0xFF50BC85),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 18.sp,
                            width: 18.sp,
                            child: Image.asset("assets/images/copy-success.png", fit: BoxFit.fill),
                          ),
                          const SizedBox(width: 8),
                          Text('نوع ثبت : ' + taradodList[index].inDevice,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14.sp,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                height: 90.sp,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 5,
                      blurRadius: 8,
                      offset: const Offset(5, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF7CECD),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 0.1, color: const Color(0xFF50BC85))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("خروج از شرکت",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 11.sp,
                                color: const Color(0xFFBD261A)
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(taradodList[index].outTime,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 25.sp,
                              color: const Color(0xFFBD261A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 18.sp,
                            width: 18.sp,
                            child: Image.asset("assets/images/copy-success.png", fit: BoxFit.fill),
                          ),
                          const SizedBox(width: 8),
                          Text('نوع ثبت : ' + taradodList[index].inDevice,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14.sp,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        Container(
          height: 70.sp, width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(16.sp),
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 6.sp),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15.sp)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(taradodList[index].delay,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13.sp,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.sp),
              Text(taradodList[index].reasonHurry,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13.sp,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

      ],
    ),
  );
}