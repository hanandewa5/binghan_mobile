import 'package:date_format/date_format.dart';

class GroupSales {
  int code;
  String msg;
  Data? data;

  GroupSales({required this.code, required this.msg, this.data});

  factory GroupSales.fromJson(Map<String, dynamic> json) => GroupSales(
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
  List<ListGroupSales>? list;

  Data({this.list});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListGroupSales>.from(
      json["list"].map((x) => ListGroupSales.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
  };
}

class ListGroupSales {
  int? level;
  int? memberId;
  String? binghanId;
  String? nama;
  String? sponsorId;
  String? sponsorBinghanId;
  String? sponsorName;
  int? persen;
  int? pv;
  int? expireDate;
  int? syaratPv;
  String? expireDateFormated;

  ListGroupSales({
    this.level,
    this.memberId,
    this.binghanId,
    this.nama,
    this.sponsorId,
    this.persen,
    this.pv,
    this.sponsorBinghanId,
    this.sponsorName,
    this.syaratPv,
    this.expireDate,
    this.expireDateFormated,
  });

  factory ListGroupSales.fromJson(Map<String, dynamic> json) => ListGroupSales(
    level: json["level"],
    memberId: json["member_id"],
    binghanId: json["binghan_id"],
    nama: json["nama"],
    sponsorId: json["sponsor_id"],
    sponsorBinghanId: json["sponsor_binghan_id"],
    sponsorName: json["sponsor_name"],
    persen: json["persen"],
    pv: json["pv"],
    expireDate: json["expire_date"],
    syaratPv: json["syarat_pv"],
    expireDateFormated: formatDate(
      DateTime.fromMillisecondsSinceEpoch(json["expire_date"] * 1000),
      [d, " ", M, " ", yyyy],
    ),
  );

  Map<String, dynamic> toJson() => {
    "level": level,
    "member_id": memberId,
    "binghan_id": binghanId,
    "nama": nama,
    "sponsor_id": sponsorId,
    "persen": persen,
    "pv": pv,
    "sponsor_binghan_id": sponsorBinghanId,
    "sponsor_name": sponsorName,
    "expire_date": expireDate,
    "syarat_pv": syaratPv,
  };
}
