import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants.dart';

class CommonButtons {
  static Widget primaryOrangeFilledButton(String buttonText, double? width) {
    return Container(
      width: width ?? 80.w,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      decoration: BoxDecoration(
        color: Constants.primaryOrangeColor,
        borderRadius: BorderRadius.circular(2.5.w),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
