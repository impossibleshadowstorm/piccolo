// To parse this JSON data, do
//
//     final rtPalletModel = rtPalletModelFromJson(jsonString);

import 'dart:convert';

RtPalletModel rtPalletModelFromJson(String str) =>
    RtPalletModel.fromJson(json.decode(str));

String rtPalletModelToJson(RtPalletModel data) => json.encode(data.toJson());

class RtPalletModel {
  List<Datum>? data;

  RtPalletModel({
    this.data,
  });

  factory RtPalletModel.fromJson(Map<String, dynamic> json) => RtPalletModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? fromLocationableType;
  int? fromLocationableId;
  String? toLocationableType;
  dynamic toLocationableId;
  int? palletId;
  Pallet? pallet;

  Datum({
    this.id,
    this.fromLocationableType,
    this.fromLocationableId,
    this.toLocationableType,
    this.toLocationableId,
    this.palletId,
    this.pallet,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fromLocationableType: json["from_locationable_type"],
        fromLocationableId: json["from_locationable_id"],
        toLocationableType: json["to_locationable_type"],
        toLocationableId: json["to_locationable_id"],
        palletId: json["pallet_id"],
        pallet: json["pallet"] == null ? null : Pallet.fromJson(json["pallet"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_locationable_type": fromLocationableType,
        "from_locationable_id": fromLocationableId,
        "to_locationable_type": toLocationableType,
        "to_locationable_id": toLocationableId,
        "pallet_id": palletId,
        "pallet": pallet?.toJson(),
      };
}

class Pallet {
  int? id;
  int? masterPalletId;
  MasterPallet? masterPallet;

  Pallet({
    this.id,
    this.masterPalletId,
    this.masterPallet,
  });

  factory Pallet.fromJson(Map<String, dynamic> json) => Pallet(
        id: json["id"],
        masterPalletId: json["master_pallet_id"],
        masterPallet: json["master_pallet"] == null
            ? null
            : MasterPallet.fromJson(json["master_pallet"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "master_pallet_id": masterPalletId,
        "master_pallet": masterPallet?.toJson(),
      };
}

class MasterPallet {
  int? id;
  String? name;

  MasterPallet({
    this.id,
    this.name,
  });

  factory MasterPallet.fromJson(Map<String, dynamic> json) => MasterPallet(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
