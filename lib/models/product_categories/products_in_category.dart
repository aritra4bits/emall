class ProductsInCategoryModel {
  ProductsInCategoryModel({
    this.items,
    this.searchCriteria,
    this.totalCount,
  });

  final List<CategoryProductItem>? items;
  final SearchCriteria? searchCriteria;
  final int? totalCount;

  factory ProductsInCategoryModel.fromJson(Map<String, dynamic> json) => ProductsInCategoryModel(
    items: json["items"] == null ? null : List<CategoryProductItem>.from(json["items"].map((x) => CategoryProductItem.fromJson(x))),
    searchCriteria: json["search_criteria"] == null ? null : SearchCriteria.fromJson(json["search_criteria"]),
    totalCount: json["total_count"] == null ? null : json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
    "search_criteria": searchCriteria == null ? null : searchCriteria!.toJson(),
    "total_count": totalCount == null ? null : totalCount,
  };
}

class CategoryProductItem {
  CategoryProductItem({
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
  final double? price;
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

  factory CategoryProductItem.fromJson(Map<String, dynamic> json) => CategoryProductItem(
    id: json["id"] == null ? null : json["id"],
    sku: json["sku"] == null ? null : json["sku"],
    name: json["name"] == null ? null : json["name"],
    attributeSetId: json["attribute_set_id"] == null ? null : json["attribute_set_id"],
    price: json["price"] == null ? null : json["price"].toDouble(),
    status: json["status"] == null ? null : json["status"],
    visibility: json["visibility"] == null ? null : json["visibility"],
    typeId: json["type_id"] == null ? null : json["type_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    weight: json["weight"] == null ? null : json["weight"].toDouble(),
    extensionAttributes: json["extension_attributes"] == null ? null : ExtensionAttributes.fromJson(json["extension_attributes"]),
    productLinks: json["product_links"] == null ? null : List<dynamic>.from(json["product_links"].map((x) => x)),
    options: json["options"] == null ? null : List<dynamic>.from(json["options"].map((x) => x)),
    mediaGalleryEntries: json["media_gallery_entries"] == null ? null : List<MediaGalleryEntry>.from(json["media_gallery_entries"].map((x) => MediaGalleryEntry.fromJson(x))),
    tierPrices: json["tier_prices"] == null ? null : List<dynamic>.from(json["tier_prices"].map((x) => x)),
    customAttributes: json["custom_attributes"] == null ? null : List<CustomAttribute>.from(json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "sku": sku == null ? null : sku,
    "name": name == null ? null : name,
    "attribute_set_id": attributeSetId == null ? null : attributeSetId,
    "price": price == null ? null : price,
    "status": status == null ? null : status,
    "visibility": visibility == null ? null : visibility,
    "type_id": typeId == null ? null : typeId,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "weight": weight == null ? null : weight,
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
    attributeCode: json["attribute_code"] == null ? null : json["attribute_code"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "attribute_code": attributeCode == null ? null : attributeCode,
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
    position: json["position"] == null ? null : json["position"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "position": position == null ? null : position,
    "category_id": categoryId == null ? null : categoryId,
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
    id: json["id"] == null ? null : json["id"],
    mediaType: json["media_type"] == null ? null : json["media_type"],
    label: json["label"],
    position: json["position"] == null ? null : json["position"],
    disabled: json["disabled"] == null ? null : json["disabled"],
    types: json["types"] == null ? null : List<String>.from(json["types"].map((x) => x)),
    file: json["file"] == null ? null : json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "media_type": mediaType == null ? null : mediaType,
    "label": label,
    "position": position == null ? null : position,
    "disabled": disabled == null ? null : disabled,
    "types": types == null ? null : List<dynamic>.from(types!.map((x) => x)),
    "file": file == null ? null : file,
  };
}

class SearchCriteria {
  SearchCriteria({
    this.filterGroups,
    this.sortOrders,
    this.pageSize,
    this.currentPage,
  });

  final List<FilterGroup>? filterGroups;
  final List<SortOrder>? sortOrders;
  final int? pageSize;
  final int? currentPage;

  factory SearchCriteria.fromJson(Map<String, dynamic> json) => SearchCriteria(
    filterGroups: json["filter_groups"] == null ? null : List<FilterGroup>.from(json["filter_groups"].map((x) => FilterGroup.fromJson(x))),
    sortOrders: json["sort_orders"] == null ? null : List<SortOrder>.from(json["sort_orders"].map((x) => SortOrder.fromJson(x))),
    pageSize: json["page_size"] == null ? null : json["page_size"],
    currentPage: json["current_page"] == null ? null : json["current_page"],
  );

  Map<String, dynamic> toJson() => {
    "filter_groups": filterGroups == null ? null : List<dynamic>.from(filterGroups!.map((x) => x.toJson())),
    "sort_orders": sortOrders == null ? null : List<dynamic>.from(sortOrders!.map((x) => x.toJson())),
    "page_size": pageSize == null ? null : pageSize,
    "current_page": currentPage == null ? null : currentPage,
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
    field: json["field"] == null ? null : json["field"],
    value: json["value"] == null ? null : json["value"],
    conditionType: json["condition_type"] == null ? null : json["condition_type"],
  );

  Map<String, dynamic> toJson() => {
    "field": field == null ? null : field,
    "value": value == null ? null : value,
    "condition_type": conditionType == null ? null : conditionType,
  };
}

class SortOrder {
  SortOrder({
    this.field,
    this.direction,
  });

  final String? field;
  final String? direction;

  factory SortOrder.fromJson(Map<String, dynamic> json) => SortOrder(
    field: json["field"] == null ? null : json["field"],
    direction: json["direction"] == null ? null : json["direction"],
  );

  Map<String, dynamic> toJson() => {
    "field": field == null ? null : field,
    "direction": direction == null ? null : direction,
  };
}
