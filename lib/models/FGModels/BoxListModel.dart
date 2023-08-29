// To parse this JSON data, do
//
//     final boxListModel = boxListModelFromJson(jsonString);

import 'dart:convert';

BoxListModel boxListModelFromJson(String str) =>
    BoxListModel.fromJson(json.decode(str));

String boxListModelToJson(BoxListModel data) => json.encode(data.toJson());

class BoxListModel {
  Data? data;

  BoxListModel({
    this.data,
  });

  factory BoxListModel.fromJson(Map<String, dynamic> json) => BoxListModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? palletName;
  String? palletLastLocation;
  String? whLastLocation;
  String? orderName;
  int? orderId;
  List<PalletBoxDetail>? palletBoxDetails;

  Data(
      {this.id,
      this.palletName,
      this.palletLastLocation,
      this.whLastLocation,
      this.palletBoxDetails,
      this.orderId,
      this.orderName});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        palletName: json["pallet_name"],
        palletLastLocation: json["pallet_last_location"],
        orderId: json["order_id"],
        orderName: json["order_name"],
        whLastLocation: json["wh_last_location"],
        palletBoxDetails: json["palletBoxDetails"] == null
            ? []
            : List<PalletBoxDetail>.from(json["palletBoxDetails"]!
                .map((x) => PalletBoxDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pallet_name": palletName,
        "pallet_last_location": palletLastLocation,
        "wh_last_location": whLastLocation,
        "palletBoxDetails": palletBoxDetails == null
            ? []
            : List<dynamic>.from(palletBoxDetails!.map((x) => x.toJson())),
      };
}

class PalletBoxDetail {
  int? id;
  String? boxName;

  PalletBoxDetail({
    this.id,
    this.boxName,
  });

  factory PalletBoxDetail.fromJson(Map<String, dynamic> json) =>
      PalletBoxDetail(
        id: json["id"],
        boxName: json["box_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "box_name": boxName,
      };
}
