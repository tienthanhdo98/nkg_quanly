class StatisticModel {
  String? tongSoBienChe;
  String? tongSoCongChuc;

  StatisticModel({this.tongSoBienChe, this.tongSoCongChuc});

  StatisticModel.fromJson(Map<String, dynamic> json) {
    tongSoBienChe = json['tongSoBienChe'];
    tongSoCongChuc = json['tongSoCongChuc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tongSoBienChe'] = this.tongSoBienChe;
    data['tongSoCongChuc'] = this.tongSoCongChuc;
    return data;
  }
}