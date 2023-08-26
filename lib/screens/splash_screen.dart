import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:piccolo/GlobalVariables.dart';
import 'package:piccolo/constants.dart';
import 'package:piccolo/controller/PalletGetController.dart';
import 'package:piccolo/screens/pallet_management/login_screen.dart';
import 'package:piccolo/screens/pallet_management/manage_screen.dart';
import 'package:piccolo/screens/reach_truck/rt_jobs_pending.dart';
import 'package:piccolo/services/webservices.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/LoginModel.dart';
import 'finished_goods/finished_goods_manage_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = PalletGetController.palletController;
  final Webservices _webservices = Webservices();

  Future<void> fetchMasterDate() async {
    await _webservices.fetchMaster().then((value) {
      if (value != null) {
        controller.locationsList.value = value.data?.locations ?? [];
        controller.masterPallets.value = value.data?.masterPallets ?? [];
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

  Future<void> navigate() async {
    var box = await Hive.openBox("login");
    if (box.isEmpty) {
      Get.offAll(() => const LoginScreen());
      return;
    } else {
      LoginData? data = box.get("loginData");

      if (data?.id != null) {
        GlobalVariables.user = data;

        // if (data?.role == "PALLET_CREATION") {
        //   fetchMasterDate().whenComplete(() {
        //     Get.offAll(() => const ManageScreen());
        //   });
        // } else
        if (data?.role == "REACH_TRUCK") {
          Get.offAll(() => RTJobsPendingScreen());
        }
        // else if (data?.role == "FG_PALLET_CREATION") {
        //   Get.offAll(() => const FinishedGoodsManageScreen());
        // }
        return;
      }
      Get.offAll(() => const LoginScreen());
      return;
    }
  }

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryBackgroundColor,
      body: Center(
        child: Text(
          "piccolo",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
