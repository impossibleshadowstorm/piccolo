import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:piccolo/GlobalVariables.dart';
import 'package:piccolo/constants.dart';
import 'package:piccolo/controller/PalletGetController.dart';
import 'package:piccolo/models/LoginModel.dart';
import 'package:piccolo/screens/pallet_management/increase_capacity_screen.dart';
import 'package:piccolo/screens/pallet_management/login_screen.dart';
import 'package:piccolo/screens/pallet_management/sku_return_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/widgets/buttons.dart';
import '../../services/webservices.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  final controller = PalletGetController.palletController;
  final Webservices webservices = Webservices();

  Future<void> fetchMasterDate(bool create) async {
    await webservices.fetchMaster(create).then((value) {
      if (value != null) {
        controller.locationsList.value = value.data?.locations ?? [];
        controller.masterPallets.value = value.data?.masterPallets ?? [];
        controller.orderList.value = value.data?.order ?? [];
        controller.skuCodes.value = value.data?.skuCodes ?? [];
        controller.variants.value = value.data?.variants ?? [];
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constants.primaryOrangeColor,
        title: Text(
          "Pallet Management",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      backgroundColor: Constants.primaryBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    SizedBox(height: 3.h),
                    InkWell(
                      onTap: () {
                        fetchMasterDate(true).whenComplete(() {
                          Get.to(() => const IncreaseCapacityScreen());
                        });
                      },
                      child: CommonButtons.primaryOrangeFilledButton(
                          "Create Pallet", null),
                    ),
                    SizedBox(height: 3.h),
                    InkWell(
                      onTap: () {
                        final controller = PalletGetController.palletController;
                        controller.listOfPalletItems.clear();
                        controller.listOfPalletItemsAPI.clear();
                        fetchMasterDate(false).whenComplete(() {
                          Get.to(() => const SKUReturnScreen());
                        });
                      },
                      child: CommonButtons.primaryOrangeFilledButton(
                          "Return Pallet", null),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0.h,
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
      ),
    );
  }
}
