import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:piccolo/constants.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_create_pallet_screen.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_order_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../GlobalVariables.dart';
import '../../common/widgets/buttons.dart';
import '../pallet_management/login_screen.dart';

class FinishedGoodsManageScreen extends StatefulWidget {
  const FinishedGoodsManageScreen({super.key});

  @override
  State<FinishedGoodsManageScreen> createState() =>
      _FinishedGoodsManageScreenState();
}

class _FinishedGoodsManageScreenState extends State<FinishedGoodsManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constants.primaryOrangeColor,
        title: Text(
          "Finished Goods Pallet",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  SizedBox(height: 3.h),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const FinishedGoodsCreatePalletScreen());
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(90.0.w, 6.0.h),
                        backgroundColor: Constants.primaryOrangeColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0.w))),
                    child: Text(
                      "Create Pallet",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const FinishedGoodsOrderScreen());
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(90.0.w, 6.0.h),
                        backgroundColor: Constants.primaryOrangeColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0.w))),
                    child: Text(
                      "Order Complete",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0.h,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Hello ${GlobalVariables.user?.name}",
                    style: TextStyle(color: Colors.white, fontSize: 18.0.sp),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var box = await Hive.openBox("login");
                      box.clear();
                      Get.offAll(() => const LoginScreen());
                    },
                    child: Text(
                      " Logout?",
                      style: TextStyle(
                          color: Constants.primaryOrangeColor,
                          fontSize: 18.5.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
