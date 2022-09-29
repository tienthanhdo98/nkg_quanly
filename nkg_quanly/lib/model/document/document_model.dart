class DocumentInModel {
  List<DocumentInListItems>? items;
  DocumentInStatistic? statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  DocumentInModel(
      {this.items,
        this.statistic,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  DocumentInModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <DocumentInListItems>[];
      json['items'].forEach((v) {
        items!.add(new DocumentInListItems.fromJson(v));
      });
    }
    statistic = json['statistic'] != null
        ? new DocumentInStatistic.fromJson(json['statistic'])
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

class DocumentInListItems {
  int? id;
  String? code;
  String? name;
  String? innitiatedDate;
  String? toDate;
  String? departmentPublic;
  String? endDate;
  String? status;
  bool? approved;
  String? dateDone;
  String? state;
  String? level;
  String? detail;

  DocumentInListItems(
      {this.id,
        this.code,
        this.name,
        this.innitiatedDate,
        this.toDate,
        this.departmentPublic,
        this.endDate,
        this.status,
        this.approved,
        this.dateDone,
        this.state,
        this.level,
        this.detail});

  DocumentInListItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    innitiatedDate = json['innitiatedDate'];
    toDate = json['toDate'];
    departmentPublic = json['departmentPublic'];
    endDate = json['endDate'];
    status = json['status'];
    approved = json['approved'];
    dateDone = json['dateDone'];
    state = json['state'];
    level = json['level'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['innitiatedDate'] = this.innitiatedDate;
    data['toDate'] = this.toDate;
    data['departmentPublic'] = this.departmentPublic;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    data['approved'] = this.approved;
    data['dateDone'] = this.dateDone;
    data['state'] = this.state;
    data['level'] = this.level;
    data['detail'] = this.detail;
    return data;
  }
}

class DocumentInStatistic {
  int? tong;
  int? chuaXuLy;
  int? dangXuLy;
  int? daXuLy;
  int? chuaButPhe;
  int? daButPhe;
  int? trongHan;
  int? quaHan;
  int? hoanThanhTruocHan;
  int? chuaHoanThanhTrongHan;
  int? hoanThanhTrongHan;
  int? chuaHoanThanhQuaHan;
  int? hoanThanhQuaHan;

  DocumentInStatistic(
      {this.tong,
        this.chuaXuLy,
        this.dangXuLy,
        this.daXuLy,
        this.chuaButPhe,
        this.daButPhe,
        this.trongHan,
        this.quaHan,
        this.hoanThanhTruocHan,
        this.chuaHoanThanhTrongHan,
        this.hoanThanhTrongHan,
        this.chuaHoanThanhQuaHan,
        this.hoanThanhQuaHan});

  DocumentInStatistic.fromJson(Map<String, dynamic> json) {
    tong = json['tong'];
    chuaXuLy = json['chuaXuLy'];
    dangXuLy = json['dangXuLy'];
    daXuLy = json['daXuLy'];
    chuaButPhe = json['chuaButPhe'];
    daButPhe = json['daButPhe'];
    trongHan = json['trongHan'];
    quaHan = json['quaHan'];
    hoanThanhTruocHan = json['hoanThanhTruocHan'];
    chuaHoanThanhTrongHan = json['chuaHoanThanhTrongHan'];
    hoanThanhTrongHan = json['hoanThanhTrongHan'];
    chuaHoanThanhQuaHan = json['chuaHoanThanhQuaHan'];
    hoanThanhQuaHan = json['hoanThanhQuaHan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tong'] = this.tong;
    data['chuaXuLy'] = this.chuaXuLy;
    data['dangXuLy'] = this.dangXuLy;
    data['daXuLy'] = this.daXuLy;
    data['chuaButPhe'] = this.chuaButPhe;
    data['daButPhe'] = this.daButPhe;
    data['trongHan'] = this.trongHan;
    data['quaHan'] = this.quaHan;
    data['hoanThanhTruocHan'] = this.hoanThanhTruocHan;
    data['chuaHoanThanhTrongHan'] = this.chuaHoanThanhTrongHan;
    data['hoanThanhTrongHan'] = this.hoanThanhTrongHan;
    data['chuaHoanThanhQuaHan'] = this.chuaHoanThanhQuaHan;
    data['hoanThanhQuaHan'] = this.hoanThanhQuaHan;
    return data;
  }
}