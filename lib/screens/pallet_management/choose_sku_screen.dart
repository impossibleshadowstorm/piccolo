import 'package:flutter/material.dart';
import 'package:piccolo/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChooseSKUScreen extends StatefulWidget {
  final String type;
  const ChooseSKUScreen({super.key, required this.type});

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
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Choose or Type ${widget.type}",
                hintStyle: TextStyle(
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
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 1.5.h),
        padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.5.w),
        width: 100.w,
        color: index == selected
            ? Constants.primaryOrangeColor
            : Colors.transparent,
        child: Text(
          "${widget.type} $index",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
