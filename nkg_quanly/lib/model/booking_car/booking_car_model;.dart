class BookingCarModel {
  List<BookingCarListItems>? items;
  BookingStatistic? statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  BookingCarModel(
      {this.items,
      this.statistic,
      this.pageIndex,
      this.pageSize,
      this.totalRecords,
      this.pageCount});

  BookingCarModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <BookingCarListItems>[];
      json['items'].forEach((v) {
        items!.add(new BookingCarListItems.fromJson(v));
      });
    }
    statistic = json['statistic'] != null
        ? new BookingStatistic.fromJson(json['statistic'])
        : null;
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalRecords = json['totalRecords'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.statistic != null) {
      data['statistic'] = this.statistic!.toJson();
    }
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalRecords'] = this.totalRecords;
    data['pageCount'] = this.pageCount;
    return data;
  }
}

class BookingCarListItems {
  int? id;
  String? code;
  String? innitiatedDate;
  String? registrationDate;
  String? registrationTime;
  String? registerUser;
  String? content;
  String? status;

  BookingCarListItems(
      {this.id,
      this.code,
      this.innitiatedDate,
      this.registrationDate,
      this.registrationTime,
      this.registerUser,
      this.content,
      this.status});

  BookingCarListItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    innitiatedDate = json['innitiatedDate'];
    registrationDate = json['registrationDate'];
    registrationTime = json['registrationTime'];
    registerUser = json['registerUser'];
    content = json['content'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['innitiatedDate'] = this.innitiatedDate;
    data['registrationDate'] = this.registrationDate;
    data['registrationTime'] = this.registrationTime;
    data['registerUser'] = this.registerUser;
    data['content'] = this.content;
    data['status'] = this.status;
    return data;
  }
}

class BookingStatistic {
  int? total;
  int? vacancy;
  int? booked;

  BookingStatistic({this.total, this.vacancy, this.booked});

  BookingStatistic.fromJson(Map<String, dynamic> json) {
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
