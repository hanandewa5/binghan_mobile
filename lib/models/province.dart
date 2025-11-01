class Province {
  int code;
  String msg;
  Data? data;

  Province({required this.code, required this.msg, this.data});

  factory Province.fromJson(Map<String, dynamic> json) => Province(
    code: json["code"],
    msg: json["msg"],
    data: (json["code"] != 200) ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  List<ListProvince>? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListProvince>.from(
      json["list"].map((x) => ListProvince.fromJson(x)),
    ),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
    "total": total,
  };
}

class ListProvince {
  int? provinceId;
  String? province;

  ListProvince({this.provinceId, this.province});

  factory ListProvince.fromJson(Map<String, dynamic> json) =>
      ListProvince(provinceId: json["province_id"], province: json["province"]);

  Map<String, dynamic> toJson() => {
    "province_id": provinceId,
    "province": province,
  };
}
