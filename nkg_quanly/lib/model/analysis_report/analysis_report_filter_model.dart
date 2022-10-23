class AnalysisReportFilterModel {
  String? id;
  String? name;
  dynamic areaId;

  AnalysisReportFilterModel({this.id, this.name, this.areaId});

  AnalysisReportFilterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    areaId = json['areaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['areaId'] = areaId;
    return data;
  }
}