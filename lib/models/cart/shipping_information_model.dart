// To parse this JSON data, do
//
//     final shippingInformationModel = shippingInformationModelFromJson(jsonString);

import 'dart:convert';

ShippingCartInformationModel shippingInformationModelFromJson(String str) => ShippingCartInformationModel.fromJson(json.decode(str));

String shippingInformationModelToJson(ShippingCartInformationModel data) => json.encode(data.toJson());

class ShippingCartInformationModel {
  ShippingCartInformationModel({
    this.paymentMethods,
    this.totals,
  });

  final List<PaymentMethod>? paymentMethods;
  final Totals? totals;

  factory ShippingCartInformationModel.fromJson(Map<String, dynamic> json) => ShippingCartInformationModel(
    paymentMethods: json["payment_methods"] == null ? null : List<PaymentMethod>.from(json["payment_methods"].map((x) => PaymentMethod.fromJson(x))),
    totals: json["totals"] == null ? null : Totals.fromJson(json["totals"]),
  );

  Map<String, dynamic> toJson() => {
    "payment_methods": paymentMethods == null ? null : List<dynamic>.from(paymentMethods!.map((x) => x.toJson())),
    "totals": totals == null ? null : totals!.toJson(),
  };
}

class PaymentMethod {
  PaymentMethod({
    this.code,
    this.title,
  });

  final String? code;
  final String? title;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    code: json["code"] == null ? null : json["code"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "title": title == null ? null : title,
  };
}

class Totals {
  Totals({
    this.grandTotal,
    this.baseGrandTotal,
    this.subtotal,
    this.baseSubtotal,
    this.discountAmount,
    this.baseDiscountAmount,
    this.subtotalWithDiscount,
    this.baseSubtotalWithDiscount,
    this.shippingAmount,
    this.baseShippingAmount,
    this.shippingDiscountAmount,
    this.baseShippingDiscountAmount,
    this.taxAmount,
    this.baseTaxAmount,
    this.weeeTaxAppliedAmount,
    this.shippingTaxAmount,
    this.baseShippingTaxAmount,
    this.subtotalInclTax,
    this.shippingInclTax,
    this.baseShippingInclTax,
    this.baseCurrencyCode,
    this.quoteCurrencyCode,
    this.itemsQty,
    this.items,
    this.totalSegments,
  });

  final int? grandTotal;
  final int? baseGrandTotal;
  final int? subtotal;
  final int? baseSubtotal;
  final int? discountAmount;
  final int? baseDiscountAmount;
  final int? subtotalWithDiscount;
  final int? baseSubtotalWithDiscount;
  final int? shippingAmount;
  final int? baseShippingAmount;
  final int? shippingDiscountAmount;
  final int? baseShippingDiscountAmount;
  final int? taxAmount;
  final int? baseTaxAmount;
  final dynamic weeeTaxAppliedAmount;
  final int? shippingTaxAmount;
  final int? baseShippingTaxAmount;
  final int? subtotalInclTax;
  final int? shippingInclTax;
  final int? baseShippingInclTax;
  final String? baseCurrencyCode;
  final String? quoteCurrencyCode;
  final int? itemsQty;
  final List<Item>? items;
  final List<TotalSegmentInfo>? totalSegments;

