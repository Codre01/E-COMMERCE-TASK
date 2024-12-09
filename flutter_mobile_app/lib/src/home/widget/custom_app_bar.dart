import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/src/adresses/hooks/fetch_default.dart';
import 'package:minified_commerce/src/entry_point/views/widgets/notification_widget.dart';

class CustomAppBar extends HookWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchDefaultAddress();
    final address = result.address;
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: ReusableText(
                text: "Location",
                style: appStyle(12, Kolors.kGray, FontWeight.normal)),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              const Icon(Icons.location_on, color: Kolors.kPrimary, size: 16),
              SizedBox(
                width: ScreenUtil().screenWidth * 0.7,
                child: Text(
                  address == null ? "Please select a location" : address.address,
                  maxLines: 1,
                  style: appStyle(14, Kolors.kDark, FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
      actions: [
        const NotificationWidget(),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: GestureDetector(
          onTap: () {
            context.go("/search");
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Container(
                    height: 40.h,
                    width: ScreenUtil().screenWidth - 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: Kolors.kGrayLight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Ionicons.search,
                            size: 20,
                            color: Kolors.kPrimaryLight,
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        ReusableText(
                          text: "Search Products",
                          style: appStyle(14, Kolors.kGray, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Kolors.kPrimary,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Icon(
                      FontAwesome.sliders,
                      color: Kolors.kWhite,
                      size: 20,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
