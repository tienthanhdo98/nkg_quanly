class ProfileProcedureModel {
  List<ProfileProcedureListItems>? items;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  ProfileProcedureModel(
      {this.items,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  ProfileProcedureModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ProfileProcedureListItems>[];
      json['items'].forEach((v) {
        items!.add(new ProfileProcedureListItems.fromJson(v));
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

class ProfileProcedureListItems {
  String? soDienThoai;
  String? diaChi;
  String? ngayNhanHoSo;
  String? ngayHenTraKetQua;
  String? trichYeu;
  String? chuHoSo;
  String? maSoBienNhan;
  String? tenThuTucHanhChinh;
  String? ngayNopHoSo;
  String? maSoHoSo;
  String? thuTucHanhChinhId;
  String? trangThaiHoSo;
  String? level;
  String? status;

  ProfileProcedureListItems(
      {this.soDienThoai,
        this.diaChi,
        this.ngayNhanHoSo,
        this.ngayHenTraKetQua,
        this.trichYeu,
        this.chuHoSo,
        this.maSoBienNhan,
        this.tenThuTucHanhChinh,
        this.ngayNopHoSo,
        this.maSoHoSo,
        this.thuTucHanhChinhId,
        this.trangThaiHoSo,
        this.level,
        this.status});

  ProfileProcedureListItems.fromJson(Map<String, dynamic> json) {
    soDienThoai = json['soDienThoai'];
    diaChi = json['diaChi'];
    ngayNhanHoSo = json['ngayNhanHoSo'];
    ngayHenTraKetQua = json['ngayHenTraKetQua'];
    trichYeu = json['trichYeu'];
    chuHoSo = json['chuHoSo'];
    maSoBienNhan = json['maSoBienNhan'];
    tenThuTucHanhChinh = json['tenThuTucHanhChinh'];
    ngayNopHoSo = json['ngayNopHoSo'];
    maSoHoSo = json['maSoHoSo'];
    thuTucHanhChinhId = json['thuTucHanhChinhId'];
    trangThaiHoSo = json['trangThaiHoSo'];
    level = json['level'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soDienThoai'] = this.soDienThoai;
    data['diaChi'] = this.diaChi;
    data['ngayNhanHoSo'] = this.ngayNhanHoSo;
    data['ngayHenTraKetQua'] = this.ngayHenTraKetQua;
    data['trichYeu'] = this.trichYeu;
    data['chuHoSo'] = this.chuHoSo;
    data['maSoBienNhan'] = this.maSoBienNhan;
    data['tenThuTucHanhChinh'] = this.tenThuTucHanhChinh;
    data['ngayNopHoSo'] = this.ngayNopHoSo;
    data['maSoHoSo'] = this.maSoHoSo;
    data['thuTucHanhChinhId'] = this.thuTucHanhChinhId;
    data['trangThaiHoSo'] = this.trangThaiHoSo;
    data['level'] = this.level;
    data['status'] = this.status;
    return data;
  }
}