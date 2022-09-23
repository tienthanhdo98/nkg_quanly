class MissionStatisticModel {
  int? tong;
  int? chuaXuLy;
  int? dangThucHien;
  int? daHuy;
  int? daTamDung;
  int? quaHan;
  int? trongHan;

  MissionStatisticModel({this.tong,
    this.chuaXuLy,
    this.dangThucHien,
    this.daHuy,
    this.daTamDung,
    this.quaHan,
    this.trongHan});

  MissionStatisticModel.fromJson(Map<String, dynamic> json) {
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