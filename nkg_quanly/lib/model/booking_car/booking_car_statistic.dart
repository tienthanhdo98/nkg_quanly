class BookingCarStatistic {
  int? total;
  int? vacancy;
  int? booked;

  BookingCarStatistic({this.total, this.vacancy, this.booked});

  BookingCarStatistic.fromJson(Map<String, dynamic> json) {
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
