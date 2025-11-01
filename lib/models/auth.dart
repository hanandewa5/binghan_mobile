class Auth {
  int code;
  String msg;
  Data? data;

  Auth({required this.code, required this.msg, required this.data});

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    code: json["code"],
    msg: json["msg"],
    data: (json["code"] != 200) ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  dynamic me;
  String? token;

  Data({this.me, this.token});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(me: json["me"], token: json["token"]);

  Map<String, dynamic> toJson() => {"id": me, "token": token};
}
