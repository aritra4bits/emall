// To parse this JSON data, do
//
//     final addCouponModel = addCouponModelFromJson(jsonString);

import 'dart:convert';

AddCouponModel addCouponModelFromJson(String str) => AddCouponModel.fromJson(json.decode(str));

String addCouponModelToJson(AddCouponModel data) => json.encode(data.toJson());

class AddCouponModel {
  AddCouponModel({
    this.message,
  });

  final String? message;

  factory AddCouponModel.fromJson(Map<String, dynamic> json) => AddCouponModel(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
