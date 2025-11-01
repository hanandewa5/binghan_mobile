class ResApi {
  int code;
  String msg;
  dynamic data;

  ResApi({
    required this.code,
    required this.msg,
    this.data,
  });

  ResApi.initial()
      : code = 200,
        msg = "";

  factory ResApi.fromJson(Map<String, dynamic> json) => ResApi(
        code: json["code"],
        msg: json["msg"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data,
      };
}