class MemberPv {
  int code;
  String msg;
  Data? data;

  MemberPv({required this.code, required this.msg, this.data});

  factory MemberPv.fromJson(Map<String, dynamic> json) => MemberPv(
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
  int? count;
  List<ListMemberPV>? list;

  Data({this.count, this.list});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    count: json["count"],
    list: List<ListMemberPV>.from(
      json["list"].map((x) => ListMemberPV.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
  };
}

class ListMemberPV {
  int? id;
  String? binghanId;
  String? firstName;
  int? availableTransfer;

  ListMemberPV({
    this.id,
    this.binghanId,
    this.firstName,
    this.availableTransfer,
  });

  factory ListMemberPV.fromJson(Map<String, dynamic> json) => ListMemberPV(
    id: json["id"],
    binghanId: json["binghan_id"],
    firstName: json["first_name"],
    availableTransfer: json["available_transfer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "binghan_id": binghanId,
    "first_name": firstName,
    "available_transfer": availableTransfer,
  };
}
