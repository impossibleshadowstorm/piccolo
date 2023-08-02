import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScanContainer extends StatelessWidget {
  final Function onTap;
  const ScanContainer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 6.0.h,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Scan",
              style: TextStyle(color: Colors.white, fontSize: 17.0.sp),
            ),
            SizedBox(width: 2.w),
            Icon(
              Icons.barcode_reader,
              color: Colors.white70,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
