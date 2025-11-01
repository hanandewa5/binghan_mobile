import 'package:binghan_mobile/models/item.dart';
import 'package:binghan_mobile/models/member.dart';

class Cart {
  int code;
  String msg;
  Data? data;

  Cart({required this.code, required this.msg, this.data});

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    code: json["code"],
    msg: json["msg"],
    data: (json["code"] == 200) ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  List<ListCart>? list;
  int? total;

  Data({this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListCart>.from(json["list"].map((x) => ListCart.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list?.map((x) => x.toJson()) ?? []),
    "total": total,
  };
}

class ListCart {
  int? id;
  bool? checked;
  int? memberOrder;
  int? orderId;
  int? itemId;
  int? itemPrice;
  int? orderQty;
  int? orderFor;
  int? popDis;
  ListMember? member;
  ListProductItem? items;

  ListCart({
    this.id,
    this.memberOrder,
    this.orderId,
    this.itemId,
    this.itemPrice,
    this.orderQty,
    this.orderFor,
    this.checked,
    this.popDis,
    this.member,
    this.items,
  });

  factory ListCart.fromJson(Map<String, dynamic> json) => ListCart(
    id: json["id"],
    checked: true,
    memberOrder: json["member_order"],
    orderId: json["order_id"],
    itemId: json["item_id"],
    itemPrice: json["item_price"],
    orderQty: json["order_qty"],
    orderFor: json["order_for"],
    popDis: json["pop_dis"],
    member: ListMember.fromJson(json["members"]),
    items: ListProductItem.fromJson(json["items"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "checked": checked,
    "member_order": memberOrder,
    "order_id": orderId,
    "item_id": itemId,
    "item_price": itemPrice,
    "order_qty": orderQty,
    "order_for": orderFor,
    "pop_dis": popDis,
    "items": items?.toJson(),
  };
}
