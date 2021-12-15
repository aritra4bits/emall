// To parse this JSON data, do
//
//     final updateCartItemModel = updateCartItemModelFromJson(jsonString);

import 'dart:convert';

UpdateCartItemModel updateCartItemModelFromJson(String str) => UpdateCartItemModel.fromJson(json.decode(str));

String updateCartItemModelToJson(UpdateCartItemModel data) => json.encode(data.toJson());

class UpdateCartItemModel {
  UpdateCartItemModel({
    this.itemId,
    this.sku,
    this.qty,
    this.name,
    this.price,
    this.productType,
    this.quoteId,
  });

  final int? itemId;
  final String? sku;
  final int? qty;
  final String? name;
  final int? price;
  final String? productType;
  final String? quoteId;

  factory UpdateCartItemModel.fromJson(Map<String, dynamic> json) => UpdateCartItemModel(
    itemId: json["item_id"] == null ? null : json["item_id"],
    sku: json["sku"] == null ? null : json["sku"],
    qty: json["qty"] == null ? null : json["qty"],
    name: json["name"] == null ? null : json["name"],
    price: json["price"] == null ? null : json["price"],
    productType: json["product_type"] == null ? null : json["product_type"],
    quoteId: json["quote_id"] == null ? null : json["quote_id"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId == null ? null : itemId,
    "sku": sku == null ? null : sku,
    "qty": qty == null ? null : qty,
    "name": name == null ? null : name,
    "price": price == null ? null : price,
    "product_type": productType == null ? null : productType,
    "quote_id": quoteId == null ? null : quoteId,
  };
}
