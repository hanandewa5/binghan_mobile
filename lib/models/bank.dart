class Bank {
  int code;
  String msg;
  Data? data;

  Bank({required this.code, required this.msg, this.data});

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
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
  ListBank? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(list: ListBank.fromJson(json["list"]), total: json["total"]);

  Map<String, dynamic> toJson() => {"list": list?.toJson(), "total": total};
}

class ListBank {
  List<ListBankChild>? bca;
  List<ListBankChild>? xendit;

  ListBank({this.bca, this.xendit});

  factory ListBank.fromJson(Map<String, dynamic> json) => ListBank(
    bca: List<ListBankChild>.from(
      json["BCA"]?.map((x) => ListBankChild.fromJson(x)),
    ),
    xendit: List<ListBankChild>.from(
      json["Xendit"]?.map((x) => ListBankChild.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "BCA": List<dynamic>.from(bca?.map((x) => x.toJson()) ?? []),
    "Xendit": List<dynamic>.from(xendit?.map((x) => x.toJson()) ?? []),
  };
}

class ListBankChild {
  int id;
  int paymentGroupId;
  String name;
  String bankName;
  String nomorRekening;
  String logoUrl;
  String methodType;
  bool activeOnMobile;
  bool activeOnBo;

  ListBankChild({
    required this.id,
    required this.paymentGroupId,
    required this.name,
    required this.bankName,
    required this.nomorRekening,
    required this.logoUrl,
    required this.methodType,
    required this.activeOnMobile,
    required this.activeOnBo,
  });

  factory ListBankChild.fromJson(Map<String, dynamic> json) => ListBankChild(
    id: json["id"],
    paymentGroupId: json["payment_group_id"],
    name: json["name"],
    bankName: json["bank_name"],
    nomorRekening: json["nomor_rekening"],
    logoUrl: json["logo_url"],
    methodType: json["method_type"],
    activeOnMobile: json["active_on_mobile"],
    activeOnBo: json["active_on_bo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "payment_group_id": paymentGroupId,
    "name": name,
    "bank_name": bankName,
    "nomor_rekening": nomorRekening,
    "logo_url": logoUrl,
    "method_type": methodType,
    "active_on_mobile": activeOnMobile,
    "active_on_bo": activeOnBo,
  };
}
