import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piccolo/constants.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_create_pallet_screen.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_order_screen.dart';
import 'package:piccolo/screens/pallet_management/increase_capacity_screen.dart';
import 'package:piccolo/screens/pallet_management/sku_return_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/widgets/buttons.dart';

class FinishedGoodsManageScreen extends StatefulWidget {
  const FinishedGoodsManageScreen({super.key});

  @override
  State<FinishedGoodsManageScreen> createState() => _FinishedGoodsManageScreenState();
}

class _FinishedGoodsManageScreenState extends State<FinishedGoodsManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              Container(
                height: AppBar().preferredSize.height + 15,
                width: 100.w,
                color: Constants.primaryOrangeColor,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    Text(
                      "FINISHED GOODS PALLET",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.1),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    SizedBox(height: 3.h),
                    InkWell(
                      onTap: (){
                        Get.to(() => const FinishedGoodsCreatePalletScreen());
                      },
                      child: CommonButtons.primaryOrangeFilledButton(
                          "CREATE PALLET", null),
                    ),
                    SizedBox(height: 3.h),
                    InkWell(
                      onTap: (){
                        Get.to(() => const FinishedGoodsOrderScreen());
                      },
                      child: CommonButtons.primaryOrangeFilledButton(
                          "ORDER COMPLETE", null),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
