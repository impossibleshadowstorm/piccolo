import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piccolo/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../common/widgets/DefaultBtn.dart';
import '../../common/widgets/DefaultContainerButton.dart';
import 'choose_sku_screen.dart';

class EditPallet extends StatefulWidget {
  const EditPallet({super.key});

  @override
  State<EditPallet> createState() => _EditPalletState();
}

class _EditPalletState extends State<EditPallet> {
  TextEditingController weight = TextEditingController();

  @override
  void dispose() {
    weight.dispose();
    super.dispose();
  }

  @override
  void initState() {
    weight.text = "150.0";
    setState(() {});
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
              "Pallet no. P009",
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
                        label: "1.2X1.2GGNS20-C",
                        ontap: () {
                          Get.to(() => const ChooseSKUScreen(
                                type: "SKU",
                              ));
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
                              label: "Variant",
                              ontap: () {
                                Get.to(() => const ChooseSKUScreen(
                                      type: "Variant",
                                    ));
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
                                validator:
                                    Validators.required("weight missing!!"),
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
