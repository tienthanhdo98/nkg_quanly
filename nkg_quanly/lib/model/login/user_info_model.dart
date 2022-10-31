class UserInfoModel {
  String? sub;
  String? upn;
  String? name;
  String? groups;
  String? givenName;
  String? familyName;
  String? email;

  UserInfoModel(
      {this.sub,
        this.upn,
        this.name,
        this.groups,
        this.givenName,
        this.familyName,
        this.email});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    sub = json['sub'];
    upn = json['upn'];
    name = json['name'];
    groups = json['groups'];
    givenName = json['given_name'];
    familyName = json['family_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub'] = this.sub;
    data['upn'] = this.upn;
    data['name'] = this.name;
    data['groups'] = this.groups;
    data['given_name'] = this.givenName;
    data['family_name'] = this.familyName;
    data['email'] = this.email;
    return data;
  }
}