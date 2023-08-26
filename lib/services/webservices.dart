import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as g;
import 'package:hive/hive.dart';
import 'package:piccolo/GlobalVariables.dart';
import 'package:piccolo/constants.dart';
import 'package:piccolo/models/MasterDataModel.dart';
import 'package:piccolo/models/PalletDetailsPMModel.dart';
import 'package:piccolo/models/RTModels/RTCreateModel.dart';

import '../models/LoginModel.dart';
import '../models/RTModels/HomeModel.dart';
import '../models/RTModels/RTPalletModel.dart';

class Webservices {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'content-type': 'application/json',
  }; // header

  static var options = BaseOptions(
    headers: header,
    baseUrl: "http://piccolo.suboffice.co.in/api/",
  );
  Dio dio = Dio(options);

  //API Method for Login User
  Future<LoginModel?> loginUser(String email, String password) async {
    try {
      Response res = await dio.post("masters/login",
          data: {"email": email, "password": password, "token": secutiyCode});
      if (res.data.containsKey("error")) {
        g.Get.snackbar("Failed!!", "${res.data["error"]}",
            colorText: Colors.white);
        return null;
      }
      final value = LoginModel.fromJson(res.data);

      var box = await Hive.openBox("login");
      box.clear();
      box.put("loginData", value.data);
      GlobalVariables.user = value.data;
      return value;
    } on DioException catch (d) {
      if (d.response != null) {
        if (d.response?.statusCode == 500) {
          g.Get.snackbar("Failed!!", "${d.response?.data["error"]}",
              colorText: Colors.white);
          return null;
        }
      }
      return null;
    } catch (e) {
      log("Fatal Error in Login User API:- ${e.toString()}", name: "loginUser");
      return null;
    }
  }

  //API Method to fetch Master Data
  Future<MasterData?> fetchMaster() async {
    try {
      Response res = await dio
          .post("process/pallets/create", data: {"token": secutiyCode});
      if (res.data.containsKey("error")) {
        g.Get.snackbar("Failed!!", "${res.data["error"]}",
            colorText: Colors.white);
        return null;
      }
      final responseVal = MasterData.fromJson(res.data);
      return responseVal;
    } on DioException catch (d) {
      if (d.response != null) {
        if (d.response?.statusCode == 500) {
          g.Get.snackbar("Failed!!", "${d.response?.data["error"]}",
              colorText: Colors.white);
          return null;
        }
      }
      return null;
    } catch (e) {
      log("Fatal Error in Fetch Master API:- ${e.toString()}",
          name: "fetchMaster");
      return null;
    }
  }

  //API Method to fetch Pallet Data
  Future<PalletDetailsPm?> getPalletDetails(String palletName) async {
    try {
      Map<String, dynamic> body = {
        "token": secutiyCode,
        "pallet_name": palletName
      };
      Response res =
          await dio.post("process/pallets/get-pallet-details", data: body);
      if (res.data.containsKey("error")) {
        g.Get.snackbar("Failed!!", "${res.data["error"]}",
            colorText: Colors.white);
        return null;
      }
      if (res.data["data"].runtimeType == List) {
        return null;
      } else {
        final responseVal = PalletDetailsPm.fromJson(res.data);
        return responseVal;
      }
    } on DioException catch (d) {
      if (d.response != null) {
        if (d.response?.statusCode == 500) {
          g.Get.snackbar("Failed!!", "${d.response?.data["error"]}",
              colorText: Colors.white);
          return null;
        }
      }
      return null;
    } catch (e) {
      log("Fatal Error in Fetch Pallet Details API:- ${e.toString()}",
          name: "getPalletDetails");
      return null;
    }
  }

  //API Method to Store Pallet Data
  Future<bool> storePallet(Map<String, dynamic> body) async {
    try {
      body.addAll(
          {"token": secutiyCode, "created_by": GlobalVariables.user?.id});
      Response res = await dio.post("process/pallets/store", data: body);
      Map tempMap = res.data["data"];
      if (tempMap.containsKey("success")) {
        Fluttertoast.showToast(msg: "${tempMap['success']}");
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Unable to add pallet, please try again later...");
        return false;
      }
    } on DioException catch (d) {
      if (d.response != null) {
        if (d.response?.statusCode == 500) {
          g.Get.snackbar("Failed!!", "${d.response?.data["error"]}",
              colorText: Colors.white);
          return false;
        }
      }
      return false;
    } catch (e) {
      log("Fatal Error in Store Pallet Details API:- ${e.toString()}",
          name: "storePallet");
      return false;
    }
  }

  //API Method to Update Pallet Data
  Future<bool> updatePallet(
      Map<String, dynamic> body, int masterPalletID) async {
    try {
      body.addAll(
          {"token": secutiyCode, "created_by": GlobalVariables.user?.id});
      Response res =
          await dio.put("process/pallets/update/$masterPalletID", data: body);
      Map tempMap = res.data["data"];
      if (tempMap.containsKey("success")) {
        Fluttertoast.showToast(msg: "${tempMap['success']}");
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Unable to add pallet, please try again later...");
        return false;
      }
    } on DioException catch (d) {
      if (d.response != null) {
        if (d.response?.statusCode == 500) {
          g.Get.snackbar("Failed!!", "${d.response?.data["error"]}",
              colorText: Colors.white);
          return false;
        }
      }
      return false;
    } catch (e) {
      log("Fatal Error in Update Pallet Details API:- ${e.toString()}",
          name: "updatePallet");
      return false;
    }
  }

  //################################################################# REACH TRUCK APIS ############################################################################

  //API Method to fetch RT Home Details
  Future<RtHomeModel?> getRTHome() async {
    try {
      Map body = {"token": secutiyCode};
      Response res = await dio.post("process/reach-truck/home", data: body);
      final data = RtHomeModel.fromJson(res.data);
      return data;
    } on DioException catch (d) {
      if (d.response != null) {
        if (d.response?.statusCode == 500) {
          g.Get.snackbar("Failed!!", "${d.response?.data["error"]}",
              colorText: Colors.white);
          return null;
        }
      }
      return null;
    } catch (e) {
      log("Fatal Error in Get RT Home Details API:- ${e.toString()}",
          name: "getRTHome");
      return null;
    }
  }

  //API Method to fetch RT Create Details
  Future<RtCreateModel?> getRTCreateDetails(String locationType) async {
    try {
      Map body = {"token": secutiyCode, "location_type": locationType};
      Response res = await dio.post("process/reach-truck/create", data: body);
      final data = RtCreateModel.fromJson(res.data);
      return data;
    } on DioException catch (d) {
      if (d.response != null) {
        if (d.response?.statusCode == 500) {
          g.Get.snackbar("Failed!!", "${d.response?.data["error"]}",
              colorText: Colors.white);
          return null;
        }
      }
      return null;
    } catch (e) {
      log("Fatal Error in Get RT Create Details API:- ${e.toString()}",
          name: "getRTCreateDetails");
      return null;
    }
  }

  //API Method to fetch RT Pallet Details
  Future<RtPalletModel?> getRTPalletDetails(Map<String, dynamic> body) async {
    try {
      body.addAll({"token": secutiyCode});
      Response res = await dio
          .post("process/reach-truck/get-pallet-for-reach-truck", data: body);
      final data = RtPalletModel.fromJson(res.data);
      return data;
    } on DioException catch (d) {
      if (d.response != null) {
        if (d.response?.statusCode == 500) {
          g.Get.snackbar("Failed!!", "${d.response?.data["error"]}",
              colorText: Colors.white);
          return null;
        }
      }
      return null;
    } catch (e) {
      log("Fatal Error in Get RT Pallet Details API:- ${e.toString()}",
          name: "getRTPalletDetails");
      return null;
    }
  }

  //API Method to Store RT Pallet Details
  Future<bool> storeRTDetail(Map<String, dynamic> body) async {
    try {
      body.addAll({"token": secutiyCode});
      Response res = await dio.post("process/reach-truck/store", data: body);
      log("${res.data}");
      log("${res.statusCode}");
      Fluttertoast.showToast(msg: "Pallet Drop Successfull");
      return true;
    } on DioException catch (d) {
      if (d.response != null) {
        if (d.response?.statusCode == 500) {
          log("${d.response?.data["error"]}", name: "Error");
          g.Get.snackbar("Failed!!", "${d.response?.data["error"]}",
              colorText: Colors.white);
          return false;
        }
      }
      return false;
    } catch (e) {
      log("Fatal Error in Store RT Details API:- ${e.toString()}",
          name: "storeRTDetail");
      return false;
    }
  }
}
