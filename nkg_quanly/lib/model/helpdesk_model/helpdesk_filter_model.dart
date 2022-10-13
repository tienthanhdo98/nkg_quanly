class HelpdeskFilterModel {
  int? status;
  String? name;
  int? total;

  HelpdeskFilterModel({this.status, this.name, this.total});

  HelpdeskFilterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['name'] = this.name;
    data['total'] = this.total;
    return data;
  }
}