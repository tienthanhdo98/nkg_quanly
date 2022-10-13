class HelpdeskModel {
  List<HelpDeskListItems>? items;
  List<HelpDeskStatistic>? statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  HelpdeskModel(
      {this.items,
        this.statistic,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  HelpdeskModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <HelpDeskListItems>[];
      json['items'].forEach((v) {
        items!.add(new HelpDeskListItems.fromJson(v));
      });
    }
    if (json['statistic'] != null) {
      statistic = <HelpDeskStatistic>[];
      json['statistic'].forEach((v) {
        statistic!.add(HelpDeskStatistic.fromJson(v));
      });
    }
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
    if (this.statistic != null) {
      data['statistic'] = this.statistic!.map((v) => v.toJson()).toList();
    }
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalRecords'] = this.totalRecords;
    data['pageCount'] = this.pageCount;
    return data;
  }
}

class HelpDeskListItems {
  int? id;
  String? dateCreated;
  Null? priority;
 dynamic status;
  Null? requesterId;
  String? subject;
  Null? criticalLevel;
  Null? supportType;
  String? projectId;
  Null? workFlowId;
  Null? stepId;
  Null? organizationUnitId;
  Null? hasSend;
  String? link;
  String? browser;
  String? email;
  String? phoneNumber;
  dynamic statusName;
  Null? priorityName;
  Null? criticalLevelName;
  Null? supportTypeName;
  String? stepName;
  String? projectName;
  Null? serviceTypeName;
  String? requesterName;
  String? problemStatus;
  String? organizationUnitName;
  String? code;
  bool? isFinish;

  HelpDeskListItems(
      {this.id,
        this.dateCreated,
        this.priority,
        this.status,
        this.requesterId,
        this.subject,
        this.criticalLevel,
        this.supportType,
        this.projectId,
        this.workFlowId,
        this.stepId,
        this.organizationUnitId,
        this.hasSend,
        this.link,
        this.browser,
        this.email,
        this.phoneNumber,
        this.statusName,
        this.priorityName,
        this.criticalLevelName,
        this.supportTypeName,
        this.stepName,
        this.projectName,
        this.serviceTypeName,
        this.requesterName,
        this.problemStatus,
        this.organizationUnitName,
        this.code,
        this.isFinish});

  HelpDeskListItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['dateCreated'];
    priority = json['priority'];
    status = json['status'];
    requesterId = json['requesterId'];
    subject = json['subject'];
    criticalLevel = json['criticalLevel'];
    supportType = json['supportType'];
    projectId = json['projectId'];
    workFlowId = json['workFlowId'];
    stepId = json['stepId'];
    organizationUnitId = json['organizationUnitId'];
    hasSend = json['hasSend'];
    link = json['link'];
    browser = json['browser'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    statusName = json['statusName'];
    priorityName = json['priorityName'];
    criticalLevelName = json['criticalLevelName'];
    supportTypeName = json['supportTypeName'];
    stepName = json['stepName'];
    projectName = json['projectName'];
    serviceTypeName = json['serviceTypeName'];
    requesterName = json['requesterName'];
    problemStatus = json['problemStatus'];
    organizationUnitName = json['organizationUnitName'];
    code = json['code'];
    isFinish = json['isFinish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateCreated'] = this.dateCreated;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['requesterId'] = this.requesterId;
    data['subject'] = this.subject;
    data['criticalLevel'] = this.criticalLevel;
    data['supportType'] = this.supportType;
    data['projectId'] = this.projectId;
    data['workFlowId'] = this.workFlowId;
    data['stepId'] = this.stepId;
    data['organizationUnitId'] = this.organizationUnitId;
    data['hasSend'] = this.hasSend;
    data['link'] = this.link;
    data['browser'] = this.browser;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['statusName'] = this.statusName;
    data['priorityName'] = this.priorityName;
    data['criticalLevelName'] = this.criticalLevelName;
    data['supportTypeName'] = this.supportTypeName;
    data['stepName'] = this.stepName;
    data['projectName'] = this.projectName;
    data['serviceTypeName'] = this.serviceTypeName;
    data['requesterName'] = this.requesterName;
    data['problemStatus'] = this.problemStatus;
    data['organizationUnitName'] = this.organizationUnitName;
    data['code'] = this.code;
    data['isFinish'] = this.isFinish;
    return data;
  }
}

class HelpDeskStatistic {
  int? status;
  String? name;
  int? total;

  HelpDeskStatistic({this.status, this.name, this.total});

  HelpDeskStatistic.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['name'] = this.name;
    data['total'] = this.total;
    return data;
  }
}