class UserInfoModelIOC {
  String? id;
  String? userName;
  String? email;
  dynamic fullName;
  dynamic sex;
  dynamic phoneNumber;
  bool? status;
  bool? isDeleted;
  List<Roles>? roles;
  String? roleId;
  dynamic imagePath;
  dynamic image;
  bool? isAdmin;

  UserInfoModelIOC(
      {this.id,
        this.userName,
        this.email,
        this.fullName,
        this.sex,
        this.phoneNumber,
        this.status,
        this.isDeleted,
        this.roles,
        this.roleId,
        this.imagePath,
        this.image,
        this.isAdmin});

  UserInfoModelIOC.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    fullName = json['fullName'];
    sex = json['sex'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
    roleId = json['roleId'];
    imagePath = json['imagePath'];
    image = json['image'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    data['fullName'] = fullName;
    data['sex'] = sex;
    data['phoneNumber'] = phoneNumber;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['roleId'] = roleId;
    data['imagePath'] = imagePath;
    data['image'] = image;
    data['isAdmin'] = isAdmin;
    return data;
  }
}

class Roles {
  String? id;
  String? name;
  dynamic code;
  String? description;
  bool? status;
  String? createdBy;
  String? lastModifiedBy;
  bool? isDeleted;

  Roles(
      {this.id,
        this.name,
        this.code,
        this.description,
        this.status,
        this.createdBy,
        this.lastModifiedBy,
        this.isDeleted});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    status = json['status'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['description'] = description;
    data['status'] = status;
    data['createdBy'] = createdBy;
    data['lastModifiedBy'] = lastModifiedBy;
    data['isDeleted'] = isDeleted;
    return data;
  }
}