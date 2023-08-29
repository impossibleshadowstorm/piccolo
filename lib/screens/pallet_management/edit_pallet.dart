import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:piccolo/constants.dart';
import 'package:piccolo/controller/PalletGetController.dart';
import 'package:piccolo/models/MasterDataModel.dart';
import 'package:piccolo/models/PalletDetailsPMModel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/widgets/DefaultBtn.dart';
import '../../common/widgets/DefaultContainerButton.dart';
import 'choose_sku_screen.dart';

class EditPallet extends StatefulWidget {
  final PalletDetail? pallet;
  num maxWeight;
  final String palletName;
  EditPallet(
      {super.key,
      required this.maxWeight,
      required this.pallet,
      required this.palletName});

  @override
  State<EditPallet> createState() => _EditPalletState();
}

class _EditPalletState extends State<EditPallet> {
  final controller = PalletGetController.palletController;
  TextEditingController weight = TextEditingController();
  MasterPallet? selectedSKU;
  MasterPallet? selectedVariant;
  bool loading = true;

  setVariant(String name) {
    for (var element in controller.variants) {
      if (element.name == name) {
        selectedVariant = element;
        setState(() {});
      }
    }
  }

  setSKU(String name) {
    for (var element in controller.skuCodes) {
      if (element.name == name) {
        selectedSKU = element;
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    weight.dispose();
    super.dispose();
  }

  @override
  void initState() {
    weight.text = widget.pallet?.weight ?? "0.0";
    setSKU(widget.pallet?.skuCodeName ?? "");
    setVariant(widget.pallet?.variantName ?? "");
    widget.maxWeight =
        widget.maxWeight + num.parse(widget.pallet?.weight ?? "0.0");
    setState(() {
      loading = false;
    });
    super.initState();
  }

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
                "Edit Pallet SKU",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
        height: 100.0.h,
        width: 100.0.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 1.0.h,
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
            Text(
              "Pallet no. ${widget.palletName}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SKU",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 1.0.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DefaultContainerButton(
                        noIcon: true,
                        icon: Icons.search,
                        label: "${selectedSKU?.name}",
                        ontap: () async {
                          MasterPallet? locationVal =
                              await Get.to<dynamic>(() => const ChooseSKUScreen(
                                    type: "SKU",
                                  ));
                          if (locationVal != null) {
                            setState(() {
                              selectedSKU = locationVal;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Variant",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DefaultContainerButton(
                              noIcon: true,
                              icon: Icons.search,
                              label: "${selectedVariant?.name}",
                              ontap: () async {
                                MasterPallet? locationVal =
                                    await Get.to<dynamic>(
                                        () => const ChooseSKUScreen(
                                              type: "Variant",
                                            ));
                                if (locationVal != null) {
                                  setState(() {
                                    selectedVariant = locationVal;
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 3.0.w,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                controller: weight,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter weight';
                                  }
                                  final number = int.tryParse(value);
                                  if (number == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Weight",
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
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.5.h,
            ),
            DefaultBtn(
              kolor: Constants.primaryOrangeColor,
              label: "Update",
              onTap: () {
                num temp = num.parse(weight.text);
                if (temp > widget.maxWeight) {
                  Fluttertoast.showToast(
                      msg: "Please enter weight less than ${widget.maxWeight}");
                } else {
                  widget.pallet?.skuCodeId = selectedSKU?.id;
                  widget.pallet?.skuCodeName = selectedSKU?.name;
                  widget.pallet?.variantId = selectedVariant?.id;
                  widget.pallet?.variantName = selectedVariant?.name;
                  widget.pallet?.weight = weight.text;
                  Get.back(result: widget.pallet);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
