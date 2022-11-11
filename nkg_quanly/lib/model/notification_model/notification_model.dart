class NotificationModel {
  List<NotificationItems>? items;
  Null? statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  NotificationModel(
      {this.items,
        this.statistic,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <NotificationItems>[];
      json['items'].forEach((v) {
        items!.add(new NotificationItems.fromJson(v));
      });
    }
    statistic = json['statistic'];
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
    data['statistic'] = this.statistic;
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalRecords'] = this.totalRecords;
    data['pageCount'] = this.pageCount;
    return data;
  }
}

class NotificationItems {
  String? id;
  String? workbookId;
  String? workName;
  bool? status;
  bool? isDeleted;
  String? createdBy;
  String? lastModifiedBy;

  NotificationItems(
      {this.id,
        this.workbookId,
        this.workName,
        this.status,
        this.isDeleted,
        this.createdBy,
        this.lastModifiedBy});

  NotificationItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workbookId = json['workbookId'];
    workName = json['workName'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workbookId'] = this.workbookId;
    data['workName'] = this.workName;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    return data;
  }
}