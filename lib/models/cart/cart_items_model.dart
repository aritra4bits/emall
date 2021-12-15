// To parse this JSON data, do
//
//     final cartItemsModel = cartItemsModelFromJson(jsonString);

import 'dart:convert';

CartItemsModel cartItemsModelFromJson(String str) => CartItemsModel.fromJson(json.decode(str));

String cartItemsModelToJson(CartItemsModel data) => json.encode(data.toJson());

class CartItemsModel {
  CartItemsModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.isVirtual,
    this.items,
    this.itemsCount,
    this.itemsQty,
    this.customer,
    this.billingAddress,
    this.origOrderId,
    this.currency,
    this.customerIsGuest,
    this.customerNoteNotify,
    this.customerTaxClassId,
    this.storeId,
    this.extensionAttributes,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isActive;
  final bool? isVirtual;
  final List<CartItem>? items;
  final int? itemsCount;
  final int? itemsQty;
  final Customer? customer;
  final Address? billingAddress;
  final int? origOrderId;
  final Currency? currency;
  final bool? customerIsGuest;
  final bool? customerNoteNotify;
  final int? customerTaxClassId;
  final int? storeId;
  final ExtensionAttributes? extensionAttributes;

  factory CartItemsModel.fromJson(Map<String, dynamic> json) => CartItemsModel(
    id: json["id"] == null ? null : json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isActive: json["is_active"] == null ? null : json["is_active"],
    isVirtual: json["is_virtual"] == null ? null : json["is_virtual"],
    items: json["items"] == null ? null : List<CartItem>.from(json["items"].map((x) => CartItem.fromJson(x))),
    itemsCount: json["items_count"] == null ? null : json["items_count"],
    itemsQty: json["items_qty"] == null ? null : json["items_qty"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    billingAddress: json["billing_address"] == null ? null : Address.fromJson(json["billing_address"]),
    origOrderId: json["orig_order_id"] == null ? null : json["orig_order_id"],
    currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
    customerIsGuest: json["customer_is_guest"] == null ? null : json["customer_is_guest"],
    customerNoteNotify: json["customer_note_notify"] == null ? null : json["customer_note_notify"],
    customerTaxClassId: json["customer_tax_class_id"] == null ? null : json["customer_tax_class_id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    extensionAttributes: json["extension_attributes"] == null ? null : ExtensionAttributes.fromJson(json["extension_attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "is_active": isActive == null ? null : isActive,
    "is_virtual": isVirtual == null ? null : isVirtual,
    "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
    "items_count": itemsCount == null ? null : itemsCount,
    "items_qty": itemsQty == null ? null : itemsQty,
    "customer": customer == null ? null : customer!.toJson(),
    "billing_address": billingAddress == null ? null : billingAddress!.toJson(),
    "orig_order_id": origOrderId == null ? null : origOrderId,
    "currency": currency == null ? null : currency!.toJson(),
    "customer_is_guest": customerIsGuest == null ? null : customerIsGuest,
    "customer_note_notify": customerNoteNotify == null ? null : customerNoteNotify,
    "customer_tax_class_id": customerTaxClassId == null ? null : customerTaxClassId,
    "store_id": storeId == null ? null : storeId,
    "extension_attributes": extensionAttributes == null ? null : extensionAttributes!.toJson(),
  };
}

class Address {
  Address({
    this.id,
    this.region,
    this.regionId,
    this.regionCode,
    this.countryId,
    this.street,
    this.telephone,
    this.postcode,
    this.city,
    this.firstname,
    this.lastname,
    this.email,
    this.sameAsBilling,
    this.saveInAddressBook,
  });

  final int? id;
  final dynamic region;
  final dynamic regionId;
  final dynamic regionCode;
  final dynamic countryId;
  final List<String>? street;
  final dynamic telephone;
  final dynamic postcode;
  final dynamic city;
  final dynamic firstname;
  final dynamic lastname;
  final dynamic email;
  final int? sameAsBilling;
  final int? saveInAddressBook;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"] == null ? null : json["id"],
    region: json["region"],
    regionId: json["region_id"],
    regionCode: json["region_code"],
    countryId: json["country_id"],
    street: json["street"] == null ? null : List<String>.from(json["street"].map((x) => x)),
    telephone: json["telephone"],
    postcode: json["postcode"],
    city: json["city"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    sameAsBilling: json["same_as_billing"] == null ? null : json["same_as_billing"],
    saveInAddressBook: json["save_in_address_book"] == null ? null : json["save_in_address_book"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "region": region,
    "region_id": regionId,
    "region_code": regionCode,
    "country_id": countryId,
    "street": street == null ? null : List<dynamic>.from(street!.map((x) => x)),
    "telephone": telephone,
    "postcode": postcode,
    "city": city,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "same_as_billing": sameAsBilling == null ? null : sameAsBilling,
    "save_in_address_book": saveInAddressBook == null ? null : saveInAddressBook,
  };
}

class Currency {
  Currency({
    this.globalCurrencyCode,
    this.baseCurrencyCode,
    this.storeCurrencyCode,
    this.quoteCurrencyCode,
    this.storeToBaseRate,
    this.storeToQuoteRate,
    this.baseToGlobalRate,
    this.baseToQuoteRate,
  });

  final String? globalCurrencyCode;
  final String? baseCurrencyCode;
  final String? storeCurrencyCode;
  final String? quoteCurrencyCode;
  final double? storeToBaseRate;
  final double? storeToQuoteRate;
  final double? baseToGlobalRate;
  final double? baseToQuoteRate;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    globalCurrencyCode: json["global_currency_code"] == null ? null : json["global_currency_code"],
    baseCurrencyCode: json["base_currency_code"] == null ? null : json["base_currency_code"],
    storeCurrencyCode: json["store_currency_code"] == null ? null : json["store_currency_code"],
    quoteCurrencyCode: json["quote_currency_code"] == null ? null : json["quote_currency_code"],
    storeToBaseRate: json["store_to_base_rate"] == null ? null : json["store_to_base_rate"].toDouble(),
    storeToQuoteRate: json["store_to_quote_rate"] == null ? null : json["store_to_quote_rate"].toDouble(),
    baseToGlobalRate: json["base_to_global_rate"] == null ? null : json["base_to_global_rate"].toDouble(),
    baseToQuoteRate: json["base_to_quote_rate"] == null ? null : json["base_to_quote_rate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "global_currency_code": globalCurrencyCode == null ? null : globalCurrencyCode,
    "base_currency_code": baseCurrencyCode == null ? null : baseCurrencyCode,
    "store_currency_code": storeCurrencyCode == null ? null : storeCurrencyCode,
    "quote_currency_code": quoteCurrencyCode == null ? null : quoteCurrencyCode,
    "store_to_base_rate": storeToBaseRate == null ? null : storeToBaseRate,
    "store_to_quote_rate": storeToQuoteRate == null ? null : storeToQuoteRate,
    "base_to_global_rate": baseToGlobalRate == null ? null : baseToGlobalRate,
    "base_to_quote_rate": baseToQuoteRate == null ? null : baseToQuoteRate,
  };
}

class Customer {
  Customer({
    this.email,
    this.firstname,
    this.lastname,
  });

  final String? email;
  final String? firstname;
  final String? lastname;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
  };
}

class ExtensionAttributes {
  ExtensionAttributes({
    this.shippingAssignments,
  });

  final List<ShippingAssignment>? shippingAssignments;

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) => ExtensionAttributes(
    shippingAssignments: json["shipping_assignments"] == null ? null : List<ShippingAssignment>.from(json["shipping_assignments"].map((x) => ShippingAssignment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "shipping_assignments": shippingAssignments == null ? null : List<dynamic>.from(shippingAssignments!.map((x) => x.toJson())),
  };
}

class ShippingAssignment {
  ShippingAssignment({
    this.shipping,
    this.items,
  });

  final Shipping? shipping;
  final List<CartItem>? items;

  factory ShippingAssignment.fromJson(Map<String, dynamic> json) => ShippingAssignment(
    shipping: json["shipping"] == null ? null : Shipping.fromJson(json["shipping"]),
    items: json["items"] == null ? null : List<CartItem>.from(json["items"].map((x) => CartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "shipping": shipping == null ? null : shipping!.toJson(),
    "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class CartItem {
  CartItem({
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
  final double? price;
  final String? productType;
  final String? quoteId;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    itemId: json["item_id"] == null ? null : json["item_id"],
    sku: json["sku"] == null ? null : json["sku"],
    qty: json["qty"] == null ? null : json["qty"],
    name: json["name"] == null ? null : json["name"],
    price: json["price"] == null ? null : json["price"].toDouble(),
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

class Shipping {
  Shipping({
    this.address,
    this.method,
  });

  final Address? address;
  final dynamic method;

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    method: json["method"],
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? null : address!.toJson(),
    "method": method,
  };
}
