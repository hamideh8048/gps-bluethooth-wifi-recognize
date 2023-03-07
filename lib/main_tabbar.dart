import 'dart:math';
import 'package:Prismaa/components/constants.dart';
import 'package:Prismaa/screens/home_page/home_page.dart';
import 'package:Prismaa/screens/kartabl/kartabl.dart';
import 'package:Prismaa/screens/mali/mali.dart';
import 'package:Prismaa/screens/setting/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Prismaa/main_tabbar_global.dart' as main_tabbar_global;


class MainTabBar extends StatefulWidget{
  const MainTabBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainTabBarState();

}
class MainTabBarState extends State<MainTabBar> with SingleTickerProviderStateMixin{
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: backgroundColor,

        body: TabBarView(
          controller: _tabController!,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePage(),
            Kartabl(),
            Mali(),
            Setting(),
          ],
        ),

        bottomNavigationBar: SafeArea(
          child: Container(
            height: 100.sp,
            color: backgroundColor,
            child: Column(
              children: [
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 6.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                          color: _tabController!.index == 0 ? Colors.black : Colors.transparent,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                      ),
                    ),

                    Container(
                      height: 6.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                          color: _tabController!.index == 1 ? Colors.black : Colors.transparent,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                      ),
                    ),
                    Container(
                      height: 6.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                          color: _tabController!.index == 2 ? Colors.black : Colors.transparent,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                      ),
                    ),
                    Container(
                      height: 6.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                          color: _tabController!.index == 3 ? Colors.black : Colors.transparent,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(width: 0.5, color: Colors.black12))
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.transparent,
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    labelColor: Colors.black,
                    unselectedLabelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black38
                    ),
                    unselectedLabelColor: Colors.black38,
                    onTap: (value){
                      setState(() {});
                    },
                    tabs: [
                      Column(
                        children: [
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 26.sp,
                            height: 26.sp,
                            child: _tabController!.index == 0
                                ? Image.asset("assets/images/dashboard_select.png",
                              fit: BoxFit.fill,
                              color: Colors.black87,
                            )
                                : Image.asset("assets/images/dashboard_unselect.png",
                              fit: BoxFit.fill,
                              color: Colors.black38,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("داشبورد",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: _tabController!.index == 0 ? Colors.black87 : Colors.black38,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 22.sp,
                            height: 24.sp,
                            child: _tabController!.index == 1
                                ? Image.asset("assets/images/document_select.png",
                              fit: BoxFit.fill,
                              color: Colors.black87,
                            )
                                : Image.asset("assets/images/document_unselect.png",
                              fit: BoxFit.fill,
                              color: Colors.black38,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("کارتابل",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: _tabController!.index == 1 ? Colors.black87 : Colors.black38,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 25.sp,
                            height: 25.sp,
                            child: _tabController!.index == 2
                                ? Image.asset("assets/images/statistic_select.png",
                              fit: BoxFit.fill,
                              color: Colors.black87,
                            )
                                : Image.asset("assets/images/statistic_unselect.png",
                              fit: BoxFit.fill,
                              color: Colors.black38,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("مالی",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: _tabController!.index == 2 ? Colors.black87 : Colors.black38,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 29.sp,
                            height: 29.sp,
                            child: _tabController!.index == 3
                                ? Image.asset("assets/images/setting_select.png",
                              fit: BoxFit.fill,
                              color: Colors.black87,
                            )
                                : Image.asset("assets/images/setting_unselect.png",
                              fit: BoxFit.fill,
                              color: Colors.black38,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("تنظیمات",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: _tabController!.index == 3 ? Colors.black87 : Colors.black38,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        )
      ),
    );
  }

  Widget tabWidget(String title, int index, bool selected, ){

    return Column(
      children: [
        const SizedBox(height: 8),
        SizedBox(
          width: 26,
          height: 26,
          child: index == 0
          ? Image.asset("assets/images/document_select.png",
            fit: BoxFit.fill,
            color: Colors.black87,
          )
          : Image.asset("assets/images/document_unselect.png",
            fit: BoxFit.fill,
            color: Colors.black38,
          ),
        ),
        const SizedBox(height: 8),
        Text(title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: selected ? Colors.black87 : Colors.black38,
            fontSize: 15.sp
          ),
        )
      ],
    );
  }
}
