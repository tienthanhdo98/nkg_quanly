class MeetingRoomModel {
  List<MeetingRoomItems>? items;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  MeetingRoomModel(
      {this.items,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  MeetingRoomModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <MeetingRoomItems>[];
      json['items'].forEach((v) {
        items!.add(new MeetingRoomItems.fromJson(v));
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

class MeetingRoomItems {
  int? id;
  String? code;
  String? roomName;
  String? name;
  String? registerUser;
  String? date;
  String? fromTime;
  String? toTime;

  MeetingRoomItems(
      {this.id,
        this.code,
        this.roomName,
        this.name,
        this.registerUser,
        this.date,
        this.fromTime,
        this.toTime});

  MeetingRoomItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    roomName = json['roomName'];
    name = json['name'];
    registerUser = json['registerUser'];
    date = json['date'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['roomName'] = this.roomName;
    data['name'] = this.name;
    data['registerUser'] = this.registerUser;
    data['date'] = this.date;
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    return data;
  }
}