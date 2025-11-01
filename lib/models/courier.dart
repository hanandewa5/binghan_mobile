class Courier {
  int code;
  String msg;
  Data? data;

  Courier({required this.code, required this.msg, this.data});

  factory Courier.fromJson(Map<String, dynamic> json) => Courier(
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
  List<ListCourier>? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListCourier>.from(
      json["list"].map((x) => ListCourier.fromJson(x)),
    ),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
    "total": total,
  };
}

class ListCourier {
  int? id;
  String? code;
  String? name;

  ListCourier({this.id, this.code, this.name});

  factory ListCourier.fromJson(Map<String, dynamic> json) =>
      ListCourier(id: json["id"], code: json["code"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "code": code, "name": name};
}
