import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/api_delete.dart';
import 'package:binghan_mobile/_services/api_get.dart';
import 'package:binghan_mobile/_services/api_put.dart';
import 'package:binghan_mobile/models/cart.dart';
import 'package:binghan_mobile/models/res_api.dart';

import 'api_post.dart';

class CartServices {
  final ApiPost _apiPost = locator<ApiPost>();
  final ApiGet _apiGet = locator<ApiGet>();
  final ApiDelete _apiDelete = locator<ApiDelete>();
  final ApiPut _apiPut = locator<ApiPut>();

  int _cartBadgeCounter = 0;
  int _subWeight = 0;
  int _subTotal = 0;
  int _subDiscount = 0;
  int _popDiscount = 0;
  bool _checkAll = true;
  bool _isNull = false;
  List<ListCart> _listCart = [];
  int _subDisAmt = 0;

  int get cartBadgeCounter => _cartBadgeCounter;
  int get subTotal => _subTotal;
  int get subWeight => _subWeight;
  // double get ppn => _ppn;
  int get subDiscount => _subDiscount;
  List<ListCart> get cartList => _listCart;
  bool get checkAll => _checkAll;
  bool get isNull => _isNull;
  int get popDiscount => _popDiscount;
  int get subDisAmt => _subDisAmt;

  void incrementCartBadgeCounter() {
    _cartBadgeCounter++;
  }

  Future<ResApi> addToCart(Map<String, dynamic> data) async {
    var res = await _apiPost.addToCart(data);
    countSubTotal();
    getCartList(data["member_order"]);
    return res;
  }

  void initPaymentView() {
    // _subDiscount = 0;
    countSubTotal(amountDisc: _subDisAmt);
  }

  void addSubDiscount(int amount) {
    _subDisAmt = amount;
    countSubTotal(amountDisc: amount);
  }

  Future getCartList(int? id) async {
    if (id == null) return;

    var res = await _apiGet.getCartList(id);
    if (res.code == 200) {
      _listCart = [];

      for (var cart in res.data?.list ?? []) {
        ListCart suggest = cart;
        _listCart.add(suggest);
      }
      _cartBadgeCounter = res.data?.total ?? 0;

      if (_cartBadgeCounter > 0) {
        _checkAll = true;
        _isNull = false;
      }
    }
    countSubTotal();
  }

  void checkOnceCart(int id) {
    _checkAll = false;
    var check = _listCart.firstWhere((listCarts) => listCarts.id == id).checked;
    _listCart.firstWhere((listCarts) => listCarts.id == id).checked =
        check ?? false;
    counterNullCheck();
    countSubTotal();
  }

  Future<ResApi> deleteOnceCart(int id) async {
    var res = await _apiDelete.deleteCartItem(id);
    if (res.code == 200) {
      int index = _listCart.indexWhere((listCarts) => listCarts.id == id);
      _listCart.removeAt(index);
    }
    counterNullCheck();
    countSubTotal();
    return res;
  }

  Future editOnceCart(int id, int ope) async {
    var qty = _listCart.firstWhere((listCarts) => listCarts.id == id).orderQty;
    if (ope < 0 && (qty ?? 0) <= 1) {
      return false;
    } else {
      print(id);
      Map<String, dynamic> data = {"order_qty": (qty = (qty ?? 0) + ope)};
      var res = await _apiPut.editCart(id, data);
      if (res.code == 200) {
        _listCart.firstWhere((listCarts) => listCarts.id == id).orderQty =
            data["order_qty"];
      }
    }
    countSubTotal();
  }

  void checkAllCart() {
    _checkAll = !_checkAll;

    for (var cart in _listCart) {
      cart.checked = _checkAll;
    }

    counterNullCheck();
    countSubTotal();
  }

  void counterNullCheck() {
    var res = _listCart.where((listCarts) => listCarts.checked == true).length;
    if (res == 0) {
      _isNull = true;
    } else {
      _isNull = false;
    }
  }

  void countSubTotal({int amountDisc = 0}) {
    _subTotal = 0;
    _subWeight = 0;
    _subDiscount = 0 + amountDisc;
    _popDiscount = 0;
    // _ppn = 0;
    for (var cart in _listCart) {
      if (cart.checked == true) {
        _subTotal += ((cart.itemPrice ?? 0) * (cart.orderQty ?? 0));
        _subWeight += ((cart.items?.weight ?? 0) * (cart.orderQty ?? 0));
        _popDiscount += ((cart.popDis ?? 0) * (cart.orderQty ?? 0));
        _subDiscount += ((cart.popDis ?? 0) * (cart.orderQty ?? 0));
        // _ppn +=
        //     ((cart.itemPrice * cart.orderQty) - cart.popDis) * 0.1;
      }
    }
  }

  void clearAmt() {
    _subDisAmt = 0;
  }
}
