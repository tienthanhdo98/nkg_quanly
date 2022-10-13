class DepartmentModel {
  String? id;
  String? name;
  dynamic locationId;
  String? locationName;
  dynamic managerId;
  String? organizationId;
  String? organizationName;
  dynamic parentDepartmantId;
  String? description;
  bool? status;
  String? createdBy;
  dynamic lastModifiedBy;
  bool? isDeleted;
  String? code;
  String? parentDepartmentName;

  DepartmentModel(
      {this.id,
        this.name,
        this.locationId,
        this.locationName,
        this.managerId,
        this.organizationId,
        this.organizationName,
        this.parentDepartmantId,
        this.description,
        this.status,
        this.createdBy,
        this.lastModifiedBy,
        this.isDeleted,
        this.code,
        this.parentDepartmentName});

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationId = json['locationId'];
    locationName = json['locationName'];
    managerId = json['managerId'];
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
    parentDepartmantId = json['parentDepartmantId'];
    description = json['description'];
    status = json['status'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    isDeleted = json['isDeleted'];
    code = json['code'];
    parentDepartmentName = json['parentDepartmentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['locationId'] = this.locationId;
    data['locationName'] = this.locationName;
    data['managerId'] = this.managerId;
    data['organizationId'] = this.organizationId;
    data['organizationName'] = this.organizationName;
    data['parentDepartmantId'] = this.parentDepartmantId;
    data['description'] = this.description;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['isDeleted'] = this.isDeleted;
    data['code'] = this.code;
    data['parentDepartmentName'] = this.parentDepartmentName;
    return data;
  }
}