class DocumentFilterModel {
  int? totalRecords;
  List<FilterItems>? items;

  DocumentFilterModel({this.totalRecords, this.items});

  DocumentFilterModel.fromJson(Map<String, dynamic> json) {
    totalRecords = json['totalRecords'];
    if (json['items'] != null) {
      items = <FilterItems>[];
      json['items'].forEach((v) {
        items!.add(FilterItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalRecords'] = this.totalRecords;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterItems {
  String? name;
  int? quantity;

  FilterItems({this.name, this.quantity});

  FilterItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    return data;
  }
}
