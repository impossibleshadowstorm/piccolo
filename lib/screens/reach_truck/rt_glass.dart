import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:piccolo/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/widgets/DefaultContainerButton.dart';
import '../../common/widgets/ScanContainer.dart';
import '../pallet_management/choose_sku_screen.dart';

class RTGlass extends StatefulWidget {
  final String label;
  const RTGlass({super.key, required this.label});

  @override
  State<RTGlass> createState() => _RTGlassState();
}

class _RTGlassState extends State<RTGlass> {
  String dropdownValue = 'Option 1';
  List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  String? selectedPalletNo;
  String? selectedDrop;
  List<String> palletItems = ["Pallet No. 1", "Pallet No. 2", "Pallet No. 3"];
  List<String> dropItems = ["Drop No. 1", "Drop No. 2", "Drop No. 3"];
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
            Text(
              widget.label.toTitleCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w400),
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
            DefaultContainerButton(
              noIcon: false,
              icon: Icons.search,
              label: "Choose Pickup Location",
              ontap: () {
                Get.to(() => const ChooseSKUScreen(
                      type: "Location",
                    ));
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 2.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      "CHOOSE PALLET AND SCAN TO CONFIRM OR SCAN DIRECTLY",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DefaultContainerButton(
                    noIcon: false,
                    icon: Icons.search,
                    label: "Choose Pallet",
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
                  ),
                )
              ],
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DefaultContainerButton(
                    noIcon: false,
                    icon: Icons.search,
                    label: "Search Drop",
                    ontap: () {
                      Get.to(() => const ChooseSKUScreen(
                            type: "Drop",
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
                  ),
                )
              ],
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Constants.primaryOrangeColor,
              margin: EdgeInsets.symmetric(vertical: 2.h),
            ),
            SizedBox(
              height: 6.0.h,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPalletNo = "Pallet No. 1";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0.w)),
                      backgroundColor: Constants.primaryOrangeColor),
                  child: Text(
                    "Drop Pallet in WH",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0.sp,
                        fontWeight: FontWeight.w400),
                  )),
            ),
            selectedPalletNo == "Pallet No. 1"
                ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 3.0.h),
                    padding: EdgeInsets.symmetric(
                        vertical: 3.0.h, horizontal: 5.0.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.0.w),
                        border: Border.all(color: Colors.red)),
                    child: Text(
                      "ALERT: WRONG PALLET SELECTED",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
