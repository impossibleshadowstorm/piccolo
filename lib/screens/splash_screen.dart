import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:piccolo/GlobalVariables.dart';
import 'package:piccolo/constants.dart';
import 'package:piccolo/screens/pallet_management/login_screen.dart';
import 'package:piccolo/screens/pallet_management/manage_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/LoginModel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigate() async {
    var box = await Hive.openBox("login");
    if (box.isEmpty) {
      Get.offAll(() => const LoginScreen());
      return;
    } else {
      LoginData? data = box.get("loginData");

      if (data?.id != null) {
        GlobalVariables.user = data;

        if (data?.role == "PALLET_CREATION") {
          Get.offAll(() => const ManageScreen());
          return;
        }
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
