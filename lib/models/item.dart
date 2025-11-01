class Item {
  int code;
  String msg;
  Data? data;

  Item({required this.code, required this.msg, this.data});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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
  List<ListProductItem>? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListProductItem>.from(
      json["list"].map((x) => ListProductItem.fromJson(x)),
    ),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
    "total": total,
  };
}

class ListProductItem {
  int? id;
  String? imageUrl;
  String? name;
  int? price;
  int? weight;
  String? specification;
  int? popDiscount;

  ListProductItem({
    this.id,
    this.imageUrl,
    this.name,
    this.price,
    this.weight,
    this.specification,
    this.popDiscount,
  });

  factory ListProductItem.fromJson(Map<String, dynamic> json) =>
      ListProductItem(
        id: json["id"],
        imageUrl: json["image_url"],
        name: json["name"],
        price: json["price"],
        weight: json["weight"],
        specification: json["specification"],
        popDiscount: json["pop_discount"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "name": name,
    "price": price,
    "weight": weight,
    "specification": specification,
    "pop_discount": popDiscount,
  };
}
