import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:piccolo/common/widgets/buttons.dart';
import 'package:piccolo/constants.dart';
import 'package:piccolo/screens/pallet_management/manage_screen.dart';
import 'package:piccolo/screens/reach_truck/rt_jobs_pending.dart';
import 'package:piccolo/services/webservices.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../controller/PalletGetController.dart';
import '../finished_goods/finished_goods_manage_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final Webservices webservices = Webservices();
  final controller = PalletGetController.palletController;

  Future<void> fetchMasterDate() async {
    await webservices.fetchMaster().then((value) {
      if (value != null) {
        controller.locationsList.value = value.data?.locations ?? [];
        controller.masterPallets.value = value.data?.masterPallets ?? [];
        controller.skuCodes.value = value.data?.skuCodes ?? [];
        controller.variants.value = value.data?.variants ?? [];
        controller.maxWeightForContainer.value =
            value.data?.maxWeightForContainer ?? 0;
        controller.maxWeightForPallet.value =
            value.data?.maxWeightForPallet ?? 0;
        return;
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              SizedBox(height: AppBar().preferredSize.height / 1.5),
              Container(
                height: AppBar().preferredSize.height,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "piccolo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "EXG",
                            style: TextStyle(
                              color: Constants.primaryOrangeColor,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "ESSAS",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "User Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                            child: TextFormField(
                              controller: email,
                              validator: Validators.compose([
                                Validators.email("Please enter valid email"),
                                Validators.required("Please enter email")
                              ]),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Email",
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(3.0.w))),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                            child: TextFormField(
                              obscureText: true,
                              controller: password,
                              validator:
                                  Validators.required("Please enter password"),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Passowrd",
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(3.0.w))),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  CustomProgressDialog progressDialog =
                                      CustomProgressDialog(
                                    context,
                                    blur: 10,
                                    dismissable: false,
                                    onDismiss: () =>
                                        log("Do something onDismiss"),
                                  );
                                  progressDialog.show();
                                  webservices
                                      .loginUser(email.text, password.text)
                                      .then((value) async {
                                    await fetchMasterDate().whenComplete(() {
                                      progressDialog.dismiss();
                                      if (value != null) {
                                        if (value.data?.role ==
                                            "PALLET_CREATION") {
                                          Get.offAll(
                                              () => const ManageScreen());
                                        }
                                        // else if (value.data?.role ==
                                        //     "REACH_TRUCK") {
                                        //   Get.offAll(
                                        //       () => RTJobsPendingScreen());
                                        // } else if (value.data?.role ==
                                        //     "FG_PALLET_CREATION") {
                                        //   Get.offAll(() =>
                                        //       const FinishedGoodsManageScreen());
                                        // }
                                      }
                                    });
                                  });
                                }
                              },
                              child: CommonButtons.primaryOrangeFilledButton(
                                  "Login", null))
                        ],
                      ),
                      SizedBox(height: 10.h),
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
}
