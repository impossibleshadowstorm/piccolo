import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../GlobalVariables.dart';
import '../../common/widgets/DefaultBtn.dart';
import '../../common/widgets/DefaultContainerButton.dart';
import '../../common/widgets/ScanContainer.dart';
import '../../constants.dart';
import '../../controller/PalletGetController.dart';
import '../../models/MasterDataModel.dart';
import '../../models/PalletDetailsPMModel.dart';
import '../../services/webservices.dart';
import 'choose_sku_screen.dart';

class SKUReturnScreen extends StatefulWidget {
  const SKUReturnScreen({super.key});

  @override
  State<SKUReturnScreen> createState() => _SKUReturnScreenState();
}

class _SKUReturnScreenState extends State<SKUReturnScreen> {
  final controller = PalletGetController.palletController;
  Location? selectedLocation;
  MasterPallet? selectedPallet;
  PalletDetailsPm? palletDetails;
  List<PalletDetail> listPallets = [];
  List<Map<String, dynamic>> pList = [];
  final Webservices _webservices = Webservices();
  num totalWeight = 0;
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
          GestureDetector(
            onTap: () async {
              //log(body.toString(), name: "Body+");
              CustomProgressDialog progressDialog =
                  // ignore: use_build_context_synchronously
                  CustomProgressDialog(
                context,
                blur: 10,
                dismissable: true,
                onDismiss: () => log("Do something onDismiss"),
              );
              progressDialog.show();
              List<Map<String, dynamic>> tempList = [];
              for (var element in controller.listOfPalletItems) {
                String formattedDateActual =
                    DateFormat('yyyy-MM-dd').format(DateTime.now());
                tempList.add({
                  "id": element.id,
                  "sku_code_id": element.skuCodeId,
                  "variant_id": element.variantId,
                  "weight": num.tryParse(element.weight ?? "0.0"),
                  "batch": element.batch,
                  "batch_date": formattedDateActual
                });
              }
              Map<String, dynamic> body = {
                "location_id": selectedLocation?.id,
                "master_pallet_id": selectedPallet?.id,
                "updated_by": GlobalVariables.user?.id,
                "is_request_for_warehouse": true,
                "pallet_details": tempList
              };
              await _webservices
                  .updatePallet(body, palletDetails?.data?.id?.toInt() ?? -1)
                  .then((value) {
                progressDialog.dismiss();
                if (value) {
                  Get.back();
                }
              });
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
                    label: selectedLocation?.name ?? "Search Location",
                    ontap: () async {
                      Location? locationVal =
                          await Get.to<dynamic>(() => const ChooseSKUScreen(
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
                          ontap: () async {
                            MasterPallet? locationVal = await Get.to<dynamic>(
                                () => const ChooseSKUScreen(
                                      type: "Pallet",
                                    ));
                            selectedPallet = locationVal;
                            if (locationVal != null) {
                              CustomProgressDialog progressDialog =
                                  // ignore: use_build_context_synchronously
                                  CustomProgressDialog(
                                context,
                                blur: 10,
                                dismissable: false,
                                onDismiss: () => log("Do something onDismiss"),
                              );
                              progressDialog.show();
                              _webservices
                                  .getPalletDetails(locationVal.name!)
                                  .then((value) {
                                progressDialog.dismiss();
                                palletDetails = value;
                                selectedPallet = locationVal;
                                if (value != null) {
                                  var index = controller.masterPallets
                                      .firstWhere((element) =>
                                          element.name ==
                                          palletDetails?.data?.palletName);
                                  selectedPallet = index;

                                  var indexLoc = controller.locationsList
                                      .firstWhere((element) =>
                                          element.name ==
                                          palletDetails
                                              ?.data?.palletLastLocation);
                                  selectedLocation = indexLoc;

                                  //
                                  //
                                  controller.listOfPalletItems.clear();
                                  palletDetails?.data?.palletDetails
                                      ?.forEach((element) {
                                    controller.listOfPalletItems.add(element);
                                    listPallets.add(element);
                                    pList.add({
                                      "id": element.id,
                                      "sku_code_id": element.skuCodeId,
                                      "variant_id": element.variantId,
                                      "weight":
                                          num.tryParse(element.weight ?? "0.0"),
                                      "batch": element.batch,
                                    });
                                    totalWeight = totalWeight +
                                        num.parse(element.weight ?? "0.0");
                                  });

                                  //
                                  //
                                  setState(() {});
                                }
                                setState(() {});
                              });
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
                    onTap: () async {
                      //log(body.toString(), name: "Body+");
                      CustomProgressDialog progressDialog =
                          // ignore: use_build_context_synchronously
                          CustomProgressDialog(
                        context,
                        blur: 10,
                        dismissable: false,
                        onDismiss: () => log("Do something onDismiss"),
                      );
                      progressDialog.show();
                      List<Map<String, dynamic>> tempList = [];
                      for (var element in controller.listOfPalletItems) {
                        String formattedDateActual =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        tempList.add({
                          "id": element.id,
                          "sku_code_id": element.skuCodeId,
                          "variant_id": element.variantId,
                          "weight": num.tryParse(element.weight ?? "0.0"),
                          "batch": element.batch,
                          "batch_date": formattedDateActual
                        });
                      }
                      Map<String, dynamic> body = {
                        "location_id": selectedLocation?.id,
                        "master_pallet_id": selectedPallet?.id,
                        "updated_by": GlobalVariables.user?.id,
                        "is_request_for_warehouse": true,
                        "pallet_details": tempList
                      };
                      await _webservices
                          .updatePallet(
                              body, palletDetails?.data?.id?.toInt() ?? -1)
                          .then((value) {
                        progressDialog.dismiss();
                        if (value) {
                          Get.back();
                        }
                      });
                    },
                  ),
                  SizedBox(height: 4.h),
                  Obx(
                    () => ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => SKUReturnTile(
                              index: index,
                              weight: num.parse(
                                  controller.listOfPalletItems[index].weight ??
                                      "0.0"),
                            ),
                        separatorBuilder: (context, index) => Divider(
                              height: 5.h,
                              color: Colors.white,
                              thickness: 2,
                            ),
                        itemCount: controller.listOfPalletItems.length),
                  ),
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
}

class SKUReturnTile extends StatefulWidget {
  final int index;
  final num weight;
  const SKUReturnTile({super.key, required this.index, required this.weight});

  @override
  State<SKUReturnTile> createState() => _SKUReturnTileState();
}

class _SKUReturnTileState extends State<SKUReturnTile> {
  final controller = PalletGetController.palletController;

  TextEditingController weight = TextEditingController();

  @override
  void initState() {
    setState(() {
      weight.text = widget.weight.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  "SKU: ${controller.listOfPalletItems[widget.index].skuCodeName}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "VAR: ${controller.listOfPalletItems[widget.index].variantName}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Obx(
                  () => Text(
                    "WEIGHT: ${controller.listOfPalletItems[widget.index].weight}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                width: double.infinity,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  controller: weight,
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      num tempVal = num.tryParse(val) ?? 0.0;
                      controller.listOfPalletItems[widget.index].weight = val;
                      setState(() {});
                    }
                  },
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter weight';
                  //   }
                  //   final number = int.tryParse(value);
                  //   if (number == null) {
                  //     return 'Please enter a valid number';
                  //   }
                  //   return null;
                  // },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Weight",
                      hintStyle:
                          TextStyle(color: Colors.black, fontSize: 17.0.sp),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0.w))),
                ),
              ),
            ),
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
                        'SKU: ${controller.listOfPalletItems[widget.index].skuCodeName}',
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
                    controller.listOfPalletItems.removeAt(widget.index);
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
