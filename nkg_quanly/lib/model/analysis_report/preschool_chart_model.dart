class PreSchoolChartModel {
  String? chartName;
  List<PreSchoolChartItems>? items;

  PreSchoolChartModel({this.chartName, this.items});

  PreSchoolChartModel.fromJson(Map<String, dynamic> json) {
    chartName = json['chartName'];
    if (json['items'] != null) {
      items = <PreSchoolChartItems>[];
      json['items'].forEach((v) {
        items!.add(PreSchoolChartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chartName'] = chartName;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreSchoolChartItems {
  String? name;
  String? value;
  List<PreSchoolChartItems>? items;

  PreSchoolChartItems({this.name, this.value, this.items});

  PreSchoolChartItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    if (json['items'] != null) {
      items = <PreSchoolChartItems>[];
      json['items'].forEach((v) {
        items!.add(PreSchoolChartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
