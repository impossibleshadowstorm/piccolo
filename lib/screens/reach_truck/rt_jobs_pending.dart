import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:piccolo/screens/reach_truck/assembly_to_return.dart';
import 'package:piccolo/screens/reach_truck/rt_glass.dart';
import 'package:piccolo/screens/reach_truck/wh_to_assembly.dart';
import 'package:piccolo/screens/reach_truck/wh_to_loading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../GlobalVariables.dart';
import '../../constants.dart';
import '../pallet_management/login_screen.dart';

class RTJobsPendingScreen extends StatelessWidget {
  RTJobsPendingScreen({super.key});

  List<Map> list = [
    {"label": "CURING", "value": "01"},
    {"label": "RECYCLE", "value": "01"},
    {"label": "GLASS", "value": "01"},
    {"label": "CERAMIC", "value": "01"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constants.primaryOrangeColor,
        title: Text(
          "Reach Truck Jobs Pending",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        height: 100.0.h,
        width: 100.0.w,
        padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.0.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              kDivide(),
              ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Get.to(() => RTGlass(label: list[index]["label"]));
                      },
                      child:
                          getTile(list[index]["label"], list[index]["value"]));
                },
              ),
              SizedBox(
                height: 1.0.h,
              ),
              kDivide(),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const WHAssembly());
                  },
                  child: getTile("WH To Assembly Line", "02")),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const AssemblyToReturn());
                  },
                  child: getTile("Assembly return to WH", "05")),
              SizedBox(
                height: 1.0.h,
              ),
              kDivide(),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const WHLoading());
                  },
                  child: getTile("WH TO LOADING", "03")),
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
      ),
    );
  }

  Container kDivide() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Constants.primaryOrangeColor,
      margin: EdgeInsets.symmetric(vertical: 1.5.h),
    );
  }

  Widget getTile(String label, String value) {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 1.5.h),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(color: Colors.grey.shade300)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 16.0.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 16.0.sp,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
