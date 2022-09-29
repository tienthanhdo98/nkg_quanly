class ProfileModel {
  List<ProfileItems>? items;
  ProfileStatisticModel? statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  ProfileModel(
      {this.items,
        this.statistic,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ProfileItems>[];
      json['items'].forEach((v) {
        items!.add(new ProfileItems.fromJson(v));
      });
    }
    statistic = json['statistic'] != null
        ? new ProfileStatisticModel.fromJson(json['statistic'])
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

class ProfileItems {
  int? id;
  String? code;
  String? name;
  String? innitiatedDate;
  String? deadline;
  String? dateProcess;
  String? handler;
  String? level;
  String? state;
  String? status;
  String? unitEditor;
  String? submissionProblem;
  String? typeSubmission;
  String? detail;

  ProfileItems(
      {this.id,
        this.code,
        this.name,
        this.innitiatedDate,
        this.deadline,
        this.dateProcess,
        this.handler,
        this.level,
        this.state,
        this.status,
        this.unitEditor,
        this.submissionProblem,
        this.typeSubmission,
        this.detail});

  ProfileItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    innitiatedDate = json['innitiatedDate'];
    deadline = json['deadline'];
    dateProcess = json['dateProcess'];
    handler = json['handler'];
    level = json['level'];
    state = json['state'];
    status = json['status'];
    unitEditor = json['unitEditor'];
    submissionProblem = json['submissionProblem'];
    typeSubmission = json['typeSubmission'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['innitiatedDate'] = this.innitiatedDate;
    data['deadline'] = this.deadline;
    data['dateProcess'] = this.dateProcess;
    data['handler'] = this.handler;
    data['level'] = this.level;
    data['state'] = this.state;
    data['status'] = this.status;
    data['unitEditor'] = this.unitEditor;
    data['submissionProblem'] = this.submissionProblem;
    data['typeSubmission'] = this.typeSubmission;
    data['detail'] = this.detail;
    return data;
  }
}

class ProfileStatisticModel {
  int? hoSoTrinh;
  int? taoMoi;
  int? choDuyet;
  int? yKienDonVi;
  int? daThuHoi;
  int? daDuyet;
  int? choTiepNhan;
  int? daTiepNhan;
  int? hoSoTrinhChoPhatHanh;

  ProfileStatisticModel(
      {this.hoSoTrinh,
        this.taoMoi,
        this.choDuyet,
        this.yKienDonVi,
        this.daThuHoi,
        this.daDuyet,
        this.choTiepNhan,
        this.daTiepNhan,
        this.hoSoTrinhChoPhatHanh});

  ProfileStatisticModel.fromJson(Map<String, dynamic> json) {
    hoSoTrinh = json['hoSoTrinh'];
    taoMoi = json['taoMoi'];
    choDuyet = json['choDuyet'];
    yKienDonVi = json['yKienDonVi'];
    daThuHoi = json['daThuHoi'];
    daDuyet = json['daDuyet'];
    choTiepNhan = json['choTiepNhan'];
    daTiepNhan = json['daTiepNhan'];
    hoSoTrinhChoPhatHanh = json['hoSoTrinhChoPhatHanh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hoSoTrinh'] = this.hoSoTrinh;
    data['taoMoi'] = this.taoMoi;
    data['choDuyet'] = this.choDuyet;
    data['yKienDonVi'] = this.yKienDonVi;
    data['daThuHoi'] = this.daThuHoi;
    data['daDuyet'] = this.daDuyet;
    data['choTiepNhan'] = this.choTiepNhan;
    data['daTiepNhan'] = this.daTiepNhan;
    data['hoSoTrinhChoPhatHanh'] = this.hoSoTrinhChoPhatHanh;
    return data;
  }
}