import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants.dart';

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
        backgroundColor: Constants.primaryOrangeColor,
        title: Text(
          "REACH TRUCK JOBS PENDING",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w400),
        ),
      ),
      body: Container(
        height: 100.0.h,
        width: 100.0.w,
        padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.0.h),
        child: Column(
          children: [
            kDivide(),
            ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 1.h),
              itemBuilder: (BuildContext context, int index) {
                return getTile(list[index]["label"], list[index]["value"]);
              },
            ),
            SizedBox(
              height: 1.0.h,
            ),
            kDivide(),
            getTile("WH TO ASSEMBLY LINE", "02"),
            getTile("ASSEMBLY RETURN TO WH", "05"),
            SizedBox(
              height: 1.0.h,
            ),
            kDivide(),
            getTile("WH TO LOADING", "03")
          ],
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

  Container getTile(String label, String value) {
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
