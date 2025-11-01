class Member {
  int code;
  String msg;
  Data? data;

  Member({required this.code, required this.msg, this.data});

  factory Member.fromJson(Map<String, dynamic> json) => Member(
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
  List<ListMember>? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListMember>.from(
      json["list"].map((x) => ListMember.fromJson(x)),
    ),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
    "total": total,
  };
}

class ListMember {
  int? id;
  String? email;
  String? binghanId;
  String? firstName;
  String? lastName;

  ListMember({
    this.id,
    this.email,
    this.binghanId,
    this.firstName,
    this.lastName,
  });

  factory ListMember.fromJson(Map<String, dynamic> json) => ListMember(
    id: json["id"],
    email: json["email"],
    binghanId: json["binghan_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "binghan_id": binghanId,
    "first_name": firstName,
    "last_name": lastName,
  };
}
