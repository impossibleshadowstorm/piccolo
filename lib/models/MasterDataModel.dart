// To parse this JSON data, do
//
//     final masterData = masterDataFromJson(jsonString?);

import 'dart:convert';

MasterData masterDataFromJson(String? str) =>
    MasterData.fromJson(json.decode(str!));

class MasterData {
  Data? data;

  MasterData({
    this.data,
  });

  factory MasterData.fromJson(Map<String?, dynamic> json) => MasterData(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  List<MasterPallet>? masterPallets;
  List<MasterPallet>? skuCodes;
  List<MasterPallet>? variants;
  List<Location>? locations;
  List<Orders>? order;
  int? maxWeightForPallet;
  int? maxWeightForContainer;

  Data({
    this.masterPallets,
    this.skuCodes,
    this.variants,
    this.order,
    this.locations,
    this.maxWeightForPallet,
    this.maxWeightForContainer,
  });

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        order: json["orders"] == null
            ? []
            : List<Orders>.from(json["orders"].map((x) => Orders.fromJson(x))),
        masterPallets: List<MasterPallet>.from(
            json["masterPallets"].map((x) => MasterPallet.fromJson(x))),
        skuCodes: json["skuCodes"] == null
            ? []
            : List<MasterPallet>.from(
                json["skuCodes"].map((x) => MasterPallet.fromJson(x))),
        variants: json["variants"] == null
            ? []
            : List<MasterPallet>.from(
                json["variants"].map((x) => MasterPallet.fromJson(x))),
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        maxWeightForPallet: json["maxWeightForPallet"] ?? 0,
        maxWeightForContainer: json["maxWeightForContainer"] ?? 0,
      );
}

class Location {
  int? id;
  String? name;
  String? abbr;

  Location({
    this.id,
    this.name,
    this.abbr,
  });

  factory Location.fromJson(Map<String?, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        abbr: json["abbr"],
      );
}

class Orders {
  int? id;
  String? name;

  Orders({
    this.id,
    this.name,
  });

  factory Orders.fromJson(Map<String?, dynamic> json) => Orders(
        id: json["id"],
        name: json["order_number"],
      );
}

class MasterPallet {
  int? id;
  String? name;

  MasterPallet({
    this.id,
    this.name,
  });

  factory MasterPallet.fromJson(Map<String?, dynamic> json) => MasterPallet(
        id: json["id"],
        name: json["name"],
      );
}
