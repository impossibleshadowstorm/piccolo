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

class AssemblyToReturn extends StatefulWidget {
  const AssemblyToReturn({super.key});

  @override
  State<AssemblyToReturn> createState() => _AssemblyToReturnState();
}

class _AssemblyToReturnState extends State<AssemblyToReturn> {
  bool buttonPressed = false;
  String dropdownValue = 'LINE 1';
  List<String> options = ['LINE 1', 'LINE 2', 'LINE 3'];
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
            Expanded(
              child: Text(
                "Assembly return to WH",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
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
            DefaultContainerButton(
              noIcon: false,
              icon: Icons.search,
              label: "Choose Line",
              ontap: () {
                Get.to(() => const ChooseSKUScreen(
                      type: "Line",
                    ));
              },
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 1.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      "OR",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0.sp,
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
            Container(
              height: 1,
              width: double.infinity,
              color: Constants.primaryOrangeColor,
              margin: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DefaultContainerButton(
                    noIcon: false,
                    icon: Icons.search,
                    label: "Choose Drop",
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
              padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 1.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "LAST LOCATION: GENERAL",
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
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
                      buttonPressed = !buttonPressed;
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
            buttonPressed
                ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 3.0.h),
                    padding: EdgeInsets.symmetric(
                        vertical: 3.0.h, horizontal: 5.0.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0.w),
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
                                "FROM LINE: 01",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w200),
                              ),
                              Text(
                                "TO WH: GENERAL",
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
