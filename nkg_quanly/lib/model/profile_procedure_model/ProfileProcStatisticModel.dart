class ProfileProcedureStatisticModel {
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

  ProfileProcedureStatisticModel(
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

  ProfileProcedureStatisticModel.fromJson(Map<String, dynamic> json) {
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