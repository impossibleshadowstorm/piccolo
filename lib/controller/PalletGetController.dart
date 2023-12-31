import 'package:get/get.dart';
import 'package:piccolo/models/PalletDetailsPMModel.dart';

class PalletGetController extends GetxController {
  var masterPallets = [].obs;
  var skuCodes = [].obs;
  var variants = [].obs;
  var locationsList = [].obs;
  var rtLocationsList = [].obs;
  var orderList = [].obs;
  var dropLocationsList = [].obs;
  var maxWeightForContainer = 0.obs;
  var maxWeightForPallet = 0.obs;
  var listOfPalletItems = <PalletDetail>[].obs;
  var listOfPalletItemsAPI = [].obs;

  static PalletGetController get palletController =>
      Get.find<PalletGetController>();
}
