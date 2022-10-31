class SignUpModel {
  String? accessToken;
  String? refreshToken;
  int? expires;
  String? id;

  SignUpModel({this.accessToken, this.refreshToken, this.expires, this.id});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    expires = json['expires'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['expires'] = this.expires;
    data['id'] = this.id;
    return data;
  }
}