import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants.dart';

class IncreaseCapacityScreen extends StatefulWidget {
  const IncreaseCapacityScreen({super.key});

  @override
  State<IncreaseCapacityScreen> createState() => _IncreaseCapacityScreenState();
}

class _IncreaseCapacityScreenState extends State<IncreaseCapacityScreen> {
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
                      "PALLET MANAGEMENT",
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
                                    labelText: "SKU NO.",
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black87,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1.w),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "SEARCH PALLET",
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.calendar_month,
                                      color: Colors.black87,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                                    labelText: "VARIANT",
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black87,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1.w),
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "TYPE WEIGHT",
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    border: InputBorder.none,
                                  ),
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
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                decoration: BoxDecoration(
                                  color: Constants.primaryOrangeColor,
                                  borderRadius: BorderRadius.circular(2.5.w),
                                ),
                                child: Center(
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.5.w),
                            Expanded(
                              child: Container(
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
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text.rich(
                          textAlign: TextAlign.end,
                          TextSpan(
                            text: "Pallet Capacity ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w300,
                            ),
                            children: [
                              TextSpan(
                                text: "1500 / 1500 KG",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          height: ((80 + 4.h) * 10) + 40,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  whTile(),
                                  Divider(
                                    height: 4.h,
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
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
      height: 80,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 30,
                width: 22.5.w,
                padding: EdgeInsets.symmetric( horizontal: 5.w),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(1.w),
                ),
                child: Center(
                  child: Text(
                    "Edit",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 22.5.w,
                padding: EdgeInsets.symmetric( horizontal: 5.w),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(1.w),
                ),
                child: Center(
                  child: Text(
                    "Delete",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
