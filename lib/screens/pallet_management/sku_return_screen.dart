import 'package:flutter/material.dart';
import 'package:piccolo/common/widgets/buttons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants.dart';

class SKUReturnScreen extends StatefulWidget {
  const SKUReturnScreen({super.key});

  @override
  State<SKUReturnScreen> createState() => _SKUReturnScreenState();
}

class _SKUReturnScreenState extends State<SKUReturnScreen> {
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
                      "SKU RETURN",
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
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.1,
                          ),
                        ),
                        SizedBox(width: 2.5.w),
                        Icon(
                          Icons.save,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 3.h),
                        Container(
                          width: 90.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1.w),
                          ),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "SEARCH LOCATION",
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
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1.w),
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "SEARCH PALLET",
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(2.5.w),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "SCAN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Icon(
                                      Icons.qr_code_scanner,
                                      color: Colors.white70,
                                      size: 20.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 4.h,
                          color: Constants.primaryOrangeColor,
                          thickness: 2,
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
                        SizedBox(height: 4.h),
                        whTile(),
                        Divider(
                          height: 4.h,
                          color: Colors.white,
                          thickness: 2,
                        ),
                        whTile(),
                        Divider(
                          height: 4.h,
                          color: Colors.white,
                          thickness: 2,
                        ),
                        whTile(),
                        Divider(
                          height: 4.h,
                          color: Colors.white,
                          thickness: 2,
                        ),
                        Text(
                          "Once Required quantity is removed,\nkindly request for warehouse",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
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
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 1.5.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SKU: AH556ZT",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "VAR: 80NN",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "WEIGHT: 100KG",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            width: 25.w,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Text(
                  "Kg.g",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 2.5.w),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
            decoration: BoxDecoration(
              color: Constants.primaryOrangeColor,
              borderRadius: BorderRadius.circular(2.5.w),
            ),
            child: Center(
              child: Text(
                "Remove",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
