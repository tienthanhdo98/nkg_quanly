class CalendarWorkModel {
  List<CalendarWorkListItems>? items;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  CalendarWorkModel(
      {this.items,
      this.pageIndex,
      this.pageSize,
      this.totalRecords,
      this.pageCount});

  CalendarWorkModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <CalendarWorkListItems>[];
      json['items'].forEach((v) {
        items!.add(new CalendarWorkListItems.fromJson(v));
      });
    }
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
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalRecords'] = this.totalRecords;
    data['pageCount'] = this.pageCount;
    return data;
  }
}

class CalendarWorkListItems {
  int? id;
  String? name;
  String? time;
  String? date;
  String? location;
  String? type;
  String? linkMeet;
  String? description;
  String? creator;
  List<Participants>? participants;

  CalendarWorkListItems(
      {this.id,
      this.name,
      this.time,
      this.date,
      this.location,
      this.type,
      this.linkMeet,
      this.description,
      this.creator,
      this.participants});

  CalendarWorkListItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    time = json['time'];
    date = json['date'];
    location = json['location'];
    type = json['type'];
    linkMeet = json['linkMeet'];
    description = json['description'];
    creator = json['creator'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['time'] = this.time;
    data['date'] = this.date;
    data['location'] = this.location;
    data['type'] = this.type;
    data['linkMeet'] = this.linkMeet;
    data['description'] = this.description;
    data['creator'] = this.creator;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Participants {
  String? name;
  String? position;

  Participants({this.name, this.position});

  Participants.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['position'] = this.position;
    return data;
  }
}
