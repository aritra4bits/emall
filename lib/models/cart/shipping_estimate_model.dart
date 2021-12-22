// To parse this JSON data, do
//
//     final shippingEstimateModel = shippingEstimateModelFromJson(jsonString);

import 'dart:convert';

List<ShippingEstimateModel> shippingEstimateModelFromJson(String str) => List<ShippingEstimateModel>.from(json.decode(str).map((x) => ShippingEstimateModel.fromJson(x)));

String shippingEstimateModelToJson(List<ShippingEstimateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShippingEstimateModel {
  ShippingEstimateModel({
    this.carrierCode,
    this.methodCode,
    this.carrierTitle,
    this.methodTitle,
    this.amount,
    this.baseAmount,
    this.available,
    this.errorMessage,
    this.priceExclTax,
    this.priceInclTax,
  });

  final String? carrierCode;
  final String? methodCode;
  final String? carrierTitle;
  final String? methodTitle;
  final int? amount;
  final int? baseAmount;
  final bool? available;
  final String? errorMessage;
  final int? priceExclTax;
  final int? priceInclTax;

  factory ShippingEstimateModel.fromJson(Map<String, dynamic> json) => ShippingEstimateModel(
    carrierCode: json["carrier_code"] == null ? null : json["carrier_code"],
    methodCode: json["method_code"] == null ? null : json["method_code"],
    carrierTitle: json["carrier_title"] == null ? null : json["carrier_title"],
    methodTitle: json["method_title"] == null ? null : json["method_title"],
    amount: json["amount"] == null ? null : json["amount"],
    baseAmount: json["base_amount"] == null ? null : json["base_amount"],
    available: json["available"] == null ? null : json["available"],
    errorMessage: json["error_message"] == null ? null : json["error_message"],
    priceExclTax: json["price_excl_tax"] == null ? null : json["price_excl_tax"],
    priceInclTax: json["price_incl_tax"] == null ? null : json["price_incl_tax"],
  );

  Map<String, dynamic> toJson() => {
    "carrier_code": carrierCode == null ? null : carrierCode,
    "method_code": methodCode == null ? null : methodCode,
    "carrier_title": carrierTitle == null ? null : carrierTitle,
    "method_title": methodTitle == null ? null : methodTitle,
    "amount": amount == null ? null : amount,
    "base_amount": baseAmount == null ? null : baseAmount,
    "available": available == null ? null : available,
    "error_message": errorMessage == null ? null : errorMessage,
    "price_excl_tax": priceExclTax == null ? null : priceExclTax,
    "price_incl_tax": priceInclTax == null ? null : priceInclTax,
  };
}
