class ProfileStatisticModel {
  int? tong;
  int? daTiepNhan;
  int? choTiepNhan;
  int? daDuyet;
  int? daThuHoi;
  int? yKienDonVi;
  int? choDuyet;
  int? taoMoi;

  ProfileStatisticModel(
      {this.tong,
        this.daTiepNhan,
        this.choTiepNhan,
        this.daDuyet,
        this.daThuHoi,
        this.yKienDonVi,
        this.choDuyet,
        this.taoMoi});

  ProfileStatisticModel.fromJson(Map<String, dynamic> json) {
    tong = json['Tong'];
    daTiepNhan = json['DaTiepNhan'];
    choTiepNhan = json['ChoTiepNhan'];
    daDuyet = json['DaDuyet'];
    daThuHoi = json['DaThuHoi'];
    yKienDonVi = json['YKienDonVi'];
    choDuyet = json['ChoDuyet'];
    taoMoi = json['TaoMoi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Tong'] = this.tong;
    data['DaTiepNhan'] = this.daTiepNhan;
    data['ChoTiepNhan'] = this.choTiepNhan;
    data['DaDuyet'] = this.daDuyet;
    data['DaThuHoi'] = this.daThuHoi;
    data['YKienDonVi'] = this.yKienDonVi;
    data['ChoDuyet'] = this.choDuyet;
    data['TaoMoi'] = this.taoMoi;
    return data;
  }
}