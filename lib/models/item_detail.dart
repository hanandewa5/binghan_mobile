class ItemDetail {
  int code;
  String msg;
  Data? data;

  ItemDetail({required this.code, required this.msg, this.data});

  factory ItemDetail.fromJson(Map<String, dynamic> json) => ItemDetail(
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
  ListProductItemDetail? itemDetail;
  int? total;

  Data({this.itemDetail, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    itemDetail: ListProductItemDetail.fromJson(json["list"][0]),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "item_detail": itemDetail?.toJson(),
    "total": total,
  };
}

class ListProductItemDetail {
  int? id;
  String? imageUrl;
  String? name;
  int? price;
  int? weight;
  String? specification;
  int? popDiscount;
  int? createdOn;
  int? modifiedOn;
  int? stockAvailable;

  ListProductItemDetail({
    this.id,
    this.imageUrl,
    this.name,
    this.price,
    this.weight,
    this.specification,
    this.popDiscount,
    this.createdOn,
    this.modifiedOn,
    this.stockAvailable,
  });

  factory ListProductItemDetail.fromJson(Map<String, dynamic> json) =>
      ListProductItemDetail(
        id: json["id"],
        imageUrl: json["image_url"],
        name: json["name"],
        price: json["price"],
        weight: json["weight"],
        specification: json["specification"],
        popDiscount: json["pop_discount"],
        stockAvailable: json["stock_available"],
        createdOn: json["created_on"],
        modifiedOn: json["modified_on"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "name": name,
    "price": price,
    "weight": weight,
    "specification": specification,
    "pop_discount": popDiscount,
    "created_on": createdOn,
    "modified_on": modifiedOn,
    "stock_available": stockAvailable,
  };
}
