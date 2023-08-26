// To parse this JSON data, do
//
//     final rtCreateModel = rtCreateModelFromJson(jsonString);

import 'dart:convert';

RtCreateModel rtCreateModelFromJson(String str) =>
    RtCreateModel.fromJson(json.decode(str));

String rtCreateModelToJson(RtCreateModel data) => json.encode(data.toJson());

class RtCreateModel {
  Data? data;

  RtCreateModel({
    this.data,
  });

  factory RtCreateModel.fromJson(Map<String, dynamic> json) => RtCreateModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  List<dynamic>? reachTrucks;
  List<FromLocation>? fromLocations;
  String? fromLocationType;
  String? toLocationType;
  List<ToLocation>? toLocations;

  Data({
    this.reachTrucks,
    this.fromLocations,
    this.fromLocationType,
    this.toLocationType,
    this.toLocations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reachTrucks: json["reachTrucks"] == null
            ? []
            : List<dynamic>.from(json["reachTrucks"]!.map((x) => x)),
        fromLocations: json["fromLocations"] == null
            ? []
            : List<FromLocation>.from(
                json["fromLocations"]!.map((x) => FromLocation.fromJson(x))),
        fromLocationType: json["fromLocationType"],
        toLocationType: json["toLocationType"],
        toLocations: json["toLocations"] == null
            ? []
            : List<ToLocation>.from(
                json["toLocations"]!.map((x) => ToLocation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reachTrucks": reachTrucks == null
            ? []
            : List<dynamic>.from(reachTrucks!.map((x) => x)),
        "fromLocations": fromLocations == null
            ? []
            : List<dynamic>.from(fromLocations!.map((x) => x.toJson())),
        "fromLocationType": fromLocationType,
        "toLocationType": toLocationType,
        "toLocations": toLocations == null
            ? []
            : List<dynamic>.from(toLocations!.map((x) => x.toJson())),
      };
}

class FromLocation {
  int? id;
  String? name;
  String? abbr;

  FromLocation({
    this.id,
    this.name,
    this.abbr,
  });

  factory FromLocation.fromJson(Map<String, dynamic> json) => FromLocation(
        id: json["id"],
        name: json["name"],
        abbr: json["abbr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "abbr": abbr,
      };
}

class ToLocation {
  int? id;
  String? name;

  ToLocation({
    this.id,
    this.name,
  });

  factory ToLocation.fromJson(Map<String, dynamic> json) => ToLocation(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
