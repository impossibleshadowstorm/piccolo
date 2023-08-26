// To parse this JSON data, do
//
//     final rtHomeModel = rtHomeModelFromJson(jsonString);

import 'dart:convert';

RtHomeModel rtHomeModelFromJson(String str) =>
    RtHomeModel.fromJson(json.decode(str));

String rtHomeModelToJson(RtHomeModel data) => json.encode(data.toJson());

class RtHomeModel {
  List<HomeItem>? data;

  RtHomeModel({
    this.data,
  });

  factory RtHomeModel.fromJson(Map<String, dynamic> json) => RtHomeModel(
        data: json["data"] == null
            ? []
            : List<HomeItem>.from(
                json["data"]!.map((x) => HomeItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HomeItem {
  String? type;
  int? total;

  HomeItem({
    this.type,
    this.total,
  });

  factory HomeItem.fromJson(Map<String, dynamic> json) => HomeItem(
        type: json["type"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "total": total,
      };
}
