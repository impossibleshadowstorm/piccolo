import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:piccolo/models/FGModels/FGOrderListModel.dart';
import 'package:piccolo/services/webservices.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants.dart';

class FinishedGoodsOrderScreen extends StatefulWidget {
  const FinishedGoodsOrderScreen({super.key});

  @override
  State<FinishedGoodsOrderScreen> createState() =>
      _FinishedGoodsOrderScreenState();
}

class _FinishedGoodsOrderScreenState extends State<FinishedGoodsOrderScreen> {
  bool loading = true;
  FgOrderListModel model = FgOrderListModel();
  List<FGOrderItem> all = [];
  List<FGOrderItem> filteredList = [];
  final Webservices _webservices = Webservices();

  Future<void> fetchData() async {
    await _webservices.getFGOrderList().then((value) {
      if (value != null) {
        model = value;
        filteredList = [...value.data!];
        all = [...value.data!];
        loading = false;
        setState(() {});
      }
    });
  }

  completeOrder(int id) async {
    CustomProgressDialog progressDialog =
        // ignore: use_build_context_synchronously
        CustomProgressDialog(
      context,
      blur: 10,
      dismissable: false,
      onDismiss: () => log("Do something onDismiss"),
    );
    progressDialog.show();
    await _webservices.completeFGOrder(id).then((value) {
      if (value) {
        fetchData().whenComplete(() {
          progressDialog.dismiss();
        });
      } else {
        progressDialog.dismiss();
      }
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  int lenght = 5;
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
          "Order List",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
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
          : SizedBox(
              height: 100.h,
              width: 100.w,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          Divider(
                            height: 4.h,
                            color: Constants.primaryOrangeColor,
                            thickness: 2,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              if (val.isNotEmpty) {
                                filteredList.clear();
                                for (var element in all) {
                                  if (element.orderNumber
                                          ?.toLowerCase()
                                          .contains(val.toLowerCase()) ??
                                      false) {
                                    filteredList.add(element);
                                  }
                                }
                              } else if (val.isEmpty) {
                                filteredList.clear();
                                for (var element in all) {
                                  filteredList.add(element);
                                }
                              }
                              setState(() {});
                            },
                            style: TextStyle(
                                color: Colors.black, fontSize: 18.0.sp),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5.0.w, vertical: 1.0.h),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Choose or Type",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 19.sp,
                              ),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.symmetric(vertical: 2.0.h),
                                itemCount: filteredList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      whTile(index),
                                      Divider(
                                        height: 3.h,
                                        color: Constants.primaryOrangeColor,
                                        thickness: 2,
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget whTile(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            filteredList[index].orderNumber ?? "---",
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.question,
                animType: AnimType.rightSlide,
                title: 'Alert!!!',
                body: Column(
                  children: [
                    Text(
                      "Order No:- ${filteredList[index].orderNumber ?? "---"}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Are you sure to mark this order complete?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  completeOrder(filteredList[index].id ?? -1);
                },
              ).show();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0.w))),
            child: Text(
              "Set Complete",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
