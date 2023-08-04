import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:piccolo/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/widgets/DefaultContainerButton.dart';
import '../../common/widgets/ScanContainer.dart';
import '../pallet_management/choose_sku_screen.dart';

class WHLoading extends StatefulWidget {
  const WHLoading({super.key});

  @override
  State<WHLoading> createState() => _WHLoadingState();
}

class _WHLoadingState extends State<WHLoading> {
  bool buttonTapped = true;
  String? dropdownValue;
  List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  String? selectedPalletNo;
  String? selectedWHLocation;
  List<String> palletItems = ["Pallet No. 1", "Pallet No. 2", "Pallet No. 3"];
  List<String> whItems = ["Drop No. 1", "Drop No. 2", "Drop No. 3"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20.0.sp,
            )),
        backgroundColor: Constants.primaryOrangeColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "WH TO LOADING".toTitleCase(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: 100.0.h,
        width: 100.0.w,
        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Constants.primaryOrangeColor,
              margin: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
            SizedBox(
              height: 1.0.h,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DefaultContainerButton(
                    noIcon: false,
                    icon: Icons.search,
                    label: "Pick Pallet",
                    ontap: () {
                      Get.to(() => const ChooseSKUScreen(
                            type: "Pallet",
                          ));
                    },
                  ),
                ),
                SizedBox(
                  width: 3.0.w,
                ),
                Expanded(
                    flex: 2,
                    child: ScanContainer(
                      onTap: () async {
                        String barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                                "#808080", "Cancel", true, ScanMode.BARCODE);
                        log(barcodeScanRes, name: "BarCode Value");
                      },
                    ))
              ],
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Constants.primaryOrangeColor,
              margin: EdgeInsets.symmetric(vertical: 2.h),
            ),
            Container(
              height: 6.0.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 1.5.h),
              padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 0.0.h),
              decoration: BoxDecoration(
                  color: Colors.yellow.shade200,
                  borderRadius: BorderRadius.circular(2.0.w)),
              child: DropdownButton(
                isExpanded: true,
                onTap: () {},
                value: dropdownValue,
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 25.0.sp,
                ),
                hint: Text(
                  "DROP PALLET".toTitleCase(),
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 18.0.sp,
                  ),
                ),
                underline: const SizedBox(),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 18.0.sp,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 1.0.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 6.0.h,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonTapped = !buttonTapped;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0.w)),
                      backgroundColor: Constants.primaryOrangeColor),
                  child: Text(
                    "DROP PALLET IN LOADING".toTitleCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0.sp,
                        fontWeight: FontWeight.w400),
                  )),
            ),
            buttonTapped
                ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 3.0.h),
                    padding: EdgeInsets.symmetric(
                        vertical: 3.0.h, horizontal: 5.0.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.0.w),
                        border: Border.all(color: Colors.green)),
                    child: Row(
                      children: [
                        LineIcon.checkCircle(
                          color: Colors.green,
                          size: 20.0.sp,
                        ),
                        SizedBox(
                          width: 3.0.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "PALLET UPDATE SUCCESSFULLY",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16.0.sp,
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "PALLET NO: P005",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w200),
                              ),
                              Text(
                                "FROM: GENERAL",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w200),
                              ),
                              Text(
                                "TO LOADING",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w200),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
