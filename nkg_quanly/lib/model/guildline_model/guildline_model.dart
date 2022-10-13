class GuidelineModel {
  List<GuidelineListItems>? items;
  dynamic statistic;
  int? pageIndex;
  int? pageSize;
  int? totalRecords;
  int? pageCount;

  GuidelineModel(
      {this.items,
        this.statistic,
        this.pageIndex,
        this.pageSize,
        this.totalRecords,
        this.pageCount});

  GuidelineModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <GuidelineListItems>[];
      json['items'].forEach((v) {
        items!.add(new GuidelineListItems.fromJson(v));
      });
    }
    statistic = json['statistic'];
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
    data['statistic'] = this.statistic;
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalRecords'] = this.totalRecords;
    data['pageCount'] = this.pageCount;
    return data;
  }
}

class GuidelineListItems {
  String? id;
  String? name;
  dynamic shortDescription;
  String? description;
  String? fileName;
  String? filePath;
  bool? status;
  bool? isDeleted;

  GuidelineListItems(
      {this.id,
        this.name,
        this.shortDescription,
        this.description,
        this.fileName,
        this.filePath,
        this.status,
        this.isDeleted});

  GuidelineListItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDescription = json['shortDescription'];
    description = json['description'];
    fileName = json['fileName'];
    filePath = json['filePath'];
    status = json['status'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortDescription'] = this.shortDescription;
    data['description'] = this.description;
    data['fileName'] = this.fileName;
    data['filePath'] = this.filePath;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}