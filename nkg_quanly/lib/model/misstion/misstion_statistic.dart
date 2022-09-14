class MissionStatisticModel {
  List<StatisticMissionOverTimeByMonths>? statisticMissionOverTimeByMonths;
  List<StatisticMissionByStatuses>? statisticMissionByStatuses;

  MissionStatisticModel(
      {this.statisticMissionOverTimeByMonths, this.statisticMissionByStatuses});

  MissionStatisticModel.fromJson(Map<String, dynamic> json) {
    if (json['statisticMissionOverTimeByMonths'] != null) {
      statisticMissionOverTimeByMonths = <StatisticMissionOverTimeByMonths>[];
      json['statisticMissionOverTimeByMonths'].forEach((v) {
        statisticMissionOverTimeByMonths!
            .add(StatisticMissionOverTimeByMonths.fromJson(v));
      });
    }
    if (json['statisticMissionByStatuses'] != null) {
      statisticMissionByStatuses = <StatisticMissionByStatuses>[];
      json['statisticMissionByStatuses'].forEach((v) {
        statisticMissionByStatuses!
            .add(StatisticMissionByStatuses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (statisticMissionOverTimeByMonths != null) {
      data['statisticMissionOverTimeByMonths'] = statisticMissionOverTimeByMonths!
          .map((v) => v.toJson())
          .toList();
    }
    if (statisticMissionByStatuses != null) {
      data['statisticMissionByStatuses'] =
          statisticMissionByStatuses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatisticMissionOverTimeByMonths {
  int? month;
  int? quantity;

  StatisticMissionOverTimeByMonths({this.month, this.quantity});

  StatisticMissionOverTimeByMonths.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['quantity'] = quantity;
    return data;
  }
}

class StatisticMissionByStatuses {
  String? status;
  int? quantity;

  StatisticMissionByStatuses({this.status, this.quantity});

  StatisticMissionByStatuses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['quantity'] = quantity;
    return data;
  }
}