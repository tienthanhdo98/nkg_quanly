class PmisChartModel {
  String? ten;
  String? soLuong;
  String? type;
  Null? donVi;

  PmisChartModel({this.ten, this.soLuong, this.type, this.donVi});

  PmisChartModel.fromJson(Map<String, dynamic> json) {
    ten = json['ten'];
    soLuong = json['soLuong'];
    type = json['type'];
    donVi = json['donVi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ten'] = this.ten;
    data['soLuong'] = this.soLuong;
    data['type'] = this.type;
    data['donVi'] = this.donVi;
    return data;
  }
}