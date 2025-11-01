import 'package:date_format/date_format.dart';

class Bonus {
  int code;
  String msg;
  Data? data;

  Bonus({required this.code, required this.msg, required this.data});

  factory Bonus.fromJson(Map<String, dynamic> json) => Bonus(
    code: json["code"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  List<ListBonus>? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListBonus>.from(json["list"].map((x) => ListBonus.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
    "total": total,
  };
}

class ListBonus {
  int id;
  int createdOn;
  int modifiedOn;
  bool isAdmin;
  String binghanId;
  String bulan;
  String bulanFormated;
  int bonus;
  int pajak;
  int? jumlahDiTransfer;
  String diTransferKe;

  ListBonus({
    required this.id,
    required this.createdOn,
    required this.modifiedOn,
    required this.isAdmin,
    required this.binghanId,
    required this.bulan,
    required this.bonus,
    required this.pajak,
    this.jumlahDiTransfer,
    required this.diTransferKe,
    required this.bulanFormated,
  });

  factory ListBonus.fromJson(Map<String, dynamic> json) {
    String yearMonth = json["bulan"];
    int year = int.parse(yearMonth.substring(0, 4));
    int month = int.parse(yearMonth.substring(4, 6));
    return ListBonus(
      id: json["id"],
      createdOn: json["created_on"],
      modifiedOn: json["modified_on"],
      isAdmin: json["is_admin"],
      binghanId: json["binghan_id"],
      bulan: json["bulan"],
      bulanFormated: formatDate(DateTime(year, month), [M, " ", yyyy]),
      bonus: json["bonus"],
      pajak: json["pajak"],
      jumlahDiTransfer: json["jumlah_di_transfer"],
      diTransferKe: json["di_transfer_ke"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_on": createdOn,
    "modified_on": modifiedOn,
    "is_admin": isAdmin,
    "binghan_id": binghanId,
    "bulan": bulan,
    "bonus": bonus,
    "pajak": pajak,
    "jumlah_di_transfer": jumlahDiTransfer,
    "di_transfer_ke": diTransferKe,
  };
}
