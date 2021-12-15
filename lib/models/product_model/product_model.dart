
class ProductModel {
  ProductModel({
    this.items,
    this.searchCriteria,
    this.totalCount,
  });

  final List<Item>? items;
  final SearchCriteria? searchCriteria;
  final int? totalCount;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    searchCriteria: json["search_criteria"] == null ? null : SearchCriteria.fromJson(json["search_criteria"]),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
    "search_criteria": searchCriteria == null ? null : searchCriteria!.toJson(),
    "total_count": totalCount,
  };
}

class Item {
  Item({
    this.id,
    this.sku,
    this.name,
    this.attributeSetId,
    this.price,
    this.status,
    this.visibility,
    this.typeId,
    this.createdAt,
    this.updatedAt,
    this.weight,
    this.extensionAttributes,
    this.productLinks,
    this.options,
    this.mediaGalleryEntries,
    this.tierPrices,
    this.customAttributes,
  });

  final int? id;
  final String? sku;
  final String? name;
  final int? attributeSetId;
  final int? price;
  final int? status;
  final int? visibility;
  final String? typeId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? weight;
  final ExtensionAttributes? extensionAttributes;
  final List<dynamic>? productLinks;
  final List<dynamic>? options;
  final List<MediaGalleryEntry>? mediaGalleryEntries;
  final List<dynamic>? tierPrices;
  final List<CustomAttribute>? customAttributes;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    sku: json["sku"],
    name: json["name"],
    attributeSetId: json["attribute_set_id"],
    price: json["price"],
    status: json["status"],
    visibility: json["visibility"],
    typeId: json["type_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    weight: json["weight"]?.toDouble(),
    extensionAttributes: json["extension_attributes"] == null ? null : ExtensionAttributes.fromJson(json["extension_attributes"]),
    productLinks: json["product_links"] == null ? null : List<dynamic>.from(json["product_links"].map((x) => x)),
    options: json["options"] == null ? null : List<dynamic>.from(json["options"].map((x) => x)),
    mediaGalleryEntries: json["media_gallery_entries"] == null ? null : List<MediaGalleryEntry>.from(json["media_gallery_entries"].map((x) => MediaGalleryEntry.fromJson(x))),
    tierPrices: json["tier_prices"] == null ? null : List<dynamic>.from(json["tier_prices"].map((x) => x)),
    customAttributes: json["custom_attributes"] == null ? null : List<CustomAttribute>.from(json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sku": sku,
    "name": name,
    "attribute_set_id": attributeSetId,
    "price": price,
    "status": status,
    "visibility": visibility,
    "type_id": typeId,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "weight": weight,
    "extension_attributes": extensionAttributes == null ? null : extensionAttributes!.toJson(),
    "product_links": productLinks == null ? null : List<dynamic>.from(productLinks!.map((x) => x)),
    "options": options == null ? null : List<dynamic>.from(options!.map((x) => x)),
    "media_gallery_entries": mediaGalleryEntries == null ? null : List<dynamic>.from(mediaGalleryEntries!.map((x) => x.toJson())),
    "tier_prices": tierPrices == null ? null : List<dynamic>.from(tierPrices!.map((x) => x)),
    "custom_attributes": customAttributes == null ? null : List<dynamic>.from(customAttributes!.map((x) => x.toJson())),
  };
}

class CustomAttribute {
  CustomAttribute({
    this.attributeCode,
    this.value,
  });

  final String? attributeCode;
  final dynamic value;

  factory CustomAttribute.fromJson(Map<String, dynamic> json) => CustomAttribute(
    attributeCode: json["attribute_code"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "attribute_code": attributeCode,
    "value": value,
  };
}

class ExtensionAttributes {
  ExtensionAttributes({
    this.websiteIds,
    this.categoryLinks,
  });

  final List<int>? websiteIds;
  final List<CategoryLink>? categoryLinks;

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) => ExtensionAttributes(
    websiteIds: json["website_ids"] == null ? null : List<int>.from(json["website_ids"].map((x) => x)),
    categoryLinks: json["category_links"] == null ? null : List<CategoryLink>.from(json["category_links"].map((x) => CategoryLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "website_ids": websiteIds == null ? null : List<dynamic>.from(websiteIds!.map((x) => x)),
    "category_links": categoryLinks == null ? null : List<dynamic>.from(categoryLinks!.map((x) => x.toJson())),
  };
}

class CategoryLink {
  CategoryLink({
    this.position,
    this.categoryId,
  });

  final int? position;
  final String? categoryId;

  factory CategoryLink.fromJson(Map<String, dynamic> json) => CategoryLink(
    position: json["position"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "category_id": categoryId,
  };
}

class MediaGalleryEntry {
  MediaGalleryEntry({
    this.id,
    this.mediaType,
    this.label,
    this.position,
    this.disabled,
    this.types,
    this.file,
  });

  final int? id;
  final String? mediaType;
  final dynamic label;
  final int? position;
  final bool? disabled;
  final List<String>? types;
  final String? file;

  factory MediaGalleryEntry.fromJson(Map<String, dynamic> json) => MediaGalleryEntry(
    id: json["id"],
    mediaType: json["media_type"],
    label: json["label"],
    position: json["position"],
    disabled: json["disabled"],
    types: json["types"] == null ? null : List<String>.from(json["types"].map((x) => x)),
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "media_type": mediaType,
    "label": label,
    "position": position,
    "disabled": disabled,
    "types": types == null ? null : List<dynamic>.from(types!.map((x) => x)),
    "file": file,
  };
}

class SearchCriteria {
  SearchCriteria({
    this.filterGroups,
  });

  final List<FilterGroup>? filterGroups;

  factory SearchCriteria.fromJson(Map<String, dynamic> json) => SearchCriteria(
    filterGroups: json["filter_groups"] == null ? null : List<FilterGroup>.from(json["filter_groups"].map((x) => FilterGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "filter_groups": filterGroups == null ? null : List<dynamic>.from(filterGroups!.map((x) => x.toJson())),
  };
}

class FilterGroup {
  FilterGroup({
    this.filters,
  });

  final List<Filter>? filters;

  factory FilterGroup.fromJson(Map<String, dynamic> json) => FilterGroup(
    filters: json["filters"] == null ? null : List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "filters": filters == null ? null : List<dynamic>.from(filters!.map((x) => x.toJson())),
  };
}

class Filter {
  Filter({
    this.field,
    this.value,
    this.conditionType,
  });

  final String? field;
  final String? value;
  final String? conditionType;

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    field: json["field"],
    value: json["value"],
    conditionType: json["condition_type"],
  );

  Map<String, dynamic> toJson() => {
    "field": field,
    "value": value,
    "condition_type": conditionType,
  };
}
