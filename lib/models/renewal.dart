import 'dart:convert';

Renewal renewalFromJson(String str) => Renewal.fromJson(json.decode(str));

String renewalToJson(Renewal data) => json.encode(data.toJson());

class Renewal {
  int code;
  String msg;
  Data? data;

  Renewal({required this.code, required this.msg, this.data});

  factory Renewal.fromJson(Map<String, dynamic> json) => Renewal(
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
  ListClass? list;

  Data({this.list});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(list: ListClass.fromJson(json["list"]));

  Map<String, dynamic> toJson() => {"list": list?.toJson()};
}

class ListClass {
  int? memberId;
  String? keterangan;
  bool? lunas;
  int? kekuranganPv;
  String? renewalFeeStatus;

  ListClass({
    this.memberId,
    this.keterangan,
    this.lunas,
    this.kekuranganPv,
    this.renewalFeeStatus,
  });

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
    memberId: json["member_id"],
    keterangan: json["keterangan"],
    lunas: json["lunas"],
    kekuranganPv: json["kekurangan_pv"],
    renewalFeeStatus: json["renewal_fee_status"],
  );

  Map<String, dynamic> toJson() => {
    "member_id": memberId,
    "keterangan": keterangan,
    "lunas": lunas,
    "kekurangan_pv": kekuranganPv,
    "renewal_fee_status": renewalFeeStatus,
  };
}
