class InfoLoginConfig {
  String? id;
  String? baseUrl;
  String? clientID;
  String? clientSecret;
  String? responseType;
  String? scope;
  String? redirectUri;
  bool? status;
  String? createdDate;
  String? lastModifiedDate;
  String? createdBy;
  Null? lastModifiedBy;
  bool? isDeleted;
  String? appId;

  InfoLoginConfig(
      {this.id,
        this.baseUrl,
        this.clientID,
        this.clientSecret,
        this.responseType,
        this.scope,
        this.redirectUri,
        this.status,
        this.createdDate,
        this.lastModifiedDate,
        this.createdBy,
        this.lastModifiedBy,
        this.isDeleted,
        this.appId});

  InfoLoginConfig.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baseUrl = json['baseUrl'];
    clientID = json['clientID'];
    clientSecret = json['clientSecret'];
    responseType = json['responseType'];
    scope = json['scope'];
    redirectUri = json['redirectUri'];
    status = json['status'];
    createdDate = json['createdDate'];
    lastModifiedDate = json['lastModifiedDate'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    isDeleted = json['isDeleted'];
    appId = json['appId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['baseUrl'] = this.baseUrl;
    data['clientID'] = this.clientID;
    data['clientSecret'] = this.clientSecret;
    data['responseType'] = this.responseType;
    data['scope'] = this.scope;
    data['redirectUri'] = this.redirectUri;
    data['status'] = this.status;
    data['createdDate'] = this.createdDate;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['isDeleted'] = this.isDeleted;
    data['appId'] = this.appId;
    return data;
  }
}