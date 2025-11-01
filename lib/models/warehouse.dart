class Warehouse {
  int code;
  String msg;
  Data? data;

  Warehouse({required this.code, required this.msg, this.data});

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
    code: json["code"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  List<ListWarehouse>? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: json["list"] != null
        ? List<ListWarehouse>.from(
            json["list"].map((x) => ListWarehouse.fromJson(x)),
          )
        : null,
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": list != null
        ? List<dynamic>.from(list!.map((x) => x.toJson()))
        : null,
    "total": total,
  };
}

class ListWarehouse {
  int? id;
  String? name;
  int? kecamatanId;

  ListWarehouse({this.id, this.name, this.kecamatanId});

  factory ListWarehouse.fromJson(Map<String, dynamic> json) => ListWarehouse(
    id: json["id"],
    name: json["name"],
    kecamatanId: json["kecamatan_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "kecamatan_id": kecamatanId,
  };
}
