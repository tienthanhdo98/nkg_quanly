class FilterProfileProcModel {
  String? id;
  String? ten;
  String? trangThai;
  String? tenLinhVuc;
  String? ma;
  String? nhomThuTucHanhChinhId;

  FilterProfileProcModel(
      {this.id,
        this.ten,
        this.trangThai,
        this.tenLinhVuc,
        this.ma,
        this.nhomThuTucHanhChinhId});

  FilterProfileProcModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    trangThai = json['trangThai'];
    tenLinhVuc = json['tenLinhVuc'];
    ma = json['ma'];
    nhomThuTucHanhChinhId = json['nhomThuTucHanhChinhId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['trangThai'] = this.trangThai;
    data['tenLinhVuc'] = this.tenLinhVuc;
    data['ma'] = this.ma;
    data['nhomThuTucHanhChinhId'] = this.nhomThuTucHanhChinhId;
    return data;
  }
}