import 'package:nkg_quanly/model/booking_car/booking_car_model;.dart';

class MeetingRoomModel {
  List<MeetingRoomItems>? items;
  BookingStatistic? statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  MeetingRoomModel(
      {this.items,
      this.statistic,
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
    statistic = json['statistic'] != null
        ? new BookingStatistic.fromJson(json['statistic'])
        : null;
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
      data['statistic'] = this.statistic!.toJson();
    }
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalRecords'] = this.totalRecords;
    data['pageCount'] = this.pageCount;
    return data;
  }
}

class MeetingRoomItems {
  String? code;
  String? roomName;
  List<Mettings>? mettings;

  MeetingRoomItems({this.code, this.roomName, this.mettings});

  MeetingRoomItems.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    roomName = json['roomName'];
    if (json['mettings'] != null) {
      mettings = <Mettings>[];
      json['mettings'].forEach((v) {
        mettings!.add(new Mettings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['roomName'] = this.roomName;
    if (this.mettings != null) {
      data['mettings'] = this.mettings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mettings {
  int? id;
  String? code;
  String? roomName;
  String? name;
  String? registerUser;
  String? date;
  String? fromTime;
  String? toTime;

  Mettings(
      {this.id,
      this.code,
      this.roomName,
      this.name,
      this.registerUser,
      this.date,
      this.fromTime,
      this.toTime});

  Mettings.fromJson(Map<String, dynamic> json) {
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
