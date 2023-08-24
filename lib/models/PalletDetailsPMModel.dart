class PalletDetailsPm {
  Data? data;

  PalletDetailsPm({this.data});

  factory PalletDetailsPm.fromJson(Map<String, dynamic> json) {
    return PalletDetailsPm(
      data: json['data'] == null
          ? null
          : Data.fromJson(Map<String, dynamic>.from(json['data'])),
    );
  }

  Map<String, dynamic> toJson() => {
        if (data != null) 'data': data?.toJson(),
      };
}

class PalletDetail {
  num? id;
  num? skuCodeId;
  String? skuCodeName;
  num? variantId;
  String? variantName;
  String? weight;
  String? batch;
  String? mappedWeight;

  PalletDetail({
    this.id,
    this.skuCodeId,
    this.skuCodeName,
    this.variantId,
    this.variantName,
    this.weight,
    this.batch,
    this.mappedWeight,
  });

  factory PalletDetail.fromJson(Map<String, dynamic> json) => PalletDetail(
        id: num.tryParse(json['id'].toString()),
        skuCodeId: num.tryParse(json['sku_code_id'].toString()),
        skuCodeName: json['sku_code_name']?.toString(),
        variantId: num.tryParse(json['variant_id'].toString()),
        variantName: json['variant_name']?.toString(),
        weight: json['weight']?.toString(),
        batch: json['batch']?.toString(),
        mappedWeight: json['mapped_weight']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (skuCodeId != null) 'sku_code_id': skuCodeId,
        if (skuCodeName != null) 'sku_code_name': skuCodeName,
        if (variantId != null) 'variant_id': variantId,
        if (variantName != null) 'variant_name': variantName,
        if (weight != null) 'weight': weight,
        if (batch != null) 'batch': batch,
        if (mappedWeight != null) 'mapped_weight': mappedWeight,
      };
}

class Data {
  num? id;
  String? palletName;
  String? palletLastLocation;
  List<PalletDetail>? palletDetails;

  Data({
    this.id,
    this.palletName,
    this.palletLastLocation,
    this.palletDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: num.tryParse(json['id'].toString()),
        palletName: json['pallet_name']?.toString(),
        palletLastLocation: json['pallet_last_location']?.toString(),
        palletDetails: (json['palletDetails'] as List<dynamic>?)
            ?.map((e) => PalletDetail.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (palletName != null) 'pallet_name': palletName,
        if (palletLastLocation != null)
          'pallet_last_location': palletLastLocation,
        if (palletDetails != null)
          'palletDetails': palletDetails?.map((e) => e.toJson()).toList(),
      };
}
