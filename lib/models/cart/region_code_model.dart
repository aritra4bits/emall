
import 'dart:convert';

RegionCodeModel regionCodeModelFromJson(String str) => RegionCodeModel.fromJson(json.decode(str));

String regionCodeModelToJson(RegionCodeModel data) => json.encode(data.toJson());

class RegionCodeModel {
  RegionCodeModel({
    this.id,
    this.twoLetterAbbreviation,
    this.threeLetterAbbreviation,
    this.fullNameLocale,
    this.fullNameEnglish,
    this.availableRegions,
  });

  final String? id;
  final String? twoLetterAbbreviation;
  final String? threeLetterAbbreviation;
  final String? fullNameLocale;
  final String? fullNameEnglish;
  final List<RegionInfo>? availableRegions;

  factory RegionCodeModel.fromJson(Map<String, dynamic> json) => RegionCodeModel(
    id: json["id"] == null ? null : json["id"],
    twoLetterAbbreviation: json["two_letter_abbreviation"] == null ? null : json["two_letter_abbreviation"],
    threeLetterAbbreviation: json["three_letter_abbreviation"] == null ? null : json["three_letter_abbreviation"],
    fullNameLocale: json["full_name_locale"] == null ? null : json["full_name_locale"],
    fullNameEnglish: json["full_name_english"] == null ? null : json["full_name_english"],
    availableRegions: json["available_regions"] == null ? null : List<RegionInfo>.from(json["available_regions"].map((x) => RegionInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "two_letter_abbreviation": twoLetterAbbreviation == null ? null : twoLetterAbbreviation,
    "three_letter_abbreviation": threeLetterAbbreviation == null ? null : threeLetterAbbreviation,
    "full_name_locale": fullNameLocale == null ? null : fullNameLocale,
    "full_name_english": fullNameEnglish == null ? null : fullNameEnglish,
    "available_regions": availableRegions == null ? null : List<dynamic>.from(availableRegions!.map((x) => x.toJson())),
  };
}

class RegionInfo {
  RegionInfo({
    this.id,
    this.code,
    this.name,
  });

  final String? id;
  final String? code;
  final String? name;

  factory RegionInfo.fromJson(Map<String, dynamic> json) => RegionInfo(
    id: json["id"] == null ? null : json["id"],
    code: json["code"] == null ? null : json["code"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "code": code == null ? null : code,
    "name": name == null ? null : name,
  };
}
