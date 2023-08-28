import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:piccolo/GlobalVariables.dart';
import 'package:piccolo/constants.dart';
import 'package:piccolo/controller/PalletGetController.dart';
import 'package:piccolo/models/MasterDataModel.dart';
import 'package:piccolo/models/RTModels/RTCreateModel.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/widgets/DefaultContainerButton.dart';
import '../../common/widgets/ScanContainer.dart';
import '../../models/RTModels/RTPalletModel.dart' as p;
import '../../services/webservices.dart';
import '../pallet_management/choose_sku_screen.dart';

class RTGlass extends StatefulWidget {
  final String label;
  const RTGlass({super.key, required this.label});

  @override
  State<RTGlass> createState() => _RTGlassState();
}

class _RTGlassState extends State<RTGlass> {
  final Webservices _webservices = Webservices();
  bool loading = true;
  RtCreateModel model = RtCreateModel();
  FromLocation? selectedFromLocation;
  ToLocation? selectedToLocation;
  final controller = PalletGetController.palletController;
  p.RtPalletModel palletModel = p.RtPalletModel();
  String? dropdownValue;
  List<String> options = [];
  bool palletMatch = false;
  bool palletScanned = true;
  bool dropdownDisable = false;
  String? selectedDrop;
  List<String> palletItems = ["Pallet No. 1", "Pallet No. 2", "Pallet No. 3"];
  List<String> dropItems = ["Drop No. 1", "Drop No. 2", "Drop No. 3"];

  fetchData() async {
    await _webservices.getRTCreateDetails(widget.label).then((value) {
      loading = false;
      if (value != null) {
        controller.locationsList.clear();
        controller.dropLocationsList.clear();
        model = value;
        value.data?.fromLocations?.forEach((element) {
          var val = element;
          controller.locationsList.add(val);
        });
        value.data?.toLocations?.forEach((element) {
          controller.dropLocationsList.add(element);
        });
      }
      setState(() {});
    });
  }

