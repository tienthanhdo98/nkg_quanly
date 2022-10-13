import 'mission_detail.dart';

class MissionModel {
  List<MissionItem>? items;
  MissionStatistic? statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  MissionModel(
      {this.items,
        this.statistic,
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
    statistic = json['statistic'] != null
        ? new MissionStatistic.fromJson(json['statistic'])
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



class MissionStatistic {
  int? tong;
  int? chuaXuLy;
  int? dangThucHien;
  int? daHuy;
  int? daTamDung;
  int? quaHan;
  int? trongHan;

  MissionStatistic(
      {this.tong,
        this.chuaXuLy,
        this.dangThucHien,
        this.daHuy,
        this.daTamDung,
        this.quaHan,
        this.trongHan});

  MissionStatistic.fromJson(Map<String, dynamic> json) {
    tong = json['tong'];
    chuaXuLy = json['chuaXuLy'];
    dangThucHien = json['dangThucHien'];
    daHuy = json['daHuy'];
    daTamDung = json['daTamDung'];
    quaHan = json['quaHan'];
    trongHan = json['trongHan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tong'] = this.tong;
    data['chuaXuLy'] = this.chuaXuLy;
    data['dangThucHien'] = this.dangThucHien;
    data['daHuy'] = this.daHuy;
    data['daTamDung'] = this.daTamDung;
    data['quaHan'] = this.quaHan;
    data['trongHan'] = this.trongHan;
    return data;
  }
}