

import '../misstion/mission_detail.dart';

class ProfileProcedureModel {
  List<ProfileProcedureListItems>? items;
  ProfileProcedureStatistic? statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  ProfileProcedureModel(
      {this.items,
        this.statistic,
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
    statistic = json['statistic'] != null
        ? new ProfileProcedureStatistic.fromJson(json['statistic'])
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
  String? tinhTrangHoSo;
  String? trangThaiHoSo;
  String? tenTrangThaiHoSo;
  String? level;
  String? status;
  String? receptionForm;
  String? tenCoquan;
  String? coquanId;
  String? nhomThutucId;
  String? linhVucId;
  String? tenLinhVuc;
  String? canBoHienThoi;
  String? thoiHanXuLy;
  String? nguoiNopHoSo;
  String? diaChiNguoiNop;
  String? dienThoaiNguoiNop;
  String? ghiChu;
  String? xemDon;
  String? tenNhomThuTuc;
  List<Timelines>? timelines;

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
        this.tinhTrangHoSo,
        this.trangThaiHoSo,
        this.tenTrangThaiHoSo,
        this.level,
        this.status,
        this.receptionForm,
        this.tenCoquan,
        this.coquanId,
        this.nhomThutucId,
        this.linhVucId,
        this.tenLinhVuc,
        this.canBoHienThoi,
        this.thoiHanXuLy,
        this.nguoiNopHoSo,
        this.diaChiNguoiNop,
        this.dienThoaiNguoiNop,
        this.ghiChu,
        this.xemDon,
        this.tenNhomThuTuc,
        this.timelines});

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
    tinhTrangHoSo = json['tinhTrangHoSo'];
    trangThaiHoSo = json['trangThaiHoSo'];
    tenTrangThaiHoSo = json['tenTrangThaiHoSo'];
    level = json['level'];
    status = json['status'];
    receptionForm = json['receptionForm'];
    tenCoquan = json['tenCoquan'];
    coquanId = json['coquanId'];
    nhomThutucId = json['nhomThutucId'];
    linhVucId = json['linhVucId'];
    tenLinhVuc = json['tenLinhVuc'];
    canBoHienThoi = json['canBoHienThoi'];
    thoiHanXuLy = json['thoiHanXuLy'];
    nguoiNopHoSo = json['nguoiNopHoSo'];
    diaChiNguoiNop = json['diaChiNguoiNop'];
    dienThoaiNguoiNop = json['dienThoaiNguoiNop'];
    ghiChu = json['ghiChu'];
    xemDon = json['xemDon'];
    tenNhomThuTuc = json['tenNhomThuTuc'];
    if (json['timelines'] != null) {
      timelines = <Timelines>[];
      json['timelines'].forEach((v) {
        timelines!.add(new Timelines.fromJson(v));
      });
    }
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
    data['tinhTrangHoSo'] = this.tinhTrangHoSo;
    data['trangThaiHoSo'] = this.trangThaiHoSo;
    data['tenTrangThaiHoSo'] = this.tenTrangThaiHoSo;
    data['level'] = this.level;
    data['status'] = this.status;
    data['receptionForm'] = this.receptionForm;
    data['tenCoquan'] = this.tenCoquan;
    data['coquanId'] = this.coquanId;
    data['nhomThutucId'] = this.nhomThutucId;
    data['linhVucId'] = this.linhVucId;
    data['tenLinhVuc'] = this.tenLinhVuc;
    data['canBoHienThoi'] = this.canBoHienThoi;
    data['thoiHanXuLy'] = this.thoiHanXuLy;
    data['nguoiNopHoSo'] = this.nguoiNopHoSo;
    data['diaChiNguoiNop'] = this.diaChiNguoiNop;
    data['dienThoaiNguoiNop'] = this.dienThoaiNguoiNop;
    data['ghiChu'] = this.ghiChu;
    data['xemDon'] = this.xemDon;
    data['tenNhomThuTuc'] = this.tenNhomThuTuc;
    if (this.timelines != null) {
      data['timelines'] = this.timelines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class ProfileProcedureStatistic {
  int? tongSoHoSo;
  int? hoSoTiepNhanTrucTuyen;
  int? hoSoTiepNhanTrucTiep;
  int? hoSoDungHan;
  int? hoSoSomHan;
  int? hoSoChuaDenHan;
  int? hoSoQuaHan;
  int? choTiepNhan;
  int? choBoSung;
  int? choTraKetQua;
  int? daBoSung;
  int? dangXuLy;
  int? daXuLy;
  int? choGiaiQuyet;
  int? dangTrinhKy;
  int? dangPhanCong;
  int? choPhanCongThuLy;

  ProfileProcedureStatistic(
      {this.tongSoHoSo,
        this.hoSoTiepNhanTrucTuyen,
        this.hoSoTiepNhanTrucTiep,
        this.hoSoDungHan,
        this.hoSoSomHan,
        this.hoSoChuaDenHan,
        this.hoSoQuaHan,
        this.choTiepNhan,
        this.choBoSung,
        this.choTraKetQua,
        this.daBoSung,
        this.dangXuLy,
        this.daXuLy,
        this.choGiaiQuyet,
        this.dangTrinhKy,
        this.dangPhanCong,
        this.choPhanCongThuLy});

  ProfileProcedureStatistic.fromJson(Map<String, dynamic> json) {
    tongSoHoSo = json['tongSoHoSo'];
    hoSoTiepNhanTrucTuyen = json['hoSoTiepNhanTrucTuyen'];
    hoSoTiepNhanTrucTiep = json['hoSoTiepNhanTrucTiep'];
    hoSoDungHan = json['hoSoDungHan'];
    hoSoSomHan = json['hoSoSomHan'];
    hoSoChuaDenHan = json['hoSoChuaDenHan'];
    hoSoQuaHan = json['hoSoQuaHan'];
    choTiepNhan = json['choTiepNhan'];
    choBoSung = json['choBoSung'];
    choTraKetQua = json['choTraKetQua'];
    daBoSung = json['daBoSung'];
    dangXuLy = json['dangXuLy'];
    daXuLy = json['daXuLy'];
    choGiaiQuyet = json['choGiaiQuyet'];
    dangTrinhKy = json['dangTrinhKy'];
    dangPhanCong = json['dangPhanCong'];
    choPhanCongThuLy = json['choPhanCongThuLy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tongSoHoSo'] = this.tongSoHoSo;
    data['hoSoTiepNhanTrucTuyen'] = this.hoSoTiepNhanTrucTuyen;
    data['hoSoTiepNhanTrucTiep'] = this.hoSoTiepNhanTrucTiep;
    data['hoSoDungHan'] = this.hoSoDungHan;
    data['hoSoSomHan'] = this.hoSoSomHan;
    data['hoSoChuaDenHan'] = this.hoSoChuaDenHan;
    data['hoSoQuaHan'] = this.hoSoQuaHan;
    data['choTiepNhan'] = this.choTiepNhan;
    data['choBoSung'] = this.choBoSung;
    data['choTraKetQua'] = this.choTraKetQua;
    data['daBoSung'] = this.daBoSung;
    data['dangXuLy'] = this.dangXuLy;
    data['daXuLy'] = this.daXuLy;
    data['choGiaiQuyet'] = this.choGiaiQuyet;
    data['dangTrinhKy'] = this.dangTrinhKy;
    data['dangPhanCong'] = this.dangPhanCong;
    data['choPhanCongThuLy'] = this.choPhanCongThuLy;
    return data;
  }
}
