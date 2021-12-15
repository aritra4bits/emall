
class SearchModel {
  SearchModel({
    this.items,
    this.aggregations,
    this.searchCriteria,
    this.totalCount,
  });

  final List<Item>? items;
  final Aggregations? aggregations;
  final SearchCriteria? searchCriteria;
  final int? totalCount;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    aggregations: json["aggregations"] == null ? null : Aggregations.fromJson(json["aggregations"]),
    searchCriteria: json["search_criteria"] == null ? null : SearchCriteria.fromJson(json["search_criteria"]),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
    "aggregations": aggregations == null ? null : aggregations!.toJson(),
    "search_criteria": searchCriteria == null ? null : searchCriteria!.toJson(),
    "total_count": totalCount,
  };
}

class Aggregations {
  Aggregations({
    this.buckets,
    this.bucketNames,
  });

  final List<Bucket>? buckets;
  final List<String>? bucketNames;

  factory Aggregations.fromJson(Map<String, dynamic> json) => Aggregations(
    buckets: json["buckets"] == null ? null : List<Bucket>.from(json["buckets"].map((x) => Bucket.fromJson(x))),
    bucketNames: json["bucket_names"] == null ? null : List<String>.from(json["bucket_names"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "buckets": buckets == null ? null : List<dynamic>.from(buckets!.map((x) => x.toJson())),
    "bucket_names": bucketNames == null ? null : List<dynamic>.from(bucketNames!.map((x) => x)),
  };
}

class Bucket {
  Bucket({
    this.name,
    this.values,
  });

  final String? name;
  final List<Value>? values;

  factory Bucket.fromJson(Map<String, dynamic> json) => Bucket(
    name: json["name"],
    values: json["values"] == null ? null : List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "values": values == null ? null : List<dynamic>.from(values!.map((x) => x.toJson())),
  };
}

class Value {
  Value({
    this.value,
    this.metrics,
  });

  final String? value;
  final List<String>? metrics;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    value: json["value"],
    metrics: json["metrics"] == null ? null : List<String>.from(json["metrics"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "metrics": metrics == null ? null : List<dynamic>.from(metrics!.map((x) => x)),
  };
}

class Item {
  Item({
    this.id,
    this.customAttributes,
  });

  final int? id;
  final List<CustomAttribute>? customAttributes;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    customAttributes: json["custom_attributes"] == null ? null : List<CustomAttribute>.from(json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "custom_attributes": customAttributes == null ? null : List<dynamic>.from(customAttributes!.map((x) => x.toJson())),
  };
}

class CustomAttribute {
  CustomAttribute({
    this.attributeCode,
    this.value,
  });

  final String? attributeCode;
  final String? value;

  factory CustomAttribute.fromJson(Map<String, dynamic> json) => CustomAttribute(
    attributeCode: json["attribute_code"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "attribute_code": attributeCode,
    "value": value,
  };
}

class SearchCriteria {
  SearchCriteria({
    this.requestName,
    this.filterGroups,
    this.sortOrders,
  });

  final String? requestName;
  final List<FilterGroup>? filterGroups;
  final List<SortOrder>? sortOrders;

  factory SearchCriteria.fromJson(Map<String, dynamic> json) => SearchCriteria(
    requestName: json["request_name"],
    filterGroups: json["filter_groups"] == null ? null : List<FilterGroup>.from(json["filter_groups"].map((x) => FilterGroup.fromJson(x))),
    sortOrders: json["sort_orders"] == null ? null : List<SortOrder>.from(json["sort_orders"].map((x) => SortOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "request_name": requestName,
    "filter_groups": filterGroups == null ? null : List<dynamic>.from(filterGroups!.map((x) => x.toJson())),
    "sort_orders": sortOrders == null ? null : List<dynamic>.from(sortOrders!.map((x) => x.toJson())),
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

class SortOrder {
  SortOrder({
    this.field,
    this.direction,
  });

  final String? field;
  final String? direction;

  factory SortOrder.fromJson(Map<String, dynamic> json) => SortOrder(
    field: json["field"],
    direction: json["direction"],
  );

  Map<String, dynamic> toJson() => {
    "field": field,
    "direction": direction,
  };
}
