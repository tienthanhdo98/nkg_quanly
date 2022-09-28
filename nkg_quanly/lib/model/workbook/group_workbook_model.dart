class GroupWorkbookModel {
  List<GroupWorkbookListItems>? items;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  GroupWorkbookModel(
      {this.items,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  GroupWorkbookModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <GroupWorkbookListItems>[];
      json['items'].forEach((v) {
        items!.add(new GroupWorkbookListItems.fromJson(v));
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

class GroupWorkbookListItems {
  String? id;
  String? groupWorkName;
  String? createdDate;
  String? description;

  GroupWorkbookListItems({this.id, this.groupWorkName, this.createdDate, this.description});

  GroupWorkbookListItems.fromJson(Map<String, dynamic> json) {
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