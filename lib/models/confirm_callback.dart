class KonfirmCallback {
  int code;
  String msg;
  KonfirmCallbackData? data;

  KonfirmCallback({required this.code, required this.msg, this.data});

  factory KonfirmCallback.fromJson(Map<String, dynamic> json) =>
      KonfirmCallback(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] != null
            ? KonfirmCallbackData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class KonfirmCallbackData {
  int? discount;
  int? grandTotal;
  int? handlingFree;
  List<ListConfirmCallback>? orderDetail;
  int? ppn;
  int? shippingCost;
  int? total;
  int? weight;

  KonfirmCallbackData({
    this.discount,
    this.grandTotal,
    this.handlingFree,
    this.orderDetail,
    this.ppn,
    this.shippingCost,
    this.total,
    this.weight,
  });

  factory KonfirmCallbackData.fromJson(Map<String, dynamic> json) =>
      KonfirmCallbackData(
        discount: json["discount"],
        grandTotal: json["grand_total"],
        handlingFree: json["handling_free"],
        orderDetail: List<ListConfirmCallback>.from(
          json["order_detail"].map((x) => ListConfirmCallback.fromJson(x)),
        ),
        ppn: json["ppn"],
        shippingCost: json["shipping_cost"],
        total: json["total"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
    "discount": discount,
    "grand_total": grandTotal,
    "handling_free": handlingFree,
    "order_detail": List<dynamic>.from(
      orderDetail?.map((x) => x.toJson()) ?? [],
    ),
    "ppn": ppn,
    "shipping_cost": shippingCost,
    "total": total,
    "weight": weight,
  };
}

class ListConfirmCallback {
  String? binghanId;
  int? discount;
  int? id;
  List<KonfirmCallbackItemList>? itemList;
  String? name;
  int? ppn;
  int? total;

  ListConfirmCallback({
    this.binghanId,
    this.discount,
    this.id,
    this.itemList,
    this.name,
    this.ppn,
    this.total,
  });

  factory ListConfirmCallback.fromJson(Map<String, dynamic> json) =>
      ListConfirmCallback(
        binghanId: json["binghan_id"],
        discount: json["discount"],
        id: json["id"],
        itemList: List<KonfirmCallbackItemList>.from(
          json["item_list"].map((x) => KonfirmCallbackItemList.fromJson(x)),
        ),
        name: json["name"],
        ppn: json["ppn"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
    "binghan_id": binghanId,
    "discount": discount,
    "id": id,
    "item_list": List<dynamic>.from(itemList?.map((x) => x.toJson()) ?? []),
    "name": name,
    "ppn": ppn,
    "total": total,
  };
}

class KonfirmCallbackItemList {
  int? id;
  String? name;
  int? popDiscount;
  int? price;
  int? qty;
  int? subttlDiscount;
  int? subttlPrice;

  KonfirmCallbackItemList({
    this.id,
    this.name,
    this.popDiscount,
    this.price,
    this.qty,
    this.subttlDiscount,
    this.subttlPrice,
  });

  factory KonfirmCallbackItemList.fromJson(Map<String, dynamic> json) =>
      KonfirmCallbackItemList(
        id: json["id"],
        name: json["name"],
        popDiscount: json["pop_discount"],
        price: json["price"],
        qty: json["qty"],
        subttlDiscount: json["subttl_discount"],
        subttlPrice: json["subttl_price"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "pop_discount": popDiscount,
    "price": price,
    "qty": qty,
    "subttl_discount": subttlDiscount,
    "subttl_price": subttlPrice,
  };
}
