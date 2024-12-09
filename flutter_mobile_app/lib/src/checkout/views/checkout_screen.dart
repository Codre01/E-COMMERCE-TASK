import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/utils/kstrings.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/back_button.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/const/constants.dart';
import 'package:minified_commerce/src/adresses/controllers/address_notifier.dart';
import 'package:minified_commerce/src/adresses/hooks/fetch_default.dart';
import 'package:minified_commerce/src/adresses/widget/address_block.dart';
import 'package:minified_commerce/src/cart/controllers/cart_notifier.dart';
import 'package:minified_commerce/src/checkout/widgets/checkout_tile.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends HookWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchDefaultAddress();
    final address = result.address;
    final isLoading = result.isLoading;
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.read<AddressNotifier>().clearAddress();
            context.pop();
          },
        ),
        centerTitle: true,
        title: ReusableText(
            text: AppText.kCheckout,
            style: appStyle(18, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            children: [
              isLoading
                  ? const SizedBox.shrink()
                  : AddressBlock(address: address),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: ScreenUtil().screenHeight * 0.5,
                child: Column(
                  children:
                      List.generate(cartNotifier.selectedCartItems.length, (i) {
                    return CheckoutTile(
                      cart: cartNotifier.selectedCartItems[i],
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              height: 80,
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                color: Kolors.kPrimary,
                borderRadius: kRadiusAll,
              ),
              child: Center(
                child: ReusableText(
                  text: address == null
                      ? "Please select an address"
                      : "Continue to Payment",
                  style: appStyle(16, Kolors.kWhite, FontWeight.w600),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
