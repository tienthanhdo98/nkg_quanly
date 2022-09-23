class ReportStatisticModel {
  int? tong;
  int? daTiepNhan;
  int? daGiao;
  int? dungHan;
  int? chuaDenHan;
  int? somHan;
  int? quaHan;

  ReportStatisticModel(
      {this.tong,
        this.daTiepNhan,
        this.daGiao,
        this.dungHan,
        this.chuaDenHan,
        this.somHan,
        this.quaHan});

  ReportStatisticModel.fromJson(Map<String, dynamic> json) {
    tong = json['tong'];
    daTiepNhan = json['daTiepNhan'];
    daGiao = json['daGiao'];
    dungHan = json['dungHan'];
    chuaDenHan = json['chuaDenHan'];
    somHan = json['somHan'];
    quaHan = json['quaHan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tong'] = this.tong;
    data['daTiepNhan'] = this.daTiepNhan;
    data['daGiao'] = this.daGiao;
    data['dungHan'] = this.dungHan;
    data['chuaDenHan'] = this.chuaDenHan;
    data['somHan'] = this.somHan;
    data['quaHan'] = this.quaHan;
    return data;
  }
}