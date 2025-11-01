// To parse this JSON data, do
//
//     final invoiceMultiHeader = invoiceMultiHeaderFromJson(jsonString);

import 'dart:convert';

import 'package:date_format/date_format.dart';

InvoiceMultiHeader invoiceMultiHeaderFromJson(String str) =>
    InvoiceMultiHeader.fromJson(json.decode(str));

String invoiceMultiHeaderToJson(InvoiceMultiHeader data) =>
    json.encode(data.toJson());

class InvoiceMultiHeader {
  int code;
  String msg;
  Data? data;

  InvoiceMultiHeader({required this.code, required this.msg, this.data});

  factory InvoiceMultiHeader.fromJson(Map<String, dynamic> json) =>
      InvoiceMultiHeader(
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
  List<ListInvoiceMultiHeader>? list;

  Data({this.list});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: json["list"] == null
        ? null
        : List<ListInvoiceMultiHeader>.from(
            json["list"].map((x) => ListInvoiceMultiHeader.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
  };
}

class ListInvoiceMultiHeader {
  int? id;
  String? invoiceNo;
  String? invoiceDateFormated;
  int? invoiceDate;
  int? memberId;
  int? total;
  String? status;
  String? name;
  String? shippingMethod;
  String? shippingOptions;
  String? invoiceUrl;
  String? nomorResi;
  String? methodType;
  String? methodLogo;
  Duration? sisaWaktu;

  ListInvoiceMultiHeader({
    this.id,
    this.invoiceNo,
    this.invoiceDate,
    this.memberId,
    this.invoiceDateFormated,
    this.total,
    this.status,
    this.name,
    this.shippingMethod,
    this.shippingOptions,
    this.invoiceUrl,
    this.nomorResi,
    this.methodType,
    this.methodLogo,
    this.sisaWaktu,
  });

  factory ListInvoiceMultiHeader.fromJson(Map<String, dynamic> json) =>
      ListInvoiceMultiHeader(
        id: json["id"],
        invoiceNo: json["invoice_no"],
        invoiceDate: json["invoice_date"],
        memberId: json["member_id"],
        total: json["total"],
        invoiceDateFormated: formatDate(
          DateTime.fromMillisecondsSinceEpoch(json["invoice_date"] * 1000),
          [d, " ", M, " ", yyyy, ", ", HH, ":", mm],
        ),
        status: json["status"],
        name: json["name"],
        shippingMethod: json["shipping_method"],
        shippingOptions: json["shipping_options"],
        invoiceUrl: json["invoice_url"],
        nomorResi: json["nomor_resi"],
        methodType: json["method_type"],
        methodLogo: json["method_logo"],
        sisaWaktu:
            Duration(hours: 24) -
            DateTime.now().difference(
              DateTime.fromMillisecondsSinceEpoch(json["invoice_date"] * 1000),
            ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoice_no": invoiceNo,
    "invoice_date": invoiceDate,
    "member_id": memberId,
    "total": total,
    "status": status,
    "name": name,
    "shipping_method": shippingMethod,
    "invoice_url": invoiceUrl,
    "nomor_resi": nomorResi,
    "shipping_options": shippingOptions,
    "method_type": methodType,
    "method_logo": methodLogo,
  };
}
