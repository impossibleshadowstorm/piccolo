// To parse this JSON data, do
//
//     final fgOrderListModel = fgOrderListModelFromJson(jsonString);

import 'dart:convert';

FgOrderListModel fgOrderListModelFromJson(String str) =>
    FgOrderListModel.fromJson(json.decode(str));

String fgOrderListModelToJson(FgOrderListModel data) =>
    json.encode(data.toJson());

class FgOrderListModel {
  List<FGOrderItem>? data;

  FgOrderListModel({
    this.data,
  });

  factory FgOrderListModel.fromJson(Map<String, dynamic> json) =>
      FgOrderListModel(
        data: json["data"] == null
            ? []
            : List<FGOrderItem>.from(
                json["data"]!.map((x) => FGOrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FGOrderItem {
  int? id;
  String? orderNumber;

  FGOrderItem({
    this.id,
    this.orderNumber,
  });

  factory FGOrderItem.fromJson(Map<String, dynamic> json) => FGOrderItem(
        id: json["id"],
        orderNumber: json["order_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNumber,
      };
}
