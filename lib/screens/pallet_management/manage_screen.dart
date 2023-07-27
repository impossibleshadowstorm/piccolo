import 'package:flutter/material.dart';
import 'package:piccolo/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/widgets/buttons.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
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
                height: AppBar().preferredSize.height + 20,
                width: 100.w,
                color: Constants.primaryOrangeColor,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    Text(
                      "PALLET MANAGEMENT",
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
                    CommonButtons.primaryOrangeFilledButton(
                        "Return Pallet", null),
                    SizedBox(height: 3.h),
                    CommonButtons.primaryOrangeFilledButton(
                        "Create Pallet", null),
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
