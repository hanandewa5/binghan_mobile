class Downline {
  int code;
  String msg;
  Data? data;

  Downline({required this.code, required this.msg, this.data});

  factory Downline.fromJson(Map<String, dynamic> json) => Downline(
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
  List<ListDownline>? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListDownline>.from(
      json["list"].map((x) => ListDownline.fromJson(x)),
    ),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
    "total": total,
  };
}

class ListDownline {
  int? id;
  String? binghanId;
  String? firstName;
  String? lastName;
  String? photoUrl;
  String? namaSponsor;
  String? sponsorBinghanId;
  String? status;

  ListDownline({
    this.id,
    this.binghanId,
    this.firstName,
    this.lastName,
    this.photoUrl,
    this.namaSponsor,
    this.sponsorBinghanId,
    this.status,
  });

  factory ListDownline.fromJson(Map<String, dynamic> json) => ListDownline(
    id: json["id"],
    binghanId: json["binghan_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    photoUrl: json["photo_url"],
    namaSponsor: json["nama_sponsor"],
    sponsorBinghanId: json["sponsor_binghan_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "binghan_id": binghanId,
    "first_name": firstName,
    "last_name": lastName,
    "photo_url": photoUrl,
    "nama_sponsor": namaSponsor,
    "sponsor_binghan_id": sponsorBinghanId,
    "status": status,
  };
}
