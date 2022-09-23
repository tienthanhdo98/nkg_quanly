class ReportModel {
  List<ReportListItems>? items;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  ReportModel(
      {this.items,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  ReportModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ReportListItems>[];
      json['items'].forEach((v) {
        items!.add(new ReportListItems.fromJson(v));
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

class ReportListItems {
  int? id;
  String? code;
  String? name;
  String? toDate;
  String? endDate;
  String? departmentHandle;
  String? status;
  String? detail;
  String? level;
  String? state;

  ReportListItems(
      {this.id,
        this.code,
        this.name,
        this.toDate,
        this.endDate,
        this.departmentHandle,
        this.status,
        this.detail,
        this.level,
        this.state});

  ReportListItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    toDate = json['toDate'];
    endDate = json['endDate'];
    departmentHandle = json['departmentHandle'];
    status = json['status'];
    detail = json['detail'];
    level = json['level'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['toDate'] = this.toDate;
    data['endDate'] = this.endDate;
    data['departmentHandle'] = this.departmentHandle;
    data['status'] = this.status;
    data['detail'] = this.detail;
    data['level'] = this.level;
    data['state'] = this.state;
    return data;
  }
}