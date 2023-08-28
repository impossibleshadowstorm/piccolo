import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:piccolo/controller/PalletGetController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import '../../common/widgets/DefaultBtn.dart';
import '../../common/widgets/DefaultContainerButton.dart';
import '../../common/widgets/ScanContainer.dart';
import '../../constants.dart';
import '../../models/MasterDataModel.dart';
import '../pallet_management/choose_sku_screen.dart';

class FinishedGoodsCreatePalletScreen extends StatefulWidget {
  const FinishedGoodsCreatePalletScreen({super.key});

  @override
  State<FinishedGoodsCreatePalletScreen> createState() =>
      _FinishedGoodsCreatePalletScreenState();
}

class _FinishedGoodsCreatePalletScreenState
    extends State<FinishedGoodsCreatePalletScreen> {
  Location? selectedLocation;
  MasterPallet? selectedPallet;
  Orders? selectedOrder;
  bool palletScanned = false;
  bool palletMatched = false;
  TextEditingController boxNo = TextEditingController();
  final controller = PalletGetController.palletController;
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> listOfBoxes = [];

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
          child: Form(
            key: _formKey,
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
                          label: selectedLocation?.name ?? "Search Location",
                          ontap: () async {
                            Location? locationVal = await Get.to<dynamic>(
                                () => const ChooseSKUScreen(
                                      type: "Location",
                                    ));

                            if (locationVal != null) {
                              selectedLocation = locationVal;
                            }
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Expanded(
                              child: DefaultContainerButton(
                                noIcon: true,
                                icon: Icons.search,
                                label: selectedPallet?.name ?? "Search Pallet",
                                ontap: () async {
                                  if (selectedLocation == null) {
                                    Fluttertoast.showToast(
                                        msg: "Please select location first!");
                                  } else {
                                    MasterPallet? locationVal =
                                        await Get.to<dynamic>(
                                            () => const ChooseSKUScreen(
                                                  type: "Pallet",
                                                ));
                                    if (locationVal != null) {
                                      setState(() {
                                        selectedPallet = locationVal;
                                      });
                                    }
                                  }
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
                                  if (barcodeScanRes == "-1") {
                                    Fluttertoast.showToast(
                                        msg: "Something went wrong!!");
                                  } else {
                                    if (selectedPallet == null) {
                                      for (var element
                                          in controller.masterPallets) {
                                        if (element.name.toLowerCase() ==
                                            barcodeScanRes.toLowerCase()) {
                                          selectedPallet = element;
                                          palletMatched = true;
                                          palletScanned = true;
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "$barcodeScanRes is invalid pallet number");
                                        }
                                      }
                                    } else {
                                      if (selectedPallet?.name ==
                                          barcodeScanRes) {
                                        Fluttertoast.showToast(
                                            msg: "Pallet Matched!!");
                                        palletMatched = true;
                                        palletScanned = true;
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please details does not match!!!");
                                        selectedPallet = null;
                                      }
                                    }
                                  }
                                  setState(() {});
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
                          label: selectedOrder?.name ?? "Choose Order No",
                          ontap: () async {
                            if (selectedLocation == null) {
                              Fluttertoast.showToast(
                                  msg: "Please select location first!!");
                            } else if (selectedPallet == null) {
                              Fluttertoast.showToast(
                                  msg: "Please select or scan pallet first");
                            } else {
                              Orders? locationVal = await Get.to<dynamic>(
                                  () => const ChooseSKUScreen(
                                        type: "Order",
                                      ));
                              if (locationVal != null) {
                                setState(() {
                                  selectedOrder = locationVal;
                                });
                              }
                            }
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
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17.0.sp),
                                  controller: boxNo,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  validator:
                                      Validators.required("box no missings!!"),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      prefixIcon: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.only(left: 3.0.w),
                                            child: Text(
                                              "${selectedOrder?.name ?? ""}-",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.0.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      filled: true,
                                      hintText: "Box No",
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0.sp),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 1.5.h),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.0.w))),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        GestureDetector(
                          onTap: () async {
                            String barcodeScanRes =
                                await FlutterBarcodeScanner.scanBarcode(
                                    "#808080",
                                    "Cancel",
                                    true,
                                    ScanMode.BARCODE);
                            log(barcodeScanRes, name: "BarCode Value");
                          },
                          child: Container(
                            height: 6.0.h,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(3.w),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Scan Box",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0.sp),
                                ),
                                SizedBox(width: 2.w),
                                Icon(
                                  Icons.barcode_reader,
                                  color: Colors.white70,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),
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
                              onTap: () {
                                if (selectedLocation == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please selec location first!!");
                                } else if (palletMatched) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please select or scan pallet first!!");
                                } else if (selectedOrder == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please select order first!");
                                } else {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    listOfBoxes.add({
                                      "boxNo": boxNo.text,
                                      "order":
                                          "${selectedOrder?.name ?? ""}${boxNo.text}"
                                    });

                                    setState(() {});
                                    boxNo.clear();
                                  }
                                }
                              },
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
                        // SizedBox(height: 4.h),
                        // Text.rich(
                        //   textAlign: TextAlign.end,
                        //   TextSpan(
                        //     text: "Pallet Capacity : ",
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 18.sp,
                        //       fontWeight: FontWeight.w300,
                        //     ),
                        //     children: [
                        //       TextSpan(
                        //         text: "Not mentioned",
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 18.sp,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 4.h),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            itemCount: listOfBoxes.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  whTile(index),
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
      ),
    );
  }

  Widget whTile(int index) {
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
                  "Box No: ${listOfBoxes[index]['boxNo']}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "Order No: ${listOfBoxes[index]['order']}",
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
                          'Box No: ${listOfBoxes[index]['boxNo']}',
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
                      listOfBoxes.removeAt(index);
                      setState(() {});
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
