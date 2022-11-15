class NotificationModelDB {
  String? id;
  String? workbookId;
  String? workName;
  bool? status;
  String? action;
  bool? isDeleted;
  String? createdDate;
  String? lastModifiedDate;
  String? createdBy;
  String? lastModifiedBy;
  bool? isClick;

  NotificationModelDB(
      {this.id,
        this.workbookId,
        this.workName,
        this.status,
        this.action,
        this.isDeleted,
        this.createdDate,
        this.lastModifiedDate,
        this.createdBy,
        this.lastModifiedBy,
        this.isClick});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workbookId': workbookId,
      'workName': workName,
      'status': status,
      'action': action,
      'isDeleted': isDeleted,
      'createdDate': createdDate,
      'lastModifiedDate': lastModifiedDate,
      'createdBy': createdBy,
      'lastModifiedBy': lastModifiedBy,
      'isClick': isClick,
    };
  }
}