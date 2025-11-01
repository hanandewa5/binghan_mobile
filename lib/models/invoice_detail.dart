import 'package:binghan_mobile/models/item.dart';
import 'package:binghan_mobile/models/member.dart';
import 'package:date_format/date_format.dart';

class InvoiceDetail {
  int code;
  String msg;
  ListInvoiceDetail? data;

  InvoiceDetail({required this.code, required this.msg, this.data});

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) => InvoiceDetail(
    code: json["code"],
    msg: json["msg"],
    data: json["code"] != 200 ? null : ListInvoiceDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class ListInvoiceDetail {
  String? alamatRumah;
  List<Detail>? detail;
  int? discount;
  int? id;
  int? invoiceDate;
  String? invoiceDateFormated;
  String? invoiceNo;
  String? kecamatan;
  int? kecamatanId;
  String? kelurahan;
  String? kodePos;
  String? kota;
  ListMember? member;
  String? nomorResi;
  dynamic ppn;
  int? ppnTotal2;
  String? propinsi;
  int? shippingCost;
  String? shippingMethod;
  String? shippingOptions;
  String? status;
  int? subTotal;
  dynamic total;
  dynamic weightTotal;
  dynamic total1;
  dynamic total2;
  dynamic total3;
  int? totalPopDiscount;
  int? totalVoucher;
  int? handlingFee;
  int? totalBarang;

  ListInvoiceDetail({
    this.alamatRumah,
    this.detail,
    this.discount,
    this.id,
    this.invoiceDate,
    this.invoiceDateFormated,
    this.invoiceNo,
    this.kecamatan,
    this.kecamatanId,
    this.kelurahan,
    this.kodePos,
    this.kota,
    this.member,
    this.nomorResi,
    this.ppn,
    this.ppnTotal2,
    this.propinsi,
    this.shippingCost,
    this.shippingMethod,
    this.shippingOptions,
    this.status,
    this.subTotal,
    this.total,
    this.weightTotal,
    this.total1,
    this.total2,
    this.total3,
    this.totalPopDiscount,
    this.totalVoucher,
    this.handlingFee,
    this.totalBarang,
  });

  factory ListInvoiceDetail.fromJson(Map<String, dynamic> json) =>
      ListInvoiceDetail(
        alamatRumah: json["alamat_rumah"],
        detail: json["detail"] == null
            ? []
            : List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
        discount: json["discount"],
        id: json["id"],
        invoiceDate: json["invoice_date"],
        invoiceNo: json["invoice_no"],
        invoiceDateFormated: formatDate(
          DateTime.fromMillisecondsSinceEpoch(json["invoice_date"] * 1000),
          [d, " ", M, " ", yyyy, ", ", hh, ":", mm],
        ),
        kecamatan: json["kecamatan"],
        kecamatanId: json["kecamatan_id"],
        kelurahan: json["kelurahan"],
        kodePos: json["kode_pos"],
        kota: json["kota"],
        member: ListMember.fromJson(json["member"]),
        nomorResi: json["nomor_resi"],
        ppn: json["ppn"],
        propinsi: json["propinsi"],
        shippingCost: json["shipping_cost"],
        shippingMethod: json["shipping_method"],
        shippingOptions: json["shipping_options"],
        status: json["status"],
        subTotal: json["sub_total"],
        total: json["total"],
        weightTotal: json["weight_total"],
        total1: json["total1"],
        total2: json["total2"],
        total3: json["total3"],
        totalPopDiscount: json["total_pop_discount"],
        totalVoucher: json["total_voucher"],
        handlingFee: json["handling_fee"],
        totalBarang: json["total_barang"],
        ppnTotal2: json["ppn_total2"].toInt(),
      );

  Map<String, dynamic> toJson() => {
    "alamat_rumah": alamatRumah,
    "detail": List<dynamic>.from(detail?.map((x) => x.toJson()) ?? []),
    "discount": discount,
    "id": id,
    "invoice_date": invoiceDate,
    "invoice_no": invoiceNo,
    "kecamatan": kecamatan,
    "kecamatan_id": kecamatanId,
    "kelurahan": kelurahan,
    "kode_pos": kodePos,
    "kota": kota,
    "member": member?.toJson(),
    "nomor_resi": nomorResi,
    "ppn": ppn,
    "propinsi": propinsi,
    "shipping_cost": shippingCost,
    "shipping_method": shippingMethod,
    "shipping_options": shippingOptions,
    "status": status,
    "sub_total": subTotal,
    "total": total,
    "weight_total": weightTotal,
    "total1": total1,
    "total2": total2,
    "total3": total3,
    "total_pop_discount": totalPopDiscount,
    "total_voucher": totalVoucher,
    "handlingFee": handlingFee,
    "ppn_total2": ppnTotal2,
    "total_barang": totalBarang,
  };
}

class Detail {
  int? amount;
  int? id;
  ListProductItem? item;
  ListMember? orderFor;
  int? qty;

  Detail({this.amount, this.id, this.item, this.orderFor, this.qty});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    amount: json["amount"],
    id: json["id"],
    item: ListProductItem.fromJson(json["item"]),
    orderFor: ListMember.fromJson(json["order_for"]),
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "id": id,
    "item": item?.toJson(),
    "order_for": orderFor?.toJson(),
    "qty": qty,
  };
}

class OrderFor {
  String? binghanId;
  String? firstName;
  int? id;
  String? lastName;

  OrderFor({this.binghanId, this.firstName, this.id, this.lastName});

  factory OrderFor.fromJson(Map<String, dynamic> json) => OrderFor(
    binghanId: json["binghan_id"],
    firstName: json["first_name"],
    id: json["id"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "binghan_id": binghanId,
    "first_name": firstName,
    "id": id,
    "last_name": lastName,
  };
}
