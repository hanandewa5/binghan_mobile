// To parse this JSON data, do
//
//     final invoiceHeader = invoiceHeaderFromJson(jsonString);

import 'dart:convert';

import 'package:date_format/date_format.dart';

InvoiceHeader invoiceHeaderFromJson(String str) =>
    InvoiceHeader.fromJson(json.decode(str));

String invoiceHeaderToJson(InvoiceHeader data) => json.encode(data.toJson());

class InvoiceHeader {
  int code;
  String msg;
  Data? data;

  InvoiceHeader({required this.code, required this.msg, this.data});

  factory InvoiceHeader.fromJson(Map<String, dynamic> json) => InvoiceHeader(
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
  List<ListInvoiceHeader>? detail;

  ListClass({this.detail});

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
    detail: List<ListInvoiceHeader>.from(
      json["detail"] == null
          ? []
          : json["detail"].map((x) => ListInvoiceHeader.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "detail": List<dynamic>.from(detail?.map((x) => x.toJson()) ?? []),
  };
}

class ListInvoiceHeader {
  String? binghanId;
  int? discount;
  int? id;
  int? invoiceDate;
  String? invoiceDateFormated;
  int? invoiceMultiId;
  String? invoiceNo;
  int? memberId;
  String? name;
  int? ppn;
  int? subTotal;
  int? total;

  ListInvoiceHeader({
    this.discount,
    this.id,
    this.binghanId,
    this.invoiceDate,
    this.invoiceMultiId,
    this.invoiceNo,
    this.memberId,
    this.name,
    this.ppn,
    this.subTotal,
    this.total,
    this.invoiceDateFormated,
  });

  factory ListInvoiceHeader.fromJson(Map<String, dynamic> json) =>
      ListInvoiceHeader(
        discount: json["discount"],
        id: json["id"],
        binghanId: json["binghan_id"],
        invoiceDate: json["invoice_date"],
        invoiceMultiId: json["invoice_multi_id"],
        invoiceNo: json["invoice_no"],
        memberId: json["member_id"],
        name: json["name"],
        ppn: json["ppn"],
        subTotal: json["sub_total"],
        total: json["total"],
        invoiceDateFormated: formatDate(
          DateTime.fromMillisecondsSinceEpoch(json["invoice_date"] * 1000),
          [d, " ", M, " ", yyyy, ", ", hh, ":", mm],
        ),
      );

  Map<String, dynamic> toJson() => {
    "binghan_id": binghanId,
    "discount": discount,
    "id": id,
    "invoice_date": invoiceDate,
    "invoice_multi_id": invoiceMultiId,
    "invoice_no": invoiceNo,
    "member_id": memberId,
    "name": name,
    "ppn": ppn,
    "sub_total": subTotal,
    "total": total,
  };
}
