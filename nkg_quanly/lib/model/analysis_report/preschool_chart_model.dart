class AnalysisChartModel {
  String? chartName;
  List<ChartChildItems>? items;

  AnalysisChartModel({this.chartName, this.items});

  AnalysisChartModel.fromJson(Map<String, dynamic> json) {
    chartName = json['chartName'];
    if (json['items'] != null) {
      items = <ChartChildItems>[];
      json['items'].forEach((v) {
        items!.add(ChartChildItems.fromJson(v));
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

class ChartChildItems {
  String? name;
  String? value;
  List<ChartChildItems>? items;

  ChartChildItems({this.name, this.value, this.items});

  ChartChildItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    if (json['items'] != null) {
      items = <ChartChildItems>[];
      json['items'].forEach((v) {
        items!.add(ChartChildItems.fromJson(v));
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
