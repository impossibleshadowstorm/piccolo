import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DefaultContainerButton extends StatelessWidget {
  final Function ontap;
  final String label;
  final IconData icon;
  final bool noIcon;
  const DefaultContainerButton(
      {super.key,
      required this.icon,
      required this.noIcon,
      required this.label,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
        height: 6.0.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(3.0.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: Colors.black, fontSize: 17.0.sp),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            noIcon
                ? const SizedBox()
                : Icon(
                    icon,
                    color: Colors.black,
                    size: 20.sp,
                  )
          ],
        ),
      ),
    );
  }
}
