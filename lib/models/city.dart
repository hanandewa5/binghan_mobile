class City {
  int code;
  String msg;
  Data? data;

  City({required this.code, required this.msg, this.data});

  factory City.fromJson(Map<String, dynamic> json) => City(
    code: json["code"],
    msg: json["msg"],
    data: (json["code"] == 200) ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  List<ListCity>? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListCity>.from(json["list"].map((x) => ListCity.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
    "total": total,
  };
}

class ListCity {
  int? cityId;
  String? cityName;

  ListCity({this.cityId, this.cityName});

  factory ListCity.fromJson(Map<String, dynamic> json) =>
      ListCity(cityId: json["city_id"], cityName: json["city_name"]);

  Map<String, dynamic> toJson() => {"city_id": cityId, "city_name": cityName};
}
