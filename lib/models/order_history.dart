import 'package:date_format/date_format.dart';

class OrderHistory {
  int code;
  String msg;
  Data? data;

  OrderHistory({required this.code, required this.msg, this.data});

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
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
  List<ListOrderHistory>? list;

  Data({this.list});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListOrderHistory>.from(
      json["list"].map((x) => ListOrderHistory.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
  };
}

class ListOrderHistory {
  int? id;
  String? invoiceNo;
  int? invoiceDate;
  String? invoiceDateFormated;
  int? memberId;
  int? total;
  String? status;
  String? name;

  ListOrderHistory({
    this.id,
    this.invoiceNo,
    this.invoiceDate,
    this.invoiceDateFormated,
    this.memberId,
    this.total,
    this.status,
    this.name,
  });

  factory ListOrderHistory.fromJson(Map<String, dynamic> json) =>
      ListOrderHistory(
        id: json["id"],
        invoiceNo: json["invoice_no"],
        invoiceDate: json["invoice_date"],
        invoiceDateFormated: formatDate(
          DateTime.fromMillisecondsSinceEpoch(json["invoice_date"] * 1000),
          [d, " ", M, " ", yyyy, ", ", hh, ":", mm],
        ),
        memberId: json["member_id"],
        total: json["total"],
        status: json["status"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoice_no": invoiceNo,
    "invoice_date": invoiceDate,
    "member_id": memberId,
    "total": total,
    "status": status,
    "name": name,
  };
}
