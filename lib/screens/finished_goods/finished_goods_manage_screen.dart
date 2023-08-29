import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piccolo/constants.dart';
import 'package:piccolo/controller/PalletGetController.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_create_pallet_screen.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_order_screen.dart';
import 'package:piccolo/services/webservices.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../GlobalVariables.dart';

class FinishedGoodsManageScreen extends StatefulWidget {
  const FinishedGoodsManageScreen({super.key});

  @override
  State<FinishedGoodsManageScreen> createState() =>
      _FinishedGoodsManageScreenState();
}

class _FinishedGoodsManageScreenState extends State<FinishedGoodsManageScreen> {
  final Webservices _webservices = Webservices();
  final controller = PalletGetController.palletController;

  Future<void> fetchMasterDate() async {
    await _webservices.fetchMaster(false).then((value) {
      if (value != null) {
        controller.locationsList.value = value.data?.locations ?? [];
        controller.masterPallets.value = value.data?.masterPallets ?? [];
        controller.skuCodes.value = value.data?.skuCodes ?? [];
        controller.variants.value = value.data?.variants ?? [];
        controller.orderList.value = value.data?.order ?? [];
        controller.maxWeightForContainer.value =
            value.data?.maxWeightForContainer ?? 0;
        controller.maxWeightForPallet.value =
            value.data?.maxWeightForPallet ?? 0;
        return;
      }
    });
  }

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
                      logout();
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
