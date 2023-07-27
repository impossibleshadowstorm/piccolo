import 'package:flutter/material.dart';
import 'package:piccolo/common/widgets/buttons.dart';
import 'package:piccolo/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                            color: Colors.white70,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Container(
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.5.w),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "USER ID",
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Container(
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.5.w),
                          ),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: "PASSWORD",
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        CommonButtons.primaryOrangeFilledButton("Login", null)
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
