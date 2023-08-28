import 'package:awesome_dialog/awesome_dialog.dart';
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
  int lenght = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20.0.sp,
            )),
        backgroundColor: Constants.primaryOrangeColor,
        title: Text(
          "Order List",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
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
                    TextFormField(
                      style: TextStyle(color: Colors.black, fontSize: 18.0.sp),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.0.w, vertical: 1.0.h),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Choose or Type",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 19.sp,
                        ),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 2.0.h),
                          itemCount: lenght,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                whTile(),
                                Divider(
                                  height: 3.h,
                                  color: Constants.primaryOrangeColor,
                                  thickness: 2,
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget whTile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w),
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
          ElevatedButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.question,
                animType: AnimType.rightSlide,
                title: 'Alert!!!',
                body: Column(
                  children: [
                    Text(
                      "Order No:- #87487",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Are you sure to mark this order complete?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  if (lenght > 0) {
                    setState(() {
                      lenght--;
                    });
                  }
                },
              ).show();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0.w))),
            child: Text(
              "Set Complete",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
