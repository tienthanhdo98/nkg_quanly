class MeetingRoomStatisticModel {
  int? total;
  int? vacancy;
  int? booked;

  MeetingRoomStatisticModel({this.total, this.vacancy, this.booked});

  MeetingRoomStatisticModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    vacancy = json['vacancy'];
    booked = json['booked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['vacancy'] = this.vacancy;
    data['booked'] = this.booked;
    return data;
  }
}
