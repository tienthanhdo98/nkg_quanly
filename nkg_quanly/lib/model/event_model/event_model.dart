class EventModel {
  String? id;
  String? name;
  Null? shortDescription;
  String? description;
  Null? address;
  String? createdDate;
  String? timeEvent;
  bool? status;
  String? createdBy;
  dynamic lastModifiedBy;
  bool? isDeleted;

  EventModel(
      {this.id,
        this.name,
        this.shortDescription,
        this.description,
        this.address,
        this.createdDate,
        this.timeEvent,
        this.status,
        this.createdBy,
        this.lastModifiedBy,
        this.isDeleted});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDescription = json['shortDescription'];
    description = json['description'];
    address = json['address'];
    createdDate = json['createdDate'];
    timeEvent = json['timeEvent'];
    status = json['status'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortDescription'] = this.shortDescription;
    data['description'] = this.description;
    data['address'] = this.address;
    data['createdDate'] = this.createdDate;
    data['timeEvent'] = this.timeEvent;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}