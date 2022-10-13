class WorkbookModel {
  List<WorkBookListItems>? items;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  WorkbookModel(
      {this.items,
      this.pageIndex,
      this.pageSize,
      this.totalRecords,
      this.pageCount});

  WorkbookModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <WorkBookListItems>[];
      json['items'].forEach((v) {
        items!.add(new WorkBookListItems.fromJson(v));
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

class WorkBookListItems {
  String? id;
  String? workName;
  String? groupWorkName;
  String? groupWorkId;
  String? description;
  String? createdDate;
  String? worker;
  String? workBy;
  String? status;
  bool? important;

  WorkBookListItems(
      {this.id,
      this.workName,
      this.groupWorkName,
      this.groupWorkId,
      this.description,
      this.createdDate,
      this.worker,
      this.workBy,
      this.status,
      this.important});

  WorkBookListItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workName = json['workName'];
    groupWorkName = json['groupWorkName'];
    groupWorkId = json['groupWorkId'];
    description = json['description'];
    createdDate = json['createdDate'];
    worker = json['worker'];
    workBy = json['workBy'];
    status = json['status'];
    important = json['important'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workName'] = this.workName;
    data['groupWorkName'] = this.groupWorkName;
    data['groupWorkId'] = this.groupWorkId;
    data['description'] = this.description;
    data['createdDate'] = this.createdDate;
    data['worker'] = this.worker;
    data['workBy'] = this.workBy;
    data['status'] = this.status;
    data['important'] = this.important;
    return data;
  }
}
