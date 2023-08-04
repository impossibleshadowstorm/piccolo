import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/widgets/DefaultBtn.dart';
import '../../common/widgets/DefaultContainerButton.dart';
import '../../common/widgets/ScanContainer.dart';
import '../../constants.dart';
import 'choose_sku_screen.dart';

class SKUReturnScreen extends StatefulWidget {
  const SKUReturnScreen({super.key});

  @override
  State<SKUReturnScreen> createState() => _SKUReturnScreenState();
}

class _SKUReturnScreenState extends State<SKUReturnScreen> {
  int lenght = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "SKU Return",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Row(
              children: [
                Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 1.5.w,
                ),
                Icon(
                  Icons.save_outlined,
                  color: Colors.white,
                  size: 22.sp,
                )
              ],
            ),
          )
        ],
      ),
      backgroundColor: Constants.primaryBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 3.h),
                  DefaultContainerButton(
                    noIcon: false,
                    icon: Icons.search,
                    label: "Search Location",
                    ontap: () {
                      Get.to(() => const ChooseSKUScreen(
                            type: "Location",
                          ));
                    },
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: DefaultContainerButton(
                          noIcon: true,
                          icon: Icons.search,
                          label: "Search Pallet",
                          ontap: () {
                            Get.to(() => const ChooseSKUScreen(
                                  type: "Pallet",
                                ));
                          },
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: ScanContainer(
                          onTap: () async {
                            String barcodeScanRes =
                                await FlutterBarcodeScanner.scanBarcode(
                                    "#808080",
                                    "Cancel",
                                    true,
                                    ScanMode.BARCODE);
                            log(barcodeScanRes, name: "BarCode Value");
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 4.h,
                    color: Constants.primaryOrangeColor,
                    thickness: 2,
                  ),
                  DefaultBtn(
                    kolor: Colors.green,
                    label: "Request Warehouse",
                    onTap: () {},
                  ),
                  SizedBox(height: 4.h),
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => whTile(),
                      separatorBuilder: (context, index) => Divider(
                            height: 5.h,
                            color: Colors.white,
                            thickness: 2,
                          ),
                      itemCount: lenght),
                  Divider(
                    height: 4.5.h,
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
                  ),
                  SizedBox(
                    height: 5.0.h,
                  )
                ],
              ),
            ),
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
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0.w),
                height: 6.0.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: Center(
                  child: Text(
                    "100Kg",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )),
          ),
          Expanded(
            child: DefaultBtn(
              kolor: Constants.primaryOrangeColor,
              label: "Remove",
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.question,
                  animType: AnimType.rightSlide,
                  title: 'Alert!!!',
                  body: Column(
                    children: [
                      Text(
                        "Remove?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'SKU: 86886283',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0.sp,
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
            ),
          ),
        ],
      ),
    );
  }
}
