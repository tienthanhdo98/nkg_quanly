class PmisUnitModel {
  String? id;
  String? ten;
  String? soLuong;

  PmisUnitModel({this.id, this.ten, this.soLuong});

  PmisUnitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    soLuong = json['soLuong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['soLuong'] = this.soLuong;
    return data;
  }
}