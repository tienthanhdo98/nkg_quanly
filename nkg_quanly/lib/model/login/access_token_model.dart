class AccessTokenModel {
  String? accessToken;
  String? refreshToken;
  String? scope;
  String? idToken;
  String? tokenType;
  int? expiresIn;

  AccessTokenModel(
      {this.accessToken,
        this.refreshToken,
        this.scope,
        this.idToken,
        this.tokenType,
        this.expiresIn});

  AccessTokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    scope = json['scope'];
    idToken = json['id_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['scope'] = this.scope;
    data['id_token'] = this.idToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}