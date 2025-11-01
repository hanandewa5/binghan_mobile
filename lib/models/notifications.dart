import 'package:date_format/date_format.dart';

class Notifications {
  int code;
  String msg;
  Data? data;

  Notifications({required this.code, required this.msg, this.data});

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
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
  List<ListNotification>? list;

  Data({this.list});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListNotification>.from(
      json["list"].map((x) => ListNotification.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
  };
}

class ListNotification {
  int? id;
  int? createdOn;
  int? modifiedOn;
  bool? isAdmin;
  String? title;
  String? body;
  String? binghanId;
  String? to;
  int? isRead;
  int? isSuccess;
  String? createdOnFormated;

  ListNotification({
    this.id,
    this.createdOn,
    this.modifiedOn,
    this.isAdmin,
    this.title,
    this.body,
    this.binghanId,
    this.to,
    this.isRead,
    this.isSuccess,
    this.createdOnFormated,
  });

  factory ListNotification.fromJson(Map<String, dynamic> json) =>
      ListNotification(
        id: json["id"],
        createdOn: json["created_on"],
        modifiedOn: json["modified_on"],
        isAdmin: json["is_admin"],
        title: json["title"],
        body: json["body"],
        binghanId: json["binghan_id"],
        to: json["to"],
        isRead: json["is_read"],
        isSuccess: json["is_success"],
        createdOnFormated: formatDate(
          DateTime.fromMillisecondsSinceEpoch(json["created_on"] * 1000),
          [d, " ", M, " ", yyyy, ", ", hh, ":", mm, ":", ss],
        ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_on": createdOn,
    "modified_on": modifiedOn,
    "is_admin": isAdmin,
    "title": title,
    "body": body,
    "binghan_id": binghanId,
    "to": to,
    "is_read": isRead,
    "is_success": isSuccess,
  };
}
