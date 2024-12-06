import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/tab_widget.dart';
import 'package:minified_commerce/src/home/views/home_screen.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key, required TabController tabController})
      : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 22.h,
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: Kolors.kPrimary,
            borderRadius: BorderRadius.circular(25.h),
          ),
          labelPadding: EdgeInsets.zero,
          labelColor: Kolors.kWhite,
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          labelStyle: appStyle(11, Kolors.kPrimary, FontWeight.w600),
          unselectedLabelStyle: appStyle(11, Kolors.kGray, FontWeight.normal),
          tabs: List.generate(
            homeTabs.length,
            (index) => Tab(
              child: TabWidget(
                text: homeTabs[index],
              ),
            ),
          ),
        ));
  }
}