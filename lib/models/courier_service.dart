class CourierService {
  int code;
  String msg;
  Data? data;

  CourierService({required this.code, required this.msg, this.data});

  factory CourierService.fromJson(Map<String, dynamic> json) => CourierService(
    code: json["code"],
    msg: json["msg"],
    data: json["code"] != 200 ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  List<ListElement>? list;

  Data({this.list});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListElement>.from(
      json["list"] == null
          ? []
          : json["list"].map((x) => ListElement.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
  };
}

class ListElement {
  String? code;
  String? name;
  List<ListCourierService>? costs;

  ListElement({this.code, this.name, this.costs});

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    code: json["code"],
    name: json["name"],
    costs: List<ListCourierService>.from(
      json["Costs"].map((x) => ListCourierService.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "Costs": List<dynamic>.from(costs?.map((x) => x.toJson()) ?? []),
  };
}

class ListCourierService {
  String? service;
  String? description;
  List<CourierServiceItem>? cost;

  ListCourierService({this.service, this.description, this.cost});

  factory ListCourierService.fromJson(Map<String, dynamic> json) =>
      ListCourierService(
        service: json["service"],
        description: json["description"],
        cost: List<CourierServiceItem>.from(
          json["Cost"].map((x) => CourierServiceItem.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "service": service,
    "description": description,
    "Cost": List<dynamic>.from(cost?.map((x) => x.toJson()) ?? []),
  };
}

class CourierServiceItem {
  int? value;
  String? etd;
  String? note;

  CourierServiceItem({this.value, this.etd, this.note});

  factory CourierServiceItem.fromJson(Map<String, dynamic> json) =>
      CourierServiceItem(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {"value": value, "etd": etd, "note": note};
}
