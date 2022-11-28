class WidgetItemModel {
  String? id;
  String? code;
  String? name;
  String? description;
  bool? status;
  String? image;

  WidgetItemModel(
      {this.id,
        this.code,
        this.name,
        this.description,
        this.status,
        this.image});

  WidgetItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['description'] = description;
    data['status'] = status;
    data['image'] = image;
    return data;
  }
}