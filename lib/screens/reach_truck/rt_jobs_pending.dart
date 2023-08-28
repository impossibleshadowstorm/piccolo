import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:piccolo/models/RTModels/HomeModel.dart';
import 'package:piccolo/screens/reach_truck/assembly_to_return.dart';
import 'package:piccolo/screens/reach_truck/rt_glass.dart';
import 'package:piccolo/screens/reach_truck/wh_to_assembly.dart';
import 'package:piccolo/screens/reach_truck/wh_to_loading.dart';
import 'package:piccolo/services/webservices.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../GlobalVariables.dart';
import '../../constants.dart';
import '../pallet_management/login_screen.dart';
import 'assembly_to_loading.dart';

class RTJobsPendingScreen extends StatefulWidget {
  RTJobsPendingScreen({super.key});

  @override
  State<RTJobsPendingScreen> createState() => _RTJobsPendingScreenState();
}

class _RTJobsPendingScreenState extends State<RTJobsPendingScreen> {
  bool loading = true;
  final Webservices _webservices = Webservices();
  RtHomeModel _model = RtHomeModel();

  fetchData() async {
    await _webservices.getRTHome().then((value) {
      if (value != null) {
        loading = false;
        _model = value;
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

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
      body: loading
          ? const SizedBox()
          // ? const Center(
          //     child: SizedBox(
          //       height: 50,
          //       width: 50,
          //       child: CircularProgressIndicator(),
          //     ),
          //   )
          : Container(
              height: 100.0.h,
              width: 100.0.w,
              padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.0.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    kDivide(),
                    ListView.builder(
                      itemCount: _model.data?.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () async {
                              if (_model.data?[index].total == 0) {
                              } else {
                                var res = await Get.to<dynamic>(() => RTGlass(
                                    label: _model.data?[index].type ?? "---"));
                                if (res != null) {
                                  if (res) {
                                    setState(() {
                                      loading = true;
                                    });
                                    fetchData();
                                  }
                                }
                              }
                            },
                            child: getTile(_model.data?[index].type ?? "---",
                                "${_model.data?[index].total ?? "0"}"));
                      },
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    // kDivide(),
                    // GestureDetector(
                    //     onTap: () {
                    //       Get.to(() => const WHAssembly());
                    //     },
                    //     child: getTile("WH To Assembly Line", "02")),
                    // GestureDetector(
                    //     onTap: () {
                    //       Get.to(() => const AssemblyToReturn());
                    //     },
                    //     child: getTile("Assembly return to WH", "05")),
                    // SizedBox(
                    //   height: 1.0.h,
                    // ),
                    // kDivide(),
                    // GestureDetector(
                    //     onTap: () {
                    //       Get.to(() => const WHLoading());
                    //     },
                    //     child: getTile("WH To Loading", "03")),
                    // GestureDetector(
                    //     onTap: () {
                    //       Get.to(() => const AssmeblyToLoading());
                    //     },
                    //     child: getTile("Assembly To Loading", "03")),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                      height: 10.0.h,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              "Hello ${GlobalVariables.user?.name}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0.sp),
                            ),
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
            label.toUpperCase(),
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
