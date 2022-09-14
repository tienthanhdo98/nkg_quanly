class ProfileModel {
  List<ProfileItems>? items;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  ProfileModel(
      {this.items,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ProfileItems>[];
      json['items'].forEach((v) {
        items!.add(new ProfileItems.fromJson(v));
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

class ProfileItems {
  int? id;
  String? code;
  String? name;
  String? deadline;
  String? dateProcess;
  String? handler;
  String? level;
  String? state;
  String? status;

  ProfileItems(
      {this.id,
        this.code,
        this.name,
        this.deadline,
        this.dateProcess,
        this.handler,
        this.level,
        this.state,
        this.status});

  ProfileItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    deadline = json['deadline'];
    dateProcess = json['dateProcess'];
    handler = json['handler'];
    level = json['level'];
    state = json['state'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['deadline'] = this.deadline;
    data['dateProcess'] = this.dateProcess;
    data['handler'] = this.handler;
    data['level'] = this.level;
    data['state'] = this.state;
    data['status'] = this.status;
    return data;
  }
}