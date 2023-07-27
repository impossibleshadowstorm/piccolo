import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_create_pallet_screen.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_manage_screen.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_order_screen.dart';
import 'package:piccolo/screens/pallet_management/choose_sku_screen.dart';
import 'package:piccolo/screens/pallet_management/increase_capacity_screen.dart';
import 'package:piccolo/screens/pallet_management/manage_screen.dart';
import 'package:piccolo/screens/pallet_management/sku_return_screen.dart';
import 'package:piccolo/screens/reach_truck/assembly_to_return.dart';
import 'package:piccolo/screens/reach_truck/rt_glass.dart';
import 'package:piccolo/screens/reach_truck/rt_jobs_pending.dart';
import 'package:piccolo/screens/reach_truck/wh_to_assembly.dart';
import 'package:piccolo/screens/reach_truck/wh_to_loading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, type) {
      return GetMaterialApp(
        title: 'Piccolo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const IncreaseCapacityScreen(),
      );
    });
  }
}
