class GroupWorkBookModel {
  List<GroupWorkBookItems>? items;
  Null? statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  GroupWorkBookModel(
      {this.items,
        this.statistic,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  GroupWorkBookModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <GroupWorkBookItems>[];
      json['items'].forEach((v) {
        items!.add(new GroupWorkBookItems.fromJson(v));
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

class GroupWorkBookItems {
  String? id;
  String? groupWorkName;
  String? createdDate;
  String? description;

  GroupWorkBookItems({this.id, this.groupWorkName, this.createdDate, this.description});

  GroupWorkBookItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupWorkName = json['groupWorkName'];
    createdDate = json['createdDate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupWorkName'] = this.groupWorkName;
    data['createdDate'] = this.createdDate;
    data['description'] = this.description;
    return data;
  }
}