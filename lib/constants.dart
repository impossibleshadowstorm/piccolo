import 'package:flutter/material.dart';
import 'package:piccolo/controller/PalletGetController.dart';

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
    default:
      return [];
  }
}
