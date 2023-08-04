import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import '../../common/widgets/DefaultBtn.dart';
import '../../common/widgets/DefaultContainerButton.dart';
import '../../common/widgets/ScanContainer.dart';
import '../../constants.dart';
import '../pallet_management/choose_sku_screen.dart';

class FinishedGoodsCreatePalletScreen extends StatefulWidget {
  const FinishedGoodsCreatePalletScreen({super.key});

  @override
  State<FinishedGoodsCreatePalletScreen> createState() =>
      _FinishedGoodsCreatePalletScreenState();
}

class _FinishedGoodsCreatePalletScreenState
    extends State<FinishedGoodsCreatePalletScreen> {
  int lenght = 5;
  String dropdownValue = 'Choose Order No.';
  List<String> options = ['Choose Order No.', 'Option 2', 'Option 3'];

  String dropdownValue1 = 'Box No.';
  List<String> options1 = ['Box No.', 'Option 2', 'Option 3'];

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
          "Finished Good Pallet",
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
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                      DefaultContainerButton(
                        noIcon: false,
                        icon: Icons.search,
                        label: "Choose Order No",
                        ontap: () {
                          Get.to(() => const ChooseSKUScreen(
                                type: "Order",
                              ));
                        },
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                validator:
                                    Validators.required("box no missings!!"),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Box No",
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 17.0.sp),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 1.5.h),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.0.w))),
                              ),
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
                      Column(
                        children: [
                          DefaultBtn(
                            kolor: Constants.primaryOrangeColor,
                            label: "Add",
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DefaultBtn(
                                  kolor: Colors.red,
                                  label: "Sent to Loading",
                                  onTap: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      animType: AnimType.rightSlide,
                                      title: 'Alert!!!',
                                      body: Column(
                                        children: [
                                          Text(
                                            "Pallet No: 0001",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'This pallet will be moved to loading',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {},
                                    ).show();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 3.0.w,
                              ),
                              Expanded(
                                child: DefaultBtn(
                                  kolor: Colors.green,
                                  label: "Sent to WH",
                                  onTap: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      animType: AnimType.rightSlide,
                                      title: 'Alert!!!',
                                      body: Column(
                                        children: [
                                          Text(
                                            "Pallet No: 0001",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "This pallet will be moved to warehouse",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {},
                                    ).show();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text.rich(
                        textAlign: TextAlign.end,
                        TextSpan(
                          text: "Pallet Capacity : ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w300,
                          ),
                          children: [
                            TextSpan(
                              text: "Not mentioned",
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
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemCount: lenght,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget whTile() {
    return Container(
      height: 60,
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
                  "Box No: 145234",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "Order No: 0001",
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.rightSlide,
                    title: 'Alert!!!',
                    body: Column(
                      children: [
                        Text(
                          "Delete?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Box No: 86886',
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
                child: Container(
                  height: 30,
                  width: 22.5.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
