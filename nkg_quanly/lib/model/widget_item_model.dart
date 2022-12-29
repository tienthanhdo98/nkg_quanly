class WidgetItemModel {
  String? id;
  String? code;
  String? name;
  String? description;
  bool? status;
  String? image;
  int? orderNumber;

  WidgetItemModel(
      {this.id,
        this.code,
        this.name,
        this.description,
        this.status,
        this.image,
        this.orderNumber});

  WidgetItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    image = json['image'];
    orderNumber = json['orderNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['image'] = this.image;
    data['orderNumber'] = this.orderNumber;
    return data;
  }
}