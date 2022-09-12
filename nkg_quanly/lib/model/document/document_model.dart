class DocumentModel {
  List<Items>? items;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  DocumentModel(
      {this.items,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalRecords = json['totalRecords'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalRecords'] = this.totalRecords;
    data['pageCount'] = this.pageCount;
    return data;
  }
}

class Items {
  int? id;
  String? code;
  String? name;
  String? toDate;
  String? departmentPublic;
  String? endDate;
  String? status;
  bool? approved;
  String? dateDone;
  String? state;
  String? level;
  String? detail;

  Items(
      {this.id,
        this.code,
        this.name,
        this.toDate,
        this.departmentPublic,
        this.endDate,
        this.status,
        this.approved,
        this.dateDone,
        this.state,
        this.level,
        this.detail});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    toDate = json['toDate'];
    departmentPublic = json['departmentPublic'];
    endDate = json['endDate'];
    status = json['status'];
    approved = json['approved'];
    dateDone = json['dateDone'];
    state = json['state'];
    level = json['level'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['toDate'] = this.toDate;
    data['departmentPublic'] = this.departmentPublic;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    data['approved'] = this.approved;
    data['dateDone'] = this.dateDone;
    data['state'] = this.state;
    data['level'] = this.level;
    data['detail'] = this.detail;
    return data;
  }
}