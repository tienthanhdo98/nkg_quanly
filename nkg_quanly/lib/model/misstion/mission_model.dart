class MissionModel {
  List<MisstionItem>? items;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  MissionModel(
      {this.items,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  MissionModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <MisstionItem>[];
      json['items'].forEach((v) {
        items!.add(new MisstionItem.fromJson(v));
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
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalRecords'] = this.totalRecords;
    data['pageCount'] = this.pageCount;
    return data;
  }
}

class MisstionItem {
  String? id;
  String? code;
  String? name;
  String? organizationName;
  String? organizationId;
  String? assignmentDate;
  String? deadline;
  String? processingDate;
  String? processingBy;
  String? level;
  String? status;
  List<Timelines>? timelines;

  MisstionItem(
      {this.id,
        this.code,
        this.name,
        this.organizationName,
        this.organizationId,
        this.assignmentDate,
        this.deadline,
        this.processingDate,
        this.processingBy,
        this.level,
        this.status,
        this.timelines});

  MisstionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    organizationName = json['organizationName'];
    organizationId = json['organizationId'];
    assignmentDate = json['assignmentDate'];
    deadline = json['deadline'];
    processingDate = json['processingDate'];
    processingBy = json['processingBy'];
    level = json['level'];
    status = json['status'];
    if (json['timelines'] != null) {
      timelines = <Timelines>[];
      json['timelines'].forEach((v) {
        timelines!.add(new Timelines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['organizationName'] = this.organizationName;
    data['organizationId'] = this.organizationId;
    data['assignmentDate'] = this.assignmentDate;
    data['deadline'] = this.deadline;
    data['processingDate'] = this.processingDate;
    data['processingBy'] = this.processingBy;
    data['level'] = this.level;
    data['status'] = this.status;
    if (this.timelines != null) {
      data['timelines'] = this.timelines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timelines {
  String? moment;
  List<MissionTraces>? missionTraces;
  List<Comments>? comments;

  Timelines({this.moment, this.missionTraces, this.comments});

  Timelines.fromJson(Map<String, dynamic> json) {
    moment = json['moment'];
    if (json['missionTraces'] != null) {
      missionTraces = <MissionTraces>[];
      json['missionTraces'].forEach((v) {
        missionTraces!.add(new MissionTraces.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moment'] = this.moment;
    if (this.missionTraces != null) {
      data['missionTraces'] =
          this.missionTraces!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MissionTraces {
  String? time;
  String? employeeName;
  String? action;

  MissionTraces({this.time, this.employeeName, this.action});

  MissionTraces.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    employeeName = json['employeeName'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['employeeName'] = this.employeeName;
    data['action'] = this.action;
    return data;
  }
}

class Comments {
  String? time;
  String? employeeName;
  String? comment;
  List<Responses>? responses;

  Comments({this.time, this.employeeName, this.comment, this.responses});

  Comments.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    employeeName = json['employeeName'];
    comment = json['comment'];
    if (json['responses'] != null) {
      responses = <Responses>[];
      json['responses'].forEach((v) {
        responses!.add(new Responses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['employeeName'] = this.employeeName;
    data['comment'] = this.comment;
    if (this.responses != null) {
      data['responses'] = this.responses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Responses {
  String? time;
  String? employeeName;
  String? comment;
  Null? responses;

  Responses({this.time, this.employeeName, this.comment, this.responses});

  Responses.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    employeeName = json['employeeName'];
    comment = json['comment'];
    responses = json['responses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['employeeName'] = this.employeeName;
    data['comment'] = this.comment;
    data['responses'] = this.responses;
    return data;
  }
}