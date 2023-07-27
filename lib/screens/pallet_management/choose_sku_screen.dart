import 'package:flutter/material.dart';
import 'package:piccolo/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChooseSKUScreen extends StatefulWidget {
  const ChooseSKUScreen({super.key});

  @override
  State<ChooseSKUScreen> createState() => _ChooseSKUScreenState();
}

class _ChooseSKUScreenState extends State<ChooseSKUScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryBackgroundColor,
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Container(height: AppBar().preferredSize.height),
            Container(
              height: AppBar().preferredSize.height,
              width: 100.w,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Choose or Type Varient",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.5.h),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return chooseTile(index);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget chooseTile(int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selected = index;
            });
          },
          child: Container(
            // height: 40,
            padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.5.w),
            width: 100.w,
            color: index == selected
                ? Constants.primaryOrangeColor
                : Colors.transparent,
            child: Text(
              "ABC TEST",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
