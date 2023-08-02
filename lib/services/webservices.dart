import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:hive/hive.dart';
import 'package:piccolo/GlobalVariables.dart';
import 'package:piccolo/constants.dart';

import '../models/LoginModel.dart';

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
      log("Fatal Error in Login User API:- ${e.toString()}", name: "");
      return null;
    }
  }
}
