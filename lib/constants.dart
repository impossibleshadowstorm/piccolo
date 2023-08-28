import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:piccolo/controller/PalletGetController.dart';
import 'package:piccolo/screens/pallet_management/login_screen.dart';

class Constants {
  static Color primaryBackgroundColor = const Color(0xFF2B2A28);
  static Color primaryOrangeColor = const Color(0xFFEE7F1A);
}

const String secutiyCode = "piccoloDashboard@1";

extension StringExtension on String {
  String toTitleCase() {
    if (this.isEmpty) {
      return this;
    }

    final List<String> words = this.trim().split(' ');
    final List<String> capitalizedWords = [];

    for (final String word in words) {
      final String firstLetter = word[0].toUpperCase();
      final String remainingLetters = word.substring(1).toLowerCase();
      capitalizedWords.add('$firstLetter$remainingLetters');
    }

    return capitalizedWords.join(' ');
  }
}

Future<void> logout() async {
  final controller = PalletGetController.palletController;
  controller.dropLocationsList.clear();
  controller.listOfPalletItems.clear();
  controller.locationsList.clear();
  controller.masterPallets.clear();
  controller.maxWeightForContainer.value = 0;
  controller.maxWeightForPallet.value = 0;
  controller.skuCodes.clear();
  controller.variants.clear();
  controller.orderList.clear();
  controller.dropLocationsList.clear();
  controller.listOfPalletItems.clear();
  var box = await Hive.openBox("login");
  box.clear();
  Get.offAll(() => const LoginScreen());
}

List getList(String label) {
  final controller = PalletGetController.palletController;
  switch (label) {
    case 'Location':
      return controller.locationsList;
    case 'Pallet':
      return controller.masterPallets;
    case 'SKU':
      return controller.skuCodes;
    case 'Variant':
      return controller.variants;
    case 'Drop':
      return controller.dropLocationsList;
    case 'Order':
      return controller.orderList;
    default:
      return [];
  }
}