  factory Totals.fromJson(Map<String, dynamic> json) => Totals(
    grandTotal: json["grand_total"] == null ? null : json["grand_total"],
    baseGrandTotal: json["base_grand_total"] == null ? null : json["base_grand_total"],
    subtotal: json["subtotal"] == null ? null : json["subtotal"],
    baseSubtotal: json["base_subtotal"] == null ? null : json["base_subtotal"],
    discountAmount: json["discount_amount"] == null ? null : json["discount_amount"],
    baseDiscountAmount: json["base_discount_amount"] == null ? null : json["base_discount_amount"],
    subtotalWithDiscount: json["subtotal_with_discount"] == null ? null : json["subtotal_with_discount"],
    baseSubtotalWithDiscount: json["base_subtotal_with_discount"] == null ? null : json["base_subtotal_with_discount"],
    shippingAmount: json["shipping_amount"] == null ? null : json["shipping_amount"],
    baseShippingAmount: json["base_shipping_amount"] == null ? null : json["base_shipping_amount"],
    shippingDiscountAmount: json["shipping_discount_amount"] == null ? null : json["shipping_discount_amount"],
    baseShippingDiscountAmount: json["base_shipping_discount_amount"] == null ? null : json["base_shipping_discount_amount"],
    taxAmount: json["tax_amount"] == null ? null : json["tax_amount"],
    baseTaxAmount: json["base_tax_amount"] == null ? null : json["base_tax_amount"],
    weeeTaxAppliedAmount: json["weee_tax_applied_amount"],
    shippingTaxAmount: json["shipping_tax_amount"] == null ? null : json["shipping_tax_amount"],
    baseShippingTaxAmount: json["base_shipping_tax_amount"] == null ? null : json["base_shipping_tax_amount"],
    subtotalInclTax: json["subtotal_incl_tax"] == null ? null : json["subtotal_incl_tax"],
    shippingInclTax: json["shipping_incl_tax"] == null ? null : json["shipping_incl_tax"],
    baseShippingInclTax: json["base_shipping_incl_tax"] == null ? null : json["base_shipping_incl_tax"],
    baseCurrencyCode: json["base_currency_code"] == null ? null : json["base_currency_code"],
    quoteCurrencyCode: json["quote_currency_code"] == null ? null : json["quote_currency_code"],
    itemsQty: json["items_qty"] == null ? null : json["items_qty"],
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    totalSegments: json["total_segments"] == null ? null : List<TotalSegmentInfo>.from(json["total_segments"].map((x) => TotalSegmentInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "grand_total": grandTotal == null ? null : grandTotal,
    "base_grand_total": baseGrandTotal == null ? null : baseGrandTotal,
    "subtotal": subtotal == null ? null : subtotal,
    "base_subtotal": baseSubtotal == null ? null : baseSubtotal,
    "discount_amount": discountAmount == null ? null : discountAmount,
    "base_discount_amount": baseDiscountAmount == null ? null : baseDiscountAmount,
    "subtotal_with_discount": subtotalWithDiscount == null ? null : subtotalWithDiscount,
    "base_subtotal_with_discount": baseSubtotalWithDiscount == null ? null : baseSubtotalWithDiscount,
    "shipping_amount": shippingAmount == null ? null : shippingAmount,
    "base_shipping_amount": baseShippingAmount == null ? null : baseShippingAmount,
    "shipping_discount_amount": shippingDiscountAmount == null ? null : shippingDiscountAmount,
    "base_shipping_discount_amount": baseShippingDiscountAmount == null ? null : baseShippingDiscountAmount,
    "tax_amount": taxAmount == null ? null : taxAmount,
    "base_tax_amount": baseTaxAmount == null ? null : baseTaxAmount,
    "weee_tax_applied_amount": weeeTaxAppliedAmount,
    "shipping_tax_amount": shippingTaxAmount == null ? null : shippingTaxAmount,
    "base_shipping_tax_amount": baseShippingTaxAmount == null ? null : baseShippingTaxAmount,
    "subtotal_incl_tax": subtotalInclTax == null ? null : subtotalInclTax,
    "shipping_incl_tax": shippingInclTax == null ? null : shippingInclTax,
    "base_shipping_incl_tax": baseShippingInclTax == null ? null : baseShippingInclTax,
    "base_currency_code": baseCurrencyCode == null ? null : baseCurrencyCode,
    "quote_currency_code": quoteCurrencyCode == null ? null : quoteCurrencyCode,
    "items_qty": itemsQty == null ? null : itemsQty,
    "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
    "total_segments": totalSegments == null ? null : List<dynamic>.from(totalSegments!.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.itemId,
    this.price,
    this.basePrice,
    this.qty,
    this.rowTotal,
    this.baseRowTotal,
    this.rowTotalWithDiscount,
    this.taxAmount,
    this.baseTaxAmount,
    this.taxPercent,
    this.discountAmount,
    this.baseDiscountAmount,
    this.discountPercent,
    this.priceInclTax,
    this.basePriceInclTax,
    this.rowTotalInclTax,
    this.baseRowTotalInclTax,
    this.options,
    this.weeeTaxAppliedAmount,
    this.weeeTaxApplied,
    this.name,
  });

  final int? itemId;
  final double? price;
  final double? basePrice;
  final int? qty;
  final double? rowTotal;
  final double? baseRowTotal;
  final double? rowTotalWithDiscount;
  final double? taxAmount;
  final double? baseTaxAmount;
  final double? taxPercent;
  final double? discountAmount;
  final double? baseDiscountAmount;
  final double? discountPercent;
  final double? priceInclTax;
  final double? basePriceInclTax;
  final double? rowTotalInclTax;
  final double? baseRowTotalInclTax;
  final String? options;
  final dynamic weeeTaxAppliedAmount;
  final dynamic weeeTaxApplied;
  final String? name;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json["item_id"] == null ? null : json["item_id"],
    price: json["price"] == null ? null : json["price"].toDouble(),
    basePrice: json["base_price"] == null ? null : json["base_price"].toDouble(),
    qty: json["qty"] == null ? null : json["qty"],
    rowTotal: json["row_total"] == null ? null : json["row_total"].toDouble(),
    baseRowTotal: json["base_row_total"] == null ? null : json["base_row_total"].toDouble(),
    rowTotalWithDiscount: json["row_total_with_discount"] == null ? null : json["row_total_with_discount"].toDouble(),
    taxAmount: json["tax_amount"] == null ? null : json["tax_amount"].toDouble(),
    baseTaxAmount: json["base_tax_amount"] == null ? null : json["base_tax_amount"].toDouble(),
    taxPercent: json["tax_percent"] == null ? null : json["tax_percent"].toDouble(),
    discountAmount: json["discount_amount"] == null ? null : json["discount_amount"].toDouble(),
    baseDiscountAmount: json["base_discount_amount"] == null ? null : json["base_discount_amount"].toDouble(),
    discountPercent: json["discount_percent"] == null ? null : json["discount_percent"].toDouble(),
    priceInclTax: json["price_incl_tax"] == null ? null : json["price_incl_tax"].toDouble(),
    basePriceInclTax: json["base_price_incl_tax"] == null ? null : json["base_price_incl_tax"].toDouble(),
    rowTotalInclTax: json["row_total_incl_tax"] == null ? null : json["row_total_incl_tax"].toDouble(),
    baseRowTotalInclTax: json["base_row_total_incl_tax"] == null ? null : json["base_row_total_incl_tax"].toDouble(),
    options: json["options"] == null ? null : json["options"],
    weeeTaxAppliedAmount: json["weee_tax_applied_amount"],
    weeeTaxApplied: json["weee_tax_applied"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId == null ? null : itemId,
    "price": price == null ? null : price,
    "base_price": basePrice == null ? null : basePrice,
    "qty": qty == null ? null : qty,
    "row_total": rowTotal == null ? null : rowTotal,
    "base_row_total": baseRowTotal == null ? null : baseRowTotal,
    "row_total_with_discount": rowTotalWithDiscount == null ? null : rowTotalWithDiscount,
    "tax_amount": taxAmount == null ? null : taxAmount,
    "base_tax_amount": baseTaxAmount == null ? null : baseTaxAmount,
    "tax_percent": taxPercent == null ? null : taxPercent,
    "discount_amount": discountAmount == null ? null : discountAmount,
    "base_discount_amount": baseDiscountAmount == null ? null : baseDiscountAmount,
    "discount_percent": discountPercent == null ? null : discountPercent,
    "price_incl_tax": priceInclTax == null ? null : priceInclTax,
    "base_price_incl_tax": basePriceInclTax == null ? null : basePriceInclTax,
    "row_total_incl_tax": rowTotalInclTax == null ? null : rowTotalInclTax,
    "base_row_total_incl_tax": baseRowTotalInclTax == null ? null : baseRowTotalInclTax,
    "options": options == null ? null : options,
    "weee_tax_applied_amount": weeeTaxAppliedAmount,
    "weee_tax_applied": weeeTaxApplied,
    "name": name == null ? null : name,
  };
}

class TotalSegmentInfo {
  TotalSegmentInfo({
    this.code,
    this.title,
    this.value,
    this.extensionAttributes,
    this.area,
  });

  final String? code;
  final String? title;
  final double? value;
  final ExtensionAttributes? extensionAttributes;
  final String? area;

  factory TotalSegmentInfo.fromJson(Map<String, dynamic> json) => TotalSegmentInfo(
    code: json["code"] == null ? null : json["code"],
    title: json["title"] == null ? null : json["title"],
    value: json["value"] == null ? null : json["value"].toDouble(),
    extensionAttributes: json["extension_attributes"] == null ? null : ExtensionAttributes.fromJson(json["extension_attributes"]),
    area: json["area"] == null ? null : json["area"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "title": title == null ? null : title,
    "value": value == null ? null : value,
    "extension_attributes": extensionAttributes == null ? null : extensionAttributes!.toJson(),
    "area": area == null ? null : area,
  };
}

class ExtensionAttributes {
  ExtensionAttributes({
    this.taxGrandtotalDetails,
  });

  final List<dynamic>? taxGrandtotalDetails;

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) => ExtensionAttributes(
    taxGrandtotalDetails: json["tax_grandtotal_details"] == null ? null : List<dynamic>.from(json["tax_grandtotal_details"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "tax_grandtotal_details": taxGrandtotalDetails == null ? null : List<dynamic>.from(taxGrandtotalDetails!.map((x) => x)),
  };
}
