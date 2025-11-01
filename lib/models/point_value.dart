class PointValue {
  int code;
  String msg;
  Data? data;

  PointValue({required this.code, required this.msg, this.data});

  factory PointValue.fromJson(Map<String, dynamic> json) => PointValue(
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
  int? id;
  int? pv;

  Data({this.id, this.pv});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(id: json["id"], pv: json["pv"]);

  Map<String, dynamic> toJson() => {"id": id, "pv": pv};
}
