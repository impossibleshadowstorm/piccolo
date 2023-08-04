import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:piccolo/screens/pallet_management/choose_sku_screen.dart';
import 'package:piccolo/screens/pallet_management/edit_pallet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import '../../common/widgets/DefaultBtn.dart';
import '../../common/widgets/DefaultContainerButton.dart';
import '../../common/widgets/ScanContainer.dart';
import '../../constants.dart';

class IncreaseCapacityScreen extends StatefulWidget {
  const IncreaseCapacityScreen({super.key});

  @override
  State<IncreaseCapacityScreen> createState() => _IncreaseCapacityScreenState();
}

class _IncreaseCapacityScreenState extends State<IncreaseCapacityScreen> {
  DateTime selectedDate = DateTime.now();
  String date = "";
  int lenght = 5;

  final TextEditingController weight = TextEditingController();

  @override
  void initState() {
    super.initState();
    date = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
  }

  @override
  void dispose() {
    weight.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        date = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

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
          "Pallet Management",
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
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            Container(
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
                  Row(
                    children: [
                      Expanded(
                        child: DefaultContainerButton(
                          noIcon: false,
                          icon: Icons.search,
                          label: "SKU No.",
                          ontap: () {
                            Get.to(() => const ChooseSKUScreen(
                                  type: "SKU",
                                ));
                          },
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: DefaultContainerButton(
                          noIcon: false,
                          icon: Icons.calendar_month,
                          label: date,
                          ontap: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: DefaultContainerButton(
                          noIcon: false,
                          icon: Icons.search,
                          label: "Variant",
                          ontap: () {
                            Get.to(() => const ChooseSKUScreen(
                                  type: "Variant",
                                ));
                          },
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            controller: weight,
                            validator: Validators.required("weight missing!!"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Weight",
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 17.0.sp),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5.w),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(3.0.w))),
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
                ],
              ),
            ),
            SizedBox(
              height: 0.0.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 1.0.h),
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              child: Row(
                children: [
                  Expanded(
                    child: DefaultBtn(
                      kolor: Constants.primaryOrangeColor,
                      label: "Add",
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 2.5.w),
                  Expanded(
                    child: DefaultBtn(
                      kolor: Colors.green,
                      label: "Request WH",
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
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
            SizedBox(height: 3.h),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
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
    );
  }

  Widget whTile() {
    return Container(
      height: 12.0.h,
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
                  "PALLET: P001",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
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
                Text(
                  "44.4C",
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
              GestureDetector(
                onTap: () {
                  Get.to(() => const EditPallet());
                },
                child: Container(
                  height: 30,
                  width: 22.5.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
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
              ),
              GestureDetector(
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
                          'Pallet: 008',
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
                        lenght--;
                        setState(() {});
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