  void setDrop() {
    for (var element in controller.dropLocationsList) {
      int index = palletModel.data?.indexWhere((element) =>
              element.pallet?.masterPallet?.name == dropdownValue) ??
          -1;
      if (index != -1) {}
      if (element.id.toString() ==
          palletModel.data?[index].toLocationableId.toString()) {
        selectedToLocation = element;
        dropdownDisable = true;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    fetchData();
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
      body: loading
          ? const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
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
                    label:
                        selectedFromLocation?.name ?? "Choose Pickup Location",
                    ontap: () async {
                      FromLocation? locationVal =
                          await Get.to<dynamic>(() => const ChooseSKUScreen(
                                type: "Location",
                              ));
                      selectedFromLocation = locationVal;
                      setState(() {});
                      CustomProgressDialog progressDialog =
                          // ignore: use_build_context_synchronously
                          CustomProgressDialog(
                        context,
                        blur: 10,
                        dismissable: false,
                        onDismiss: () => log("Do something onDismiss"),
                      );
                      progressDialog.show();
                      Map<String, dynamic> body = {
                        "from_locationable_type": model.data?.fromLocationType,
                        "from_locationable_id": selectedFromLocation?.id,
                        "location_type": widget.label
                      };
                      await _webservices.getRTPalletDetails(body).then((value) {
                        progressDialog.dismiss();
                        if (value != null) {
                          palletModel = value;
                          options.clear();
                          value.data?.forEach((element) {
                            options.add(
                                element.pallet?.masterPallet?.name ?? "---");
                          });
                        }
                        setState(() {});
                      });
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
                        child: Container(
                          height: 6.0.h,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: 1.5.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.0.w, vertical: 0.0.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                              "Choose Pallet".toTitleCase(),
                              style: TextStyle(
                                color: Colors.black,
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
                              setDrop();
                            },
                            items: options
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        // child: DefaultContainerButton(
                        //   noIcon: false,
                        //   icon: Icons.search,
                        //   label: "Choose Pallet",
                        //   ontap: () {
                        //     Get.to(() => const ChooseSKUScreen(
                        //           type: "Pallet",
                        //         ));
                        //   },
                        // ),
                      ),
                      SizedBox(
                        width: 3.0.w,
                      ),
                      Expanded(
                        flex: 2,
                        child: ScanContainer(
                          onTap: () async {
                            if (selectedFromLocation == null) {
                              Fluttertoast.showToast(
                                  msg: "Please select location first");
                            } else {
                              String barcodeScanRes =
                                  await FlutterBarcodeScanner.scanBarcode(
                                      "#808080",
                                      "Cancel",
                                      true,
                                      ScanMode.BARCODE);
                              log(barcodeScanRes, name: "BarCode Value");
                              if (dropdownValue == null) {
                                dropdownValue = barcodeScanRes;
                                palletMatch = true;
                                palletScanned = true;
                              } else {
                                if (dropdownValue == barcodeScanRes) {
                                  palletMatch = true;
                                  palletScanned = true;
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Pallet does not match");
                                  dropdownValue = null;
                                  palletMatch = false;
                                  palletScanned = true;
                                }
                              }
                              setState(() {});
                            }
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
                          label: selectedToLocation?.name ?? "Search Drop",
                          ontap: () async {
                            if (selectedFromLocation == null) {
                              Fluttertoast.showToast(
                                  msg: "Please select pickup location first");
                            } else if (dropdownValue == null) {
                              Fluttertoast.showToast(
                                  msg: "Please select pallet");
                            } else {
                              if (dropdownDisable) {
                              } else {
                                ToLocation? val = await Get.to<dynamic>(
                                    () => const ChooseSKUScreen(
                                          type: "Drop",
                                        ));

                                selectedToLocation = val;
                                setState(() {});
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 3.0.w,
                      ),
                      Visibility(
                        visible: (widget.label == "GLASS" ||
                            widget.label == "CERAMIC" ||
                            widget.label == "RECYCLE" ||
                            widget.label == "ASSEMBLY LINE TO WH"),
                        child: Expanded(
                          flex: 2,
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
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.label == "ASSEMBLY LINE TO WH",
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.5.w, vertical: 0.5.h),
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
                  ),
                  SizedBox(
                    height: 1.0.h,
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
                        onPressed: () async {
                          if (!palletScanned) {
                            Fluttertoast.showToast(msg: "Please Scan Pallet");
                          } else {
                            Map<String, dynamic> body = {
                              "transfered_by": GlobalVariables.user?.id,
                              "reach_truck_id": palletModel.data
                                      ?.firstWhereOrNull((element) =>
                                          element.pallet?.masterPallet?.name ==
                                          dropdownValue)
                                      ?.id ??
                                  0,
                              "from_locationable_type":
                                  model.data?.fromLocationType,
                              "from_locationable_id": selectedFromLocation?.id,
                              "to_locationable_type":
                                  model.data?.toLocationType,
                              "to_locationable_id": selectedToLocation?.id,
                              "created_by": GlobalVariables.user?.id,
                              "updated_by": GlobalVariables.user?.id
                            };
                            CustomProgressDialog progressDialog =
                                // ignore: use_build_context_synchronously
                                CustomProgressDialog(
                              context,
                              blur: 10,
                              dismissable: false,
                              onDismiss: () => log("Do something onDismiss"),
                            );
                            progressDialog.show();
                            await _webservices
                                .storeRTDetail(body)
                                .then((value) {
                              progressDialog.dismiss();
                              if (value) {
                                Get.back(result: true);
                              }
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0.w)),
                            backgroundColor: Constants.primaryOrangeColor),
                        child: Text(
                          "Drop Pallet",
                          // "Drop Pallet in WH",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0.sp,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                  Visibility(
                    visible: (palletMatch),
                    child: Container(
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
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
