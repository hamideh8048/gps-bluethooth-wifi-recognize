import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/screens/mali/widgets/mali_report_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VarizBardashtReport extends StatefulWidget {
  const VarizBardashtReport({Key? key}) : super(key: key);

  @override
  State<VarizBardashtReport> createState() => VarizBardashtReportState();
}

class VarizBardashtReportState extends State<VarizBardashtReport> {
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
                        child: Image.asset("assets/images/arrow_back.png")),
                  ),
                  SizedBox(width: 20.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.sp),
                      Text("لیست واریز و برداشت",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 26.sp,
                        ),
                      ),
                      Text("ثبت و مشاهده مرخصی و تاخیر",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          // fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index){
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      height: 50.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                        image: const DecorationImage(image: AssetImage("assets/images/bardasht_movafagh.png"), fit: BoxFit.fill),
                        color: const Color(0xFFB8EFD8),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    title: Text("برداشت موفق",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("درخواست شماره ۲۴۵۱",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13.sp,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black38
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("۲۵،۵۰۰،۰۰۰",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("امروز ۲۵ مرداد ۱۴۰۰",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 13.sp,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black26
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black26, thickness: 0.2, height: 8,),
                ],
              );
            }
        ),
      ),
    );
  }
}
