import 'package:flutter/material.dart';
import 'package:piccolo/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RTGlass extends StatefulWidget {
  const RTGlass({super.key});

  @override
  State<RTGlass> createState() => _RTGlassState();
}

class _RTGlassState extends State<RTGlass> {
  String dropdownValue = 'Option 1';
  List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  String? selectedPalletNo;
  String? selectedDrop;
  List<String> palletItems = ["Pallet No. 1", "Pallet No. 2", "Pallet No. 3"];
  List<String> dropItems = ["Drop No. 1", "Drop No. 2", "Drop No. 3"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Constants.primaryOrangeColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "GLASS",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                Text(
                  "Back",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 2.0.w,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.undo_sharp,
                      color: Colors.white,
                      size: 25.0.sp,
                    ))
              ],
            )
          ],
        ),
      ),
      body: Container(
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
            Container(
              height: 6.0.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 1.5.h),
              padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 0.0.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0.w)),
              child: DropdownButton(
                isExpanded: true,
                value: dropdownValue,
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 25.0.sp,
                ),
                underline: const SizedBox(),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black, fontSize: 18.0.sp),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 1.0.h),
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
                    height: 5.0.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        vertical: 1.5.h, horizontal: 2.0.w),
                    padding: EdgeInsets.symmetric(
                        horizontal: 3.0.w, vertical: 0.0.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.0.w)),
                    child: DropdownButton(
                      isExpanded: true,
                      value: selectedPalletNo,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 25.0.sp,
                      ),
                      underline: const SizedBox(),
                      iconSize: 24,
                      elevation: 16,
                      hint: Text(
                        "CHOOSE PALLET NO",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0.sp,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPalletNo = newValue!;
                        });
                      },
                      items: palletItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      height: 5.0.h,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(3.0.w)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SCAN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          Icon(
                            Icons.qr_code,
                            size: 20.0.sp,
                            color: Colors.white,
                          )
                        ],
                      )),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 5.0.h,
                    width: double.infinity,
                    margin:
                        EdgeInsets.symmetric(vertical: 0.h, horizontal: 2.0.w),
                    padding: EdgeInsets.symmetric(
                        horizontal: 3.0.w, vertical: 0.0.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.0.w)),
                    child: DropdownButton(
                      isExpanded: true,
                      value: selectedDrop,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 25.0.sp,
                      ),
                      underline: const SizedBox(),
                      iconSize: 24,
                      elevation: 16,
                      hint: Text(
                        "CHOOSE DROP",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0.sp,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDrop = newValue!;
                        });
                      },
                      items: dropItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      height: 5.0.h,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(3.0.w)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SCAN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          Icon(
                            Icons.qr_code,
                            size: 20.0.sp,
                            color: Colors.white,
                          )
                        ],
                      )),
                )
              ],
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Constants.primaryOrangeColor,
              margin: EdgeInsets.symmetric(vertical: 2.h),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0.w)),
                      backgroundColor: Constants.primaryOrangeColor),
                  child: Text(
                    "DROP PALLET IN WH",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0.sp,
                        fontWeight: FontWeight.w400),
                  )),
            ),
            selectedPalletNo == "Pallet No. 1"
                ? Container(
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
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
