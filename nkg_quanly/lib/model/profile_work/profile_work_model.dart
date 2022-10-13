class ProfileWorkModel {
  List<ProfileWorkListItems>? items;
  ProfileWorkStatistic? statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  ProfileWorkModel(
      {this.items,
      this.statistic,
      this.pageIndex,
      this.pageSize,
      this.totalRecords,
      this.pageCount});

  ProfileWorkModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ProfileWorkListItems>[];
      json['items'].forEach((v) {
        items!.add(new ProfileWorkListItems.fromJson(v));
      });
    }
    statistic = json['statistic'] != null
        ? new ProfileWorkStatistic.fromJson(json['statistic'])
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

class ProfileWorkListItems {
  int? id;
  String? code;
  String? name;
  String? innitiatedDate;
  String? toDate;
  String? endDate;
  String? handler;
  String? status;

  ProfileWorkListItems(
      {this.id,
      this.code,
      this.name,
      this.innitiatedDate,
      this.toDate,
      this.endDate,
      this.handler,
      this.status});

  ProfileWorkListItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    innitiatedDate = json['innitiatedDate'];
    toDate = json['toDate'];
    endDate = json['endDate'];
    handler = json['handler'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['innitiatedDate'] = this.innitiatedDate;
    data['toDate'] = this.toDate;
    data['endDate'] = this.endDate;
    data['handler'] = this.handler;
    data['status'] = this.status;
    return data;
  }
}

class ProfileWorkStatistic {
  int? tong;
  int? taoMoi;
  int? daThuHoi;
  int? dangXuLy;
  int? daHoanThanh;
  int? quaHan;
  int? trongHanXuLy;

  ProfileWorkStatistic(
      {this.tong,
      this.taoMoi,
      this.daThuHoi,
      this.dangXuLy,
      this.daHoanThanh,
      this.quaHan,
      this.trongHanXuLy});

  ProfileWorkStatistic.fromJson(Map<String, dynamic> json) {
    tong = json['tong'];
    taoMoi = json['taoMoi'];
    daThuHoi = json['daThuHoi'];
    dangXuLy = json['dangXuLy'];
    daHoanThanh = json['daHoanThanh'];
    quaHan = json['quaHan'];
    trongHanXuLy = json['trongHanXuLy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tong'] = this.tong;
    data['taoMoi'] = this.taoMoi;
    data['daThuHoi'] = this.daThuHoi;
    data['dangXuLy'] = this.dangXuLy;
    data['daHoanThanh'] = this.daHoanThanh;
    data['quaHan'] = this.quaHan;
    data['trongHanXuLy'] = this.trongHanXuLy;
    return data;
  }
}
