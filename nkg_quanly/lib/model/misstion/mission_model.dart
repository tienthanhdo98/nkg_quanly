import 'mission_detail.dart';

class MissionModel {
  List<MissionItem>? items;
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
      items = <MissionItem>[];
      json['items'].forEach((v) {
        items!.add(new MissionItem.fromJson(v));
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

// class MissionItem {
//   String? id;
//   String? code;
//   String? name;
//   String? organizationName;
//   String? organizationId;
//   String? assignmentDate;
//   String? deadline;
//   String? processingDate;
//   String? processingBy;
//   String? level;
//   String? status;
//
//   MissionItem(
//       {this.id,
//         this.code,
//         this.name,
//         this.organizationName,
//         this.organizationId,
//         this.assignmentDate,
//         this.deadline,
//         this.processingDate,
//         this.processingBy,
//         this.level,
//         this.status,});
//
//   MissionItem.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     code = json['code'];
//     name = json['name'];
//     organizationName = json['organizationName'];
//     organizationId = json['organizationId'];
//     assignmentDate = json['assignmentDate'];
//     deadline = json['deadline'];
//     processingDate = json['processingDate'];
//     processingBy = json['processingBy'];
//     level = json['level'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['code'] = this.code;
//     data['name'] = this.name;
//     data['organizationName'] = this.organizationName;
//     data['organizationId'] = this.organizationId;
//     data['assignmentDate'] = this.assignmentDate;
//     data['deadline'] = this.deadline;
//     data['processingDate'] = this.processingDate;
//     data['processingBy'] = this.processingBy;
//     data['level'] = this.level;
//     data['status'] = this.status;
//     return data;
//   }
// }
