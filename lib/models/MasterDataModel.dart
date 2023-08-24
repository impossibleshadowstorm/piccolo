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
  int? maxWeightForPallet;
  int? maxWeightForContainer;

  Data({
    this.masterPallets,
    this.skuCodes,
    this.variants,
    this.locations,
    this.maxWeightForPallet,
    this.maxWeightForContainer,
  });

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        masterPallets: List<MasterPallet>.from(
            json["masterPallets"].map((x) => MasterPallet.fromJson(x))),
        skuCodes: List<MasterPallet>.from(
            json["skuCodes"].map((x) => MasterPallet.fromJson(x))),
        variants: List<MasterPallet>.from(
            json["variants"].map((x) => MasterPallet.fromJson(x))),
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        maxWeightForPallet: json["maxWeightForPallet"],
        maxWeightForContainer: json["maxWeightForContainer"],
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
