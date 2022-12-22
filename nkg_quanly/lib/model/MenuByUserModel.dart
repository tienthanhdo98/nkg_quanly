class MenuByUserModel {
  String? id;
  String? name;
  String? url;
  String? description;
  String? icon;
  String? iconPath;
  bool? status;
  dynamic parentId;
  String? appId;
  bool? isDeleted;
  String? createdBy;
  String? lastModifiedBy;
  bool? hasChildrent;
  String? parentName;
  List<Childrens>? childrens;
  String? title;
  bool? root;
  String? svg;
  String? page;
  dynamic isDecentralization;
  String? bullet;
  List<MenuPermissions>? menuPermissions;
  List<MenuByUserModel>? submenu;

  MenuByUserModel(
      {this.id,
      this.name,
      this.url,
      this.description,
      this.icon,
      this.iconPath,
      this.status,
      this.parentId,
      this.appId,
      this.isDeleted,
      this.createdBy,
      this.lastModifiedBy,
      this.hasChildrent,
      this.parentName,
      this.childrens,
      this.title,
      this.root,
      this.svg,
      this.page,
      this.isDecentralization,
      this.bullet,
      this.menuPermissions,
      this.submenu});

  MenuByUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    description = json['description'];
    icon = json['icon'];
    iconPath = json['iconPath'];
    status = json['status'];
    parentId = json['parentId'];
    appId = json['appId'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    hasChildrent = json['hasChildrent'];
    parentName = json['parentName'];

    if (json['childrens'] != null) {
      childrens = <Childrens>[];
      json['childrens'].forEach((v) {
        childrens!.add(Childrens.fromJson(v));
      });
    }

    title = json['title'];
    root = json['root'];
    svg = json['svg'];
    page = json['page'];
    isDecentralization = json['isDecentralization'];
    bullet = json['bullet'];
    if (menuPermissions != null) {
      if (json['menuPermissions'] != null) {
        menuPermissions = <MenuPermissions>[];
        json['menuPermissions'].forEach((v) {
          menuPermissions!.add(new MenuPermissions.fromJson(v));
        });
      }
    }
    if (json['submenu'] != null) {
      submenu = <MenuByUserModel>[];
      json['submenu'].forEach((v) {
        submenu!.add(new MenuByUserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    data['description'] = description;
    data['icon'] = icon;
    data['iconPath'] = iconPath;
    data['status'] = status;
    data['parentId'] = parentId;
    data['appId'] = appId;
    data['isDeleted'] = isDeleted;
    data['createdBy'] = createdBy;
    data['lastModifiedBy'] = lastModifiedBy;
    data['hasChildrent'] = hasChildrent;
    data['parentName'] = parentName;
    if (childrens != null) {
      data['childrens'] = childrens!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    data['root'] = root;
    data['svg'] = svg;
    data['page'] = page;
    data['isDecentralization'] = isDecentralization;
    data['bullet'] = bullet;
    if (menuPermissions != null) {
      data['menuPermissions'] =
          menuPermissions!.map((v) => v.toJson()).toList();
    }
    if (submenu != null) {
      data['submenu'] = submenu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Childrens {
  String? id;
  String? name;
  String? url;
  String? description;
  String? icon;
  String? iconPath;
  bool? status;
  String? parentId;
  String? appId;
  bool? isDeleted;
  String? createdBy;
  dynamic lastModifiedBy;
  bool? hasChildrent;
  String? parentName;
  List<Childrens>? childrens;
  String? title;
  bool? root;
  String? svg;
  String? page;
  Null? isDecentralization;
  String? bullet;
  List<MenuPermissions>? menuPermissions;
  List<MenuByUserModel>? submenu;

  Childrens(
      {this.id,
      this.name,
      this.url,
      this.description,
      this.icon,
      this.iconPath,
      this.status,
      this.parentId,
      this.appId,
      this.isDeleted,
      this.createdBy,
      this.lastModifiedBy,
      this.hasChildrent,
      this.parentName,
      this.childrens,
      this.title,
      this.root,
      this.svg,
      this.page,
      this.isDecentralization,
      this.bullet,
      this.menuPermissions,
      this.submenu});

  Childrens.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    description = json['description'];
    icon = json['icon'];
    iconPath = json['iconPath'];
    status = json['status'];
    parentId = json['parentId'];
    appId = json['appId'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    hasChildrent = json['hasChildrent'];
    parentName = json['parentName'];
    if (json['childrens'] != null) {
      childrens = <Childrens>[];
      json['childrens'].forEach((v) {
        childrens!.add(Childrens.fromJson(v));
      });
    }
    title = json['title'];
    root = json['root'];
    svg = json['svg'];
    page = json['page'];
    isDecentralization = json['isDecentralization'];
    bullet = json['bullet'];
    if(menuPermissions != null) {
      if (json['menuPermissions'] != null) {
        menuPermissions = <MenuPermissions>[];
        json['menuPermissions'].forEach((v) {
          menuPermissions!.add(MenuPermissions.fromJson(v));
        });
      }
    }
    if (json['submenu'] != null) {
      submenu = <MenuByUserModel>[];
      json['submenu'].forEach((v) {
        submenu!.add(MenuByUserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    data['description'] = description;
    data['icon'] = icon;
    data['iconPath'] = iconPath;
    data['status'] = status;
    data['parentId'] = parentId;
    data['appId'] = appId;
    data['isDeleted'] = isDeleted;
    data['createdBy'] = createdBy;
    data['lastModifiedBy'] = lastModifiedBy;
    data['hasChildrent'] = hasChildrent;
    data['parentName'] = parentName;
    if (childrens != null) {
      data['childrens'] = childrens!.map((v) => v).toList();
    }
    data['title'] = title;
    data['root'] = root;
    data['svg'] = svg;
    data['page'] = page;
    data['isDecentralization'] = isDecentralization;
    data['bullet'] = bullet;
    if (menuPermissions != null) {
      data['menuPermissions'] =
          menuPermissions!.map((v) => v.toJson()).toList();
    }
    if (submenu != null) {
      data['submenu'] = submenu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuPermissions {
  Permission? permission;
  bool? isGranted;

  MenuPermissions({this.permission, this.isGranted});

  MenuPermissions.fromJson(Map<String, dynamic> json) {
    permission = json['permission'] != null
        ? new Permission.fromJson(json['permission'])
        : null;
    isGranted = json['isGranted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (permission != null) {
      data['permission'] = permission!.toJson();
    }
    data['isGranted'] = isGranted;
    return data;
  }
}

class Permission {
  String? id;
  String? code;
  String? name;
  String? description;
  bool? status;
  bool? isDeleted;

  Permission(
      {this.id,
      this.code,
      this.name,
      this.description,
      this.status,
      this.isDeleted});

  Permission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['description'] = description;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    return data;
  }
}
