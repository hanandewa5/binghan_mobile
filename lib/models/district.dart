class District {
  int code;
  String msg;
  Data? data;

  District({required this.code, required this.msg, this.data});

  factory District.fromJson(Map<String, dynamic> json) => District(
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
  List<ListDistrict>? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListDistrict>.from(
      json["list"].map((x) => ListDistrict.fromJson(x)),
    ),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
    "total": total,
  };
}

class ListDistrict {
  int? subdistrictId;
  String? subdistrictName;

  ListDistrict({this.subdistrictId, this.subdistrictName});

  factory ListDistrict.fromJson(Map<String, dynamic> json) => ListDistrict(
    subdistrictId: json["subdistrict_id"],
    subdistrictName: json["subdistrict_name"],
  );

  Map<String, dynamic> toJson() => {
    "subdistrict_id": subdistrictId,
    "subdistrict_name": subdistrictName,
  };
}
