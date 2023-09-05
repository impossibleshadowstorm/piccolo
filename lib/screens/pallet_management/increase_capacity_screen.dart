import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:piccolo/GlobalVariables.dart';
import 'package:piccolo/controller/PalletGetController.dart';
import 'package:piccolo/models/MasterDataModel.dart';
import 'package:piccolo/models/PalletDetailsPMModel.dart';
import 'package:piccolo/screens/pallet_management/choose_sku_screen.dart';
import 'package:piccolo/screens/pallet_management/edit_pallet.dart';
import 'package:piccolo/services/webservices.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
  final _formKey = GlobalKey<FormState>();
  final controller = PalletGetController.palletController;
  Location? selectedLocation;
  MasterPallet? selectedPallet;
  MasterPallet? selectedSKU;
  MasterPallet? selectedVariant;
  DateTime selectedDate = DateTime.now();
  bool palletMatch = false;
  String date = "";
  int lenght = 5;
  PalletDetailsPm? palletDetails;
  List<PalletDetail> listPallets = [];
  final TextEditingController weight = TextEditingController();
  final Webservices _webservices = Webservices();
  List<Map<String, dynamic>> pList = [];
  num totalWeight = 0;

  num getRemainingWeight() {
    if (selectedPallet?.name?[0] == "P") {
      num remainingWeight = controller.maxWeightForPallet.value - totalWeight;
      return remainingWeight;
    } else {
      num remainingWeight =
          controller.maxWeightForContainer.value - totalWeight;
      return remainingWeight;
    }
  }

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

  void fillPallet(MasterPallet locationVal) {
    CustomProgressDialog progressDialog =
        // ignore: use_build_context_synchronously
        CustomProgressDialog(
      context,
      blur: 10,
      dismissable: false,
      onDismiss: () => log("Do something onDismiss"),
    );
    progressDialog.show();
    _webservices.getPalletDetails(locationVal.name!).then((value) {
      progressDialog.dismiss();
      palletDetails = value;
      selectedPallet = locationVal;
      if (value != null) {
        String formattedDateActual =
            DateFormat('yyyy-MM-dd').format(selectedDate);
        var index = controller.masterPallets.indexWhere(
            (element) => element.name == palletDetails?.data?.palletName);
        if (index != -1) {
          selectedPallet = controller.masterPallets[index];
        }

        var indexLoc = controller.locationsList.indexWhere((element) =>
            element.name == palletDetails?.data?.palletLastLocation);
        if (indexLoc != -1) {
          selectedLocation = controller.locationsList[indexLoc];
        }

        //
        //
        palletDetails?.data?.palletDetails?.forEach((element) {
          listPallets.add(element);
          pList.add({
            "id": element.id,
            "sku_code_id": element.skuCodeId,
            "variant_id": element.variantId,
            "weight": num.tryParse(element.weight ?? "0.0"),
            "batch": element.batch,
            "batch_date": formattedDateActual,
          });
          totalWeight = totalWeight + num.parse(element.weight ?? "0.0");
        });

        //
        //
      }
      setState(() {});
    });
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
          GestureDetector(
            onTap: () async {
              if (pList.isEmpty) {
                Fluttertoast.showToast(msg: "Please add Pallet");
              } else {
                Map<String, dynamic> body = {
                  "location_id": selectedLocation?.id,
                  "master_pallet_id": selectedPallet?.id,
                  "updated_by": GlobalVariables.user?.id,
                  "is_request_for_warehouse": true,
                  "pallet_details": pList
                };
                log(body.toString(), name: "Body+");
                CustomProgressDialog progressDialog =
                    // ignore: use_build_context_synchronously
                    CustomProgressDialog(
                  context,
                  blur: 10,
                  dismissable: false,
                  onDismiss: () => log("Do something onDismiss"),
                );
                progressDialog.show();
                if (palletDetails?.data?.id != null) {
                  await _webservices
                      .updatePallet(
                          body, palletDetails?.data?.id?.toInt() ?? -1)
                      .then((value) {
                    progressDialog.dismiss();
                    if (value) {
                      Get.back();
                    }
                  });
                } else {
                  await _webservices.storePallet(body).then((value) {
                    progressDialog.dismiss();
                    if (value) {
                      Get.back();
                    }
                  });
                }
              }
            },
            child: Container(
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
            ),
          )
        ],
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Form(
          key: _formKey,
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
                      label: selectedLocation?.name ?? "Search Location",
                      ontap: pList.isNotEmpty
                          ? () {
                              Fluttertoast.showToast(
                                  msg: "Cannot change location");
                            }
                          : () async {
                              Location? locationVal = await Get.to<dynamic>(
                                  () => const ChooseSKUScreen(
                                        type: "Location",
                                      ));

                              setState(() {
                                selectedLocation = locationVal;
                              });
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
                            ontap: pList.isNotEmpty && selectedPallet != null
                                ? () {
                                    Fluttertoast.showToast(
                                        msg: "Cannot change pallet");
                                  }
                                : () async {
                                    MasterPallet? locationVal =
                                        await Get.to<dynamic>(
                                            () => const ChooseSKUScreen(
                                                  type: "Pallet",
                                                ));

                                    if (locationVal != null) {
                                      selectedPallet = locationVal;
                                      palletMatch = false;
                                      //fillPallet(locationVal);
                                    }
                                    setState(() {});
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
                              if (selectedPallet == null) {
                                var index = controller.masterPallets.indexWhere(
                                    (element) =>
                                        element.name == barcodeScanRes);
                                if (index != -1) {
                                  setState(() {
                                    selectedPallet =
                                        controller.masterPallets[index];
                                    palletMatch = true;
                                  });
                                  fillPallet(selectedPallet!);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Selected Pallet is invalid");
                                }
                              } else if (selectedPallet != null) {
                                if (selectedPallet?.name != barcodeScanRes) {
                                  Fluttertoast.showToast(
                                      msg: "Pallet number is not matching");
                                  selectedPallet = null;
                                  palletMatch = false;
                                  setState(() {});
                                } else {
                                  fillPallet(selectedPallet!);
                                  setState(() {
                                    palletMatch = true;
                                  });
                                }
                              }
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
                            label: selectedSKU?.name ?? "SKU No.",
                            ontap: () async {
                              MasterPallet? locationVal = await Get.to<dynamic>(
                                  () => const ChooseSKUScreen(
                                        type: "SKU",
                                      ));
                              setState(() {
                                selectedSKU = locationVal;
                              });
                            },
                          ),
                        ),
                        // SizedBox(width: 5.w),
                        // Expanded(
                        //   child: DefaultContainerButton(
                        //     noIcon: false,
                        //     icon: Icons.calendar_month,
                        //     label: date,
                        //     ontap: () {
                        //       _selectDate(context);
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    DefaultContainerButton(
                      noIcon: false,
                      icon: Icons.calendar_month,
                      label: date,
                      ontap: () {
                        _selectDate(context);
                      },
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultContainerButton(
                            noIcon: false,
                            icon: Icons.search,
                            label: selectedVariant?.name ?? "Variant",
                            ontap: () async {
                              MasterPallet? locationVal = await Get.to<dynamic>(
                                  () => const ChooseSKUScreen(
                                        type: "Variant",
                                      ));
                              setState(() {
                                selectedVariant = locationVal;
                              });
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
                        onTap: () {
                          if (selectedLocation == null) {
                            Fluttertoast.showToast(
                                msg: "Please select location first");
                          } else if (selectedPallet == null) {
                            Fluttertoast.showToast(
                                msg: "Please select Pallet first");
                          } else if (!palletMatch) {
                            Fluttertoast.showToast(
                                msg: "Please scan Pallet first");
                          } else if (selectedSKU == null) {
                            Fluttertoast.showToast(msg: "Please select SKU");
                          } else if (selectedVariant == null) {
                            Fluttertoast.showToast(
                                msg: "Please select variant");
                          } else {
                            if (_formKey.currentState?.validate() ?? false) {
                              FocusScope.of(context).unfocus();
                              num tempWeight = num.parse(weight.text);
                              if (getRemainingWeight() == 0) {
                                Fluttertoast.showToast(
                                    msg: "Pallet/Container is Full");
                              } else if (tempWeight > getRemainingWeight()) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Please enter weight less than ${getRemainingWeight()}");
                              } else {
                                int tempIndex = listPallets.indexWhere(
                                    (element) =>
                                        element.skuCodeId == selectedSKU?.id);
                                if (tempIndex == -1) {
                                  String formattedDate = DateFormat('ddMMyyyy')
                                      .format(selectedDate);
                                  String formattedDateActual =
                                      DateFormat('yyyy-MM-dd')
                                          .format(selectedDate);
                                  log(formattedDateActual, name: "Batch Name");
                                  pList.add({
                                    "id": null,
                                    "sku_code_id": selectedSKU?.id,
                                    "variant_id": selectedVariant?.id,
                                    "weight": num.tryParse(weight.text),
                                    "batch":
                                        "${selectedLocation?.abbr}$formattedDate",
                                    "batch_date": formattedDateActual
                                  });
                                  totalWeight =
                                      totalWeight + num.parse(weight.text);
                                  listPallets.add(PalletDetail(
                                      batch:
                                          "${selectedLocation?.abbr}$formattedDate",
                                      id: null,
                                      mappedWeight: "",
                                      skuCodeId: selectedSKU?.id,
                                      skuCodeName: selectedSKU?.name,
                                      variantId: selectedVariant?.id,
                                      variantName: selectedVariant?.name,
                                      weight: weight.text));
                                  selectedVariant = null;
                                  selectedSKU = null;
                                  weight.clear();
                                  setState(() {});
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "SKU Already Exist in Pallet");
                                  setState(() {
                                    selectedSKU = null;
                                    selectedVariant = null;
                                    weight.clear();
                                  });
                                }
                              }
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 2.5.w),
                    Expanded(
                      child: DefaultBtn(
                        kolor: Colors.green,
                        label: "Request WH",
                        onTap: () async {
                          if (pList.isEmpty) {
                            Fluttertoast.showToast(msg: "Please add Pallet");
                          } else {
                            Map<String, dynamic> body = {
                              "location_id": selectedLocation?.id,
                              "master_pallet_id": selectedPallet?.id,
                              "updated_by": GlobalVariables.user?.id,
                              "is_request_for_warehouse": true,
                              "pallet_details": pList
                            };
                            log(body.toString(), name: "Body+");
                            CustomProgressDialog progressDialog =
                                // ignore: use_build_context_synchronously
                                CustomProgressDialog(
                              context,
                              blur: 10,
                              dismissable: false,
                              onDismiss: () => log("Do something onDismiss"),
                            );
                            progressDialog.show();
                            if (palletDetails?.data?.id != null) {
                              await _webservices
                                  .updatePallet(body,
                                      palletDetails?.data?.id?.toInt() ?? -1)
                                  .then((value) {
                                progressDialog.dismiss();
                                if (value) {
                                  Get.back();
                                }
                              });
                            } else {
                              await _webservices
                                  .storePallet(body)
                                  .then((value) {
                                progressDialog.dismiss();
                                if (value) {
                                  Get.back();
                                }
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              Visibility(
                visible: selectedPallet != null,
                child: Text.rich(
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
                        text:
                            "$totalWeight / ${selectedPallet?.name?[0] == 'P' ? controller.maxWeightForPallet.value : controller.maxWeightForContainer.value} KG",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: false,
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                  physics: const BouncingScrollPhysics(),
                  itemCount: listPallets.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        whTile(listPallets[index], index),
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
    );
  }

  Widget whTile(PalletDetail? pallet, int index) {
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
                  "SKU: ${pallet?.skuCodeName ?? '---'}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "VAR: ${pallet?.variantName ?? "---"}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "WEIGHT: ${pallet?.weight ?? "---"}KG",
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
                onTap: () async {
                  var tempPallet = await Get.to<PalletDetail>(() => EditPallet(
                        palletName: selectedPallet?.name ?? "--",
                        maxWeight: getRemainingWeight(),
                        pallet: pallet,
                      ));
                  if (tempPallet != null) {
                    String formattedDateActual =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                    pallet = tempPallet;
                    listPallets[index] = tempPallet;
                    pList[index] = {
                      "id": tempPallet.id,
                      "sku_code_id": tempPallet.skuCodeId,
                      "variant_id": tempPallet.variantId,
                      "weight": num.tryParse(tempPallet.weight ?? "0.0"),
                      "batch": tempPallet.batch,
                      "batch_date": formattedDateActual
                    };
                  }

                  num xWeight = 0;
                  for (var e in pList) {
                    xWeight = xWeight + e["weight"];
                  }
                  totalWeight = xWeight;
                  setState(() {});
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
                          'Sku ID: ${pallet?.skuCodeName}',
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
                      pList.removeWhere((element) =>
                          element["sku_code_id"] == pallet?.skuCodeId);
                      listPallets.remove(pallet);
                      totalWeight =
                          totalWeight - num.parse(pallet?.weight ?? "0.0");
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
