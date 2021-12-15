import 'dart:convert';

CategoryIdListModel categoryIdModelFromJson(String str) => CategoryIdListModel.fromJson(json.decode(str));

String categoryIdModelToJson(CategoryIdListModel data) => json.encode(data.toJson());

class CategoryIdListModel {
  CategoryIdListModel({
    this.id,
    this.parentId,
    this.name,
    this.isActive,
    this.position,
    this.level,
    this.productCount,
    this.childrenData,
  });

  final int? id;
  final int? parentId;
  final String? name;
  final bool? isActive;
  final int? position;
  final int? level;
  final int? productCount;
  final List<CategoryIdListModel>? childrenData;

  factory CategoryIdListModel.fromJson(Map<String, dynamic> json) => CategoryIdListModel(
    id: json["id"],
    parentId: json["parent_id"],
    name: json["name"],
    isActive: json["is_active"],
    position: json["position"],
    level: json["level"],
    productCount: json["product_count"],
    childrenData: json["children_data"] == null ? null : List<CategoryIdListModel>.from(json["children_data"].map((x) => CategoryIdListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "name": name,
    "is_active": isActive,
    "position": position,
    "level": level,
    "product_count": productCount,
    "children_data": childrenData == null ? null : List<dynamic>.from(childrenData!.map((x) => x.toJson())),
  };
}
