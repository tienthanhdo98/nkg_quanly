class BirthDayModel {
  List<BirthDayListItems>? items;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  BirthDayModel(
      {this.items,
      this.pageIndex,
      this.pageSize,
      this.totalRecords,
      this.pageCount});

  BirthDayModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <BirthDayListItems>[];
      json['items'].forEach((v) {
        items!.add(new BirthDayListItems.fromJson(v));
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

class BirthDayListItems {
  String? id;
  String? employeeName;
  String? dateOfBirth;
  String? position;
  String? organizationId;
  String? organizationName;

  BirthDayListItems(
      {this.id,
      this.employeeName,
      this.dateOfBirth,
      this.position,
      this.organizationId,
      this.organizationName});

  BirthDayListItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employeeName'];
    dateOfBirth = json['dateOfBirth'];
    position = json['position'];
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeName'] = this.employeeName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['position'] = this.position;
    data['organizationId'] = this.organizationId;
    data['organizationName'] = this.organizationName;
    return data;
  }
}
