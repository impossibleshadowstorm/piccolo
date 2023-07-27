import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants.dart';

class FinishedGoodsOrderScreen extends StatefulWidget {
  const FinishedGoodsOrderScreen({super.key});

  @override
  State<FinishedGoodsOrderScreen> createState() =>
      _FinishedGoodsOrderScreenState();
}

class _FinishedGoodsOrderScreenState extends State<FinishedGoodsOrderScreen> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ORDERS LIST",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.1,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.1,
                          ),
                        ),
                        SizedBox(width: 2.5.w),
                        Icon(
                          Icons.turn_left_sharp,
                          color: Colors.white70,
                          size: 25.sp,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      Divider(
                        height: 4.h,
                        color: Constants.primaryOrangeColor,
                        thickness: 2,
                      ),
                      Container(
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1.w),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "CHOOSE ORDER",
                            labelStyle: const TextStyle(color: Colors.black),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 5.w),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.black87,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  whTile(),
                                  Divider(
                                    height: 4.h,
                                    color: Constants.primaryOrangeColor,
                                    thickness: 2,
                                  ),
                                ],
                              );
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(2.5.w),
                        ),
                        child: Center(
                          child: Text(
                            "Request WH",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget whTile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "AH001HX06",
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(1.w),
            ),
            child: Center(
              child: Text(
                "SET COMPLETE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
