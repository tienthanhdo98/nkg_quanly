class DocumentStatisticModel {
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

  DocumentStatisticModel(
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

  DocumentStatisticModel.fromJson(Map<String, dynamic> json) {
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
