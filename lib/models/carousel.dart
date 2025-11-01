class Carousel {
  int code;
  String msg;
  Data? data;

  Carousel({required this.code, required this.msg, this.data});

  factory Carousel.fromJson(Map<String, dynamic> json) => Carousel(
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
  List<ListCarousel>? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListCarousel>.from(
      json["list"].map((x) => ListCarousel.fromJson(x)),
    ),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
    "total": total,
  };
}

class ListCarousel {
  int? id;
  int? createdOn;
  int? modifiedOn;
  String? name;
  String? fotoUrl;

  ListCarousel({
    this.id,
    this.createdOn,
    this.modifiedOn,
    this.name,
    this.fotoUrl,
  });

  factory ListCarousel.fromJson(Map<String, dynamic> json) => ListCarousel(
    id: json["id"],
    createdOn: json["created_on"],
    modifiedOn: json["modified_on"],
    name: json["name"],
    fotoUrl: json["foto_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_on": createdOn,
    "modified_on": modifiedOn,
    "name": name,
    "foto_url": fotoUrl,
  };
}
