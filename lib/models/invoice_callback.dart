class InvoiceCallback {
  int code;
  String msg;
  ListInvoiceCallback? data;

  InvoiceCallback({required this.code, required this.msg, this.data});

  factory InvoiceCallback.fromJson(Map<String, dynamic> json) =>
      InvoiceCallback(
        code: json["code"],
        msg: json["msg"],
        data: json["code"] != 200
            ? null
            : ListInvoiceCallback.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class ListInvoiceCallback {
  int? nomorInvoice;
  String? urlInvoice;
  String? method;
  int? total;

  ListInvoiceCallback({
    this.nomorInvoice,
    this.urlInvoice,
    this.method,
    this.total,
  });

  factory ListInvoiceCallback.fromJson(Map<String, dynamic> json) =>
      ListInvoiceCallback(
        nomorInvoice: json["Nomor_Invoice"],
        urlInvoice: json["Url_Invoice"],
        method: json["method"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
    "Nomor_Invoice": nomorInvoice,
    "Url_Invoice": urlInvoice,
    "total": total,
  };
}
