import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piccolo/constants.dart';
import 'package:piccolo/controller/PalletGetController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChooseSKUScreen extends StatefulWidget {
  final String type;
  const ChooseSKUScreen({super.key, required this.type});

  @override
  State<ChooseSKUScreen> createState() => _ChooseSKUScreenState();
}

class _ChooseSKUScreenState extends State<ChooseSKUScreen> {
  final controller = PalletGetController.palletController;
  int selected = 0;
  bool loading = true;
  List all = [];
  List filteredList = [];

  @override
  void initState() {
    setState(() {
      filteredList = [...getList(widget.type)];
      all = [...getList(widget.type)];
      loading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryBackgroundColor,
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Container(height: AppBar().preferredSize.height),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              onChanged: (val) {
                if (val.isNotEmpty) {
                  filteredList.clear();
                  for (var element in all) {
                    if (element.name
                        .toLowerCase()
                        .contains(val.toLowerCase())) {
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
              decoration: InputDecoration(
                hintText: "Choose or Type ${widget.type}",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20.sp,
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 2.5.h),
            Expanded(
              child: Visibility(
                visible: !loading,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return chooseTile(index);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chooseTile(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
        Get.back(result: filteredList[index]);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 1.5.h),
        padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.5.w),
        width: 100.w,
        color: index == selected
            ? Constants.primaryOrangeColor
            : Colors.transparent,
        child: Text(
          "${filteredList[index].name}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
