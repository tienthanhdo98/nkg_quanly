class OrganModel {
  String? id;
  String? name;
  String? address;
  String? description;
  bool? status;
  String? createdBy;
  dynamic lastModifiedBy;
  bool? isDeleted;
  String? parentOrganizationId;
  String? parentOrganizationName;
  bool? hasChildrent;
  List<dynamic>? childrent;

  OrganModel(
      {this.id,
        this.name,
        this.address,
        this.description,
        this.status,
        this.createdBy,
        this.lastModifiedBy,
        this.isDeleted,
        this.parentOrganizationId,
        this.parentOrganizationName,
        this.hasChildrent,
        this.childrent});

  OrganModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    status = json['status'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    isDeleted = json['isDeleted'];
    parentOrganizationId = json['parentOrganizationId'];
    parentOrganizationName = json['parentOrganizationName'];
    hasChildrent = json['hasChildrent'];
    if (json['childrent'] != null) {
      childrent = <dynamic>[];
      json['childrent'].forEach((v) {
        childrent!.add(v.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['description'] = this.description;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['isDeleted'] = this.isDeleted;
    data['parentOrganizationId'] = this.parentOrganizationId;
    data['parentOrganizationName'] = this.parentOrganizationName;
    data['hasChildrent'] = this.hasChildrent;
    if (this.childrent != null) {
      data['childrent'] = this.childrent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}