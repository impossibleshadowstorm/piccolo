import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DefaultBtn extends StatelessWidget {
  final Function onTap;
  final String label;
  final Color kolor;
  const DefaultBtn({
    required this.kolor,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 6.0.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kolor,
          borderRadius: BorderRadius.circular(2.5.w),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
            ),
          ),
        ),
      ),
    );
  }
}
