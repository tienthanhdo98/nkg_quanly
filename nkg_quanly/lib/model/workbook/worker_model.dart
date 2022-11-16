class WorkerModel {
  String? userName;
  String? email;
  bool? status;
  String? createdBy;
  String? lastModifiedBy;
  bool? isDeleted;
  String? createdDate;
  String? lastModifiedDate;
  String? id;

  WorkerModel(
      {this.userName,
        this.email,
        this.status,
        this.createdBy,
        this.lastModifiedBy,
        this.isDeleted,
        this.createdDate,
        this.lastModifiedDate,
        this.id});

  WorkerModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    status = json['status'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    isDeleted = json['isDeleted'];
    createdDate = json['createdDate'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['isDeleted'] = this.isDeleted;
    data['createdDate'] = this.createdDate;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['id'] = this.id;
    return data;
  }
}