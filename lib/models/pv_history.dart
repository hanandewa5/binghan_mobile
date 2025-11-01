import 'dart:convert';

import 'package:date_format/date_format.dart';

PvHistory pvHistoryFromJson(String str) => PvHistory.fromJson(json.decode(str));

String pvHistoryToJson(PvHistory data) => json.encode(data.toJson());

class PvHistory {
  int code;
  String msg;
  Data? data;

  PvHistory({required this.code, required this.msg, this.data});

  factory PvHistory.fromJson(Map<String, dynamic> json) => PvHistory(
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
  List<ListPvHistory>? list;

  Data({this.list});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListPvHistory>.from(
      json["list"].map((x) => ListPvHistory.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
  };
}

class ListPvHistory {
  int? memberId;
  int? amount;
  int? transDate;
  String? transDateFormated;
  String? transType;
  String? transTypeCustom;

  ListPvHistory({
    this.memberId,
    this.amount,
    this.transDate,
    this.transType,
    this.transTypeCustom,
    this.transDateFormated,
  });

  factory ListPvHistory.fromJson(Map<String, dynamic> json) => ListPvHistory(
    memberId: json["member_id"],
    amount: json["amount"],
    transDate: json["trans_date"],
    transType: json["trans_type"],
    transTypeCustom: json["trans_type"] != "transfer"
        ? "PEMBELIAN"
        : json["trans_type"].toUpperCase(),
    transDateFormated: formatDate(
      DateTime.fromMillisecondsSinceEpoch(json["trans_date"] * 1000),
      [d, " ", M, " ", yyyy],
    ),
  );

  Map<String, dynamic> toJson() => {
    "member_id": memberId,
    "amount": amount,
    "trans_date": transDate,
    "trans_type": transType,
  };
}
