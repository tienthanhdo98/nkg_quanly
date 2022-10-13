class ProfileProcChartModel {
  String? ten;
  int? trongHan;
  int? quaHan;

  ProfileProcChartModel({this.ten, this.trongHan, this.quaHan});

  ProfileProcChartModel.fromJson(Map<String, dynamic> json) {
    ten = json['ten'];
    trongHan = json['trongHan'];
    quaHan = json['quaHan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ten'] = this.ten;
    data['trongHan'] = this.trongHan;
    data['quaHan'] = this.quaHan;
    return data;
  }
}