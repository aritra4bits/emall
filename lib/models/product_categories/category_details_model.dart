import 'dart:convert';

CategoryDetailsModel categoryDetailsModelFromJson(String str) => CategoryDetailsModel.fromJson(json.decode(str));

String categoryDetailsModelToJson(CategoryDetailsModel data) => json.encode(data.toJson());

class CategoryDetailsModel {
  CategoryDetailsModel({
    this.id,
    this.parentId,
    this.name,
    this.isActive,
    this.position,
    this.level,
    this.children,
    this.createdAt,
    this.updatedAt,
    this.path,
    this.availableSortBy,
    this.message,
    this.parameters,
    this.includeInMenu,
    this.customAttributes,
  });

  final int? id;
  final int? parentId;
  final String? name;
  final bool? isActive;
  final int? position;
  final int? level;
  final String? children;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? path;
  final List<dynamic>? availableSortBy;
  final String? message;
  final Parameters? parameters;
  final bool? includeInMenu;
  final List<CustomAttribute>? customAttributes;

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) => CategoryDetailsModel(
    id: json["id"],
    parentId: json["parent_id"],
    name: json["name"],
    isActive: json["is_active"],
    position: json["position"],
    level: json["level"],
    children: json["children"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    path: json["path"],
    availableSortBy: json["available_sort_by"] == null ? null : List<dynamic>.from(json["available_sort_by"].map((x) => x)),
    message: json["message"],
    parameters: json["parameters"] == null ? null : Parameters.fromJson(json["parameters"]),
    includeInMenu: json["include_in_menu"],
    customAttributes: json["custom_attributes"] == null ? null : List<CustomAttribute>.from(json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "name": name,
    "is_active": isActive,
    "position": position,
    "level": level,
    "children": children,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "path": path,
    "available_sort_by": availableSortBy == null ? null : List<dynamic>.from(availableSortBy!.map((x) => x)),
    "message": message,
    "parameters": parameters == null ? null : parameters!.toJson(),
    "include_in_menu": includeInMenu,
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

class Parameters {
  Parameters({
    this.fieldName,
    this.fieldValue,
  });

  final String? fieldName;
  final int? fieldValue;

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
    fieldName: json["fieldName"],
    fieldValue: json["fieldValue"],
  );

  Map<String, dynamic> toJson() => {
    "fieldName": fieldName,
    "fieldValue": fieldValue,
  };
}
