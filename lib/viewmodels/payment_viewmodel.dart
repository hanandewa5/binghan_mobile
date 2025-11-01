import 'dart:async';

import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/cart_service.dart';
import 'package:binghan_mobile/_services/dialog_service.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/_services/payment_services.dart';
import 'package:binghan_mobile/models/bank.dart';
import 'package:binghan_mobile/models/cart.dart';
import 'package:binghan_mobile/models/city.dart';
import 'package:binghan_mobile/models/confirm_callback.dart';
import 'package:binghan_mobile/models/courier.dart';
import 'package:binghan_mobile/models/courier_service.dart';
import 'package:binghan_mobile/models/district.dart';
import 'package:binghan_mobile/models/province.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:binghan_mobile/models/warehouse.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';
// import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;

class PaymentViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PaymentService _paymentService = locator<PaymentService>();
  final MemberService _memberService = locator<MemberService>();
  final DialogService _dialogService = locator<DialogService>();
  final CartServices _cartServices = locator<CartServices>();

  List<ListCart> get listCart =>
      _cartServices.cartList.where((list) => list.checked == true).toList();
  int get subWeight => _cartServices.subWeight;

  String? get deliveryMethod => _paymentService.deliveryMethod;
  ListBankChild? get paymentMethod => _paymentService.paymentMethod;
  List<ListCourier> listCourier = [];
  List<ListWarehouse> listWarehouse = [];
  List<ListCourierService> listCourierService = [];
  ListBank listBank = ListBank.fromJson({
    "BCA": [],
    "Manual": [],
    "Xendit": [],
  });
  ListWarehouse? get warehouse => _paymentService.warehouse;
  ListCourier? get courier => _paymentService.courier;
  ListCourierService? get courierService => _paymentService.courierService;
  ListProvince? get province => _paymentService.province;
  ListCity? get city => _paymentService.city;
  ListDistrict? get district => _paymentService.district;
  int get subTotal => _cartServices.subTotal;
  String get btnText => _paymentService.btnText;
  String? get estimateDays => _paymentService.estimateDays;
  int get vDiscount => _paymentService.vDiscount;

  int get totalOngkir => _paymentService.ongkir ?? 0;
  int get handlingCost => _paymentService.handling ?? 0;
  int get subDiscount => _cartServices.subDiscount;
  int get popDiscount => _cartServices.popDiscount;
  // double get ppn => _cartServices.ppn;
  KonfirmCallbackData? get kcData => _paymentService.konfirmCallbackData;

  bool isProvince = true;
  bool isCity = true;
  bool isDistrict = true;

  String get isExpanded => _paymentService.isExpanded;

  TextEditingController get kelurahan => _paymentService.kelurahan;
  TextEditingController get fullAddress => _paymentService.fullAddress;
  TextEditingController get postCode => _paymentService.postCode;

  void init() {
    load();
    // setAddress();
    // getWarehouse();
    _paymentService.init();
  }

  void initCourier() {
    getCourier();
  }

  void initPayment() {
    getBank();
    _cartServices.initPaymentView();
    _paymentService.initPaymentView();
  }

  void initCount() {
    // startTimer();
  }

  Future load() async {
    setBusy(true);
    User userData = _memberService.userData;

    _paymentService.setProvince(
      ListProvince.fromJson({"province": userData.propinsi}),
    );
    _paymentService.setCity(ListCity.fromJson({"city_name": userData.kota}));
    _paymentService.setDistrict(
      ListDistrict.fromJson({
        "subdistrict_id": userData.kecamatanId,
        "subdistrict_name": userData.kecamatan,
      }),
    );
    kelurahan.text = userData.kelurahan ?? '';
    fullAddress.text = userData.alamatRumah ?? '';
    postCode.text = userData.kodePos ?? '';
    await Future.delayed(Duration(seconds: 1), () {
      setBusy(false);
    });
  }

  void setCourier(ListCourier couriers) {
    _paymentService.setCourier(couriers);
    getCourierService();
    refresh();
  }

  void setCourierService(ListCourierService courierService) {
    _paymentService.setCourierService(courierService);
    refresh();
  }

  void setProvince(ListProvince listProvince) {
    _paymentService.setProvince(listProvince);
    _paymentService.setCity(null);
    _paymentService.setDistrict(null);
    refresh();
  }

  void setCity(ListCity listCity) {
    _paymentService.setCity(listCity);
    _paymentService.setDistrict(null);
    refresh();
  }

  void setDistrict(ListDistrict listDistrict) {
    _paymentService.setDistrict(listDistrict);
  }

  void setWarehouse(ListWarehouse listWarehouse) {
    _paymentService.setWarehouse(listWarehouse);
  }

  Future setPaymentMethod(ListBankChild listBankChild) async {
    Map<String, List> data = {
      "order_details": <Map<String, dynamic>>[],
      "payment_method": <Map<String, dynamic>>[],
    };

    for (var cart in listCart) {
      Map<String, dynamic> added = {
        "item_id": cart.itemId,
        "order_for": cart.orderFor,
        "qty": cart.orderQty,
      };
      (data["order_details"] as List).add(added);
    }
    (data["payment_method"] as List).add({
      "payment_method_id": listBankChild.id,
    });

    var res = await _paymentService.setPaymentMethod(listBankChild, data);
    _paymentService.setVDiscount(res * -1);
    _cartServices.addSubDiscount(res * -1);
    refresh();
  }

  void setExpanded(String label) {
    _paymentService.setExpanded(label);
    refresh();
  }

  Future getCourier() async {
    setBusy(true);
    var res = await _paymentService.getCourier();
    if (res.code == 200 && res.data?.list != null) {
      for (var i = 0; i < res.data!.list!.length; i++) {
        ListCourier suggest = res.data!.list![i];
        listCourier.add(suggest);
      }
    }
    setBusy(false);
  }

  Future getCourierService() async {
    listCourierService.clear();
    Map<String, dynamic> data = {
      "courier": _paymentService.courier?.code,
      "destination": _paymentService.district?.subdistrictId,
      "destinationType": "subdistrict",
      "origin": _paymentService.warehouse?.kecamatanId,
      "origintype": "subdistrict",
      "weight": subWeight,
    };
    setBusy(true);
    var res = await _paymentService.getCourierService(data);
    if (res.code == 200 &&
        res.data?.list != null &&
        res.data!.list!.isNotEmpty &&
        res.data!.list![0].costs != null) {
      for (var i = 0; i < res.data!.list![0].costs!.length; i++) {
        ListCourierService suggest = res.data!.list![0].costs![i];
        listCourierService.add(suggest);
      }
    }
    setBusy(false);
  }

  Future getWarehouse() async {
    var res = await _paymentService.getWarehouse();
    if (res.code == 200 && res.data?.list != null) {
      for (var i = 0; i < res.data!.list!.length; i++) {
        ListWarehouse suggest = res.data!.list![i];
        listWarehouse.add(suggest);
      }
    }
  }

  Future getBank() async {
    setScreenLoad(true);
    var res = await _paymentService.getBank();
    setScreenLoad(false);
    if (res.code == 200 && res.data?.list != null) {
      listBank = res.data!.list!;
    }
  }

  int getTotal() {
    double res = subTotal.toDouble();
    // print(res);
    res += deliveryMethod == "Antar" ? handlingCost : 0;
    return res.toInt();
  }

  int getSubTotal() {
    double res = subTotal.toDouble() - subDiscount;
    // print(res);
    res += deliveryMethod == "Antar" ? handlingCost : 0;
    return res.toInt();
  }

  int getGrandTotal() {
    double res = subTotal.toDouble() - subDiscount;
    res = res + ((res += deliveryMethod == "Antar" ? handlingCost : 0) * 0.11);
    if (deliveryMethod == "Antar") res = res + totalOngkir + handlingCost;
    // print(subDiscount);
    return res.toInt();
  }

  int getPPN() {
    double res = handlingCost + subTotal.toDouble() - subDiscount;
    res *= 0.11;
    return res.toInt();
  }

  Future<List<ListProvince>> getProvince(String filter) async {
    List<ListProvince> provinces = [];
    var res = await _memberService.getProvince(filter.trim());

    if (res.data?.list != null) {
      for (var i = 0; i < res.data!.list!.length; i++) {
        ListProvince suggest = res.data!.list![i];
        provinces.add(suggest);
      }
    }
    return provinces;
  }

  Future<List<ListCity>> getCity(String filter) async {
    List<ListCity> cities = [];
    var res = await _memberService.getCity(province?.provinceId ?? 0, filter);
    if (province?.provinceId != null && res.data?.list != null) {
      for (var i = 0; i < res.data!.list!.length; i++) {
        ListCity suggest = res.data!.list![i];
        cities.add(suggest);
      }
    }
    return cities;
  }

  Future<List<ListDistrict>> getDistrict(String filter) async {
    List<ListDistrict> districts = [];
    var res = await _memberService.getDistrict(city?.cityId ?? 0, filter);
    if (city?.cityId != null && res.data?.list != null) {
      for (var i = 0; i < res.data!.list!.length; i++) {
        ListDistrict suggest = res.data!.list![i];
        districts.add(suggest);
      }
    }
    return districts;
  }

  void setCaraPengiriman(String item) {
    _paymentService.setDeliveryMethod(item);
    refresh();
  }

  void clickToCopy(BuildContext context, String text) {
    // ClipboardManager.copyToClipBoard(text).then((result) {
    //   final snackBar = SnackBar(
    //     content: Text('Copied to Clipboard'),
    //     action: SnackBarAction(
    //       label: 'OK',
    //       onPressed: () {},
    //     ),
    //   );
    //   Scaffold.of(context).showSnackBar(snackBar);
    // });
  }

  Future confirm() async {
    User userData = _memberService.userData;

    List<Map<String, dynamic>> orderDetails = [];
    List<Map<String, dynamic>> paymentMethodList = [
      {"payment_method_id": paymentMethod?.id},
    ];

    for (var order in listCart) {
      Map<String, dynamic> parsed = {
        "item_id": order.itemId,
        "order_for": order.orderFor,
        "qty": order.orderQty,
      };
      orderDetails.add(parsed);
    }

    Map<String, dynamic> data = {
      "alamat_rumah": fullAddress.text,
      "kecamatan_id": district?.subdistrictId,
      "kelurahan": kelurahan.text,
      "kode_pos": postCode.text,
      "member_id": userData.id,
      "order_details": orderDetails,
      "payment_method": paymentMethodList,
      "shipping_method": deliveryMethod == "Antar"
          ? courier?.code
          : deliveryMethod?.toLowerCase(),
      "shipping_options": deliveryMethod == "Antar"
          ? courierService?.service
          : deliveryMethod,
      "warehouse_id": warehouse?.id,
    };

    // print(json.encode(data));
    if (orderDetails.isNotEmpty) {
      setBusy(true);
      var res = await _paymentService.confirmInvoice(data);
      setBusy(false);
      if (res.code == 200) {
        // await _cartServices.getCartList(userData.id);
        await _navigationService.navigateTo(routes.ConfirmPaymentRoute);
      } else {
        _dialogService.showDialog(title: "Perhatian !", descs: res.msg);
      }
    }
  }

  Future pay() async {
    User userData = _memberService.userData;

    List<Map<String, dynamic>> orderDetails = [];
    List<Map<String, dynamic>> paymentMethodList = [
      {"payment_method_id": paymentMethod?.id},
    ];

    for (var order in listCart) {
      Map<String, dynamic> parsed = {
        "item_id": order.itemId,
        "order_for": order.orderFor,
        "qty": order.orderQty,
      };
      orderDetails.add(parsed);
    }

    Map<String, dynamic> data = {
      "alamat_rumah": fullAddress.text,
      "kecamatan_id": district?.subdistrictId,
      "kelurahan": kelurahan.text,
      "kode_pos": postCode.text,
      "member_id": userData.id,
      "order_details": orderDetails,
      "payment_method": paymentMethodList,
      "shipping_method": deliveryMethod == "Antar"
          ? courier?.code
          : deliveryMethod?.toLowerCase(),
      "shipping_options": deliveryMethod == "Antar"
          ? courierService?.service
          : deliveryMethod,
      "warehouse_id": warehouse?.id,
    };

    // print(json.encode(data));
    if (orderDetails.isNotEmpty) {
      setBusy(true);
      var res = await _paymentService.saveInvoice(data);
      // print(json.encode(res));
      setBusy(false);
      if (res.code == 200) {
        await _cartServices.getCartList(userData.id);
        await _navigationService.navigateTo(routes.CountDownRoute);
      } else {
        _dialogService.showDialog(title: "Perhatian !", descs: res.msg);
      }
    }
  }

  void goToPaymentOrCourier() async {
    if (deliveryMethod == "Ambil Ditempat") {
      await _navigationService.navigateTo(routes.PaymentRoute);
    } else if (deliveryMethod == "Antar") {
      await _navigationService.navigateTo(routes.CourierRoute);
    }
  }

  void goToPayment() async {
    if (deliveryMethod != null) {
      await _navigationService.navigateTo(routes.PaymentRoute);
    }
  }

  void goToInvoice() async {
    await _navigationService.navigateTo(routes.PaymentDetailRoute);
  }

  void goToCountDown() async {
    await _navigationService.navigateTo(routes.CountDownRoute);
  }
}
