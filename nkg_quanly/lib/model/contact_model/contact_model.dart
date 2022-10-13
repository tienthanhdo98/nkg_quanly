class ContactModel {
  List<ContactListItems>? items;
  Null? statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  ContactModel(
      {this.items,
        this.statistic,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  ContactModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ContactListItems>[];
      json['items'].forEach((v) {
        items!.add(new ContactListItems.fromJson(v));
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

class ContactListItems {
  String? id;
  String? employeeName;
  String? organizationId;
  String? phoneNumber;
  String? departmentId;
  String? email;
  String? address;
  String? position;

  ContactListItems(
      {this.id,
        this.employeeName,
        this.organizationId,
        this.phoneNumber,
        this.departmentId,
        this.email,
        this.address,
        this.position});

  ContactListItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employeeName'];
    organizationId = json['organizationId'];
    phoneNumber = json['phoneNumber'];
    departmentId = json['departmentId'];
    email = json['email'];
    address = json['address'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeName'] = this.employeeName;
    data['organizationId'] = this.organizationId;
    data['phoneNumber'] = this.phoneNumber;
    data['departmentId'] = this.departmentId;
    data['email'] = this.email;
    data['address'] = this.address;
    data['position'] = this.position;
    return data;
  }
}