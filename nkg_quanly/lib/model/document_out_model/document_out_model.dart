class DocumentOutModel {
  List<DocumentOutItems>? items;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  DocumentOutModel(
      {this.items,
      this.pageIndex,
      this.pageSize,
      this.totalRecords,
      this.pageCount});

  DocumentOutModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <DocumentOutItems>[];
      json['items'].forEach((v) {
        items!.add(new DocumentOutItems.fromJson(v));
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

class DocumentOutItems {
  int? id;
  String? code;
  String? name;
  String? toDate;
  String? departmentPublic;
  String? endDate;
  String? status;
  bool? released;
  String? dateDone;
  String? state;
  String? level;
  String? detail;

  DocumentOutItems(
      {this.id,
      this.code,
      this.name,
      this.toDate,
      this.departmentPublic,
      this.endDate,
      this.status,
      this.released,
      this.dateDone,
      this.state,
      this.level,
      this.detail});

  DocumentOutItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    toDate = json['toDate'];
    departmentPublic = json['departmentPublic'];
    endDate = json['endDate'];
    status = json['status'];
    released = json['released'];
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
    data['released'] = this.released;
    data['dateDone'] = this.dateDone;
    data['state'] = this.state;
    data['level'] = this.level;
    data['detail'] = this.detail;
    return data;
  }
}
