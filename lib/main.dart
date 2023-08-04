import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:piccolo/models/LoginModel.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_create_pallet_screen.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_manage_screen.dart';
import 'package:piccolo/screens/finished_goods/finished_goods_order_screen.dart';
import 'package:piccolo/screens/pallet_management/edit_pallet.dart';
import 'package:piccolo/screens/reach_truck/assembly_to_return.dart';
import 'package:piccolo/screens/reach_truck/rt_jobs_pending.dart';
import 'package:piccolo/screens/splash_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LoginDataAdapter());

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
        home: const SplashScreen(),
      );
    });
  }
}
