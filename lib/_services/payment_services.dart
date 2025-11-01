import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/api_post.dart';
import 'package:binghan_mobile/models/bank.dart';
import 'package:binghan_mobile/models/city.dart';
import 'package:binghan_mobile/models/confirm_callback.dart';
import 'package:binghan_mobile/models/courier.dart';
import 'package:binghan_mobile/models/courier_service.dart';
import 'package:binghan_mobile/models/district.dart';
import 'package:binghan_mobile/models/invoice_callback.dart';
import 'package:binghan_mobile/models/province.dart';
import 'package:binghan_mobile/models/warehouse.dart';
import 'package:flutter/material.dart';
import 'api_get.dart';

class PaymentService {
  final ApiGet _apiGet = locator<ApiGet>();
  final ApiPost _apiPost = locator<ApiPost>();

  ListWarehouse? _warehouse;
  String? _deliveryMethod;
  ListBankChild? _paymentMethod;
  ListCourier? _courier;
  ListCourierService? _courierService;
  int _ongkir = 0;
  int _handling = 0;
  int _vDiscount = 0;
  String _estimateDays = "";
  ListProvince? _province;
  ListCity? _city;
  ListDistrict? _district;
  final TextEditingController _kelurahan = TextEditingController();
  final TextEditingController _fullAddress = TextEditingController();
  final TextEditingController _postCode = TextEditingController();
  String _btnText() {
    String string = "Pilih";
    if (_deliveryMethod == "Antar") {
      string = "Pilih Kurir";
    } else if (_deliveryMethod == "Ambil Ditempat") {
      string = "Pilih Pembayaran";
    }

    return string;
  }

  ListInvoiceCallback? _listInvoiceCallback;
  KonfirmCallbackData? _konfirmCallbackData;
  String _isExpanded = "";

  ListWarehouse? get warehouse => _warehouse;
  String? get deliveryMethod => _deliveryMethod;
  ListBankChild? get paymentMethod => _paymentMethod;
  ListCourier? get courier => _courier;
  int? get ongkir => _ongkir;
  int? get handling => _handling;
  String? get estimateDays => _estimateDays;
  ListCourierService? get courierService => _courierService;
  ListProvince? get province => _province;
  ListCity? get city => _city;
  ListDistrict? get district => _district;
  int get vDiscount => _vDiscount;
  TextEditingController get kelurahan => _kelurahan;
  TextEditingController get fullAddress => _fullAddress;
  TextEditingController get postCode => _postCode;
  String get btnText => _btnText();
  ListInvoiceCallback? get listInvoiceCallback => _listInvoiceCallback;
  KonfirmCallbackData? get konfirmCallbackData => _konfirmCallbackData;
  String get isExpanded => _isExpanded;

  void init() {
    _warehouse = ListWarehouse.fromJson({
      "id": 2,
      "name": "Jakarta",
      "kecamatan_id": 2128,
    });
    _deliveryMethod = null;
    _courier = null;
    _paymentMethod = null;
  }

  void initPaymentView() {
    // _paymentMethod = null;
  }

  void setDeliveryMethod(String item) async {
    _deliveryMethod = item;
    _courier = null;
    _courierService = null;
    _ongkir = 0;
    _estimateDays = "";
    // item == "Antar" ? _handling = 11000 : _handling = 0;
    if (item == "Antar") {
      _handling = await getHandlingCost();
    } else {
      _handling = 0;
    }
  }

  void setCourier(ListCourier listCourier) {
    _courier = listCourier;
    _courierService = null;
    _ongkir = 0;
    _estimateDays = "";
  }

  void setCourierService(ListCourierService courierService) {
    _courierService = courierService;
    _ongkir = courierService.cost?[0].value ?? 0;
    _estimateDays = courierService.cost?[0].etd ?? "";
  }

  void setProvince(ListProvince listProvince) {
    _province = listProvince;
    _courierService = null;
    _courier = null;
    _ongkir = 0;
    _estimateDays = "";
  }

  void setCity(ListCity? listCity) {
    _city = listCity;
    _courierService = null;
    _courier = null;
    _ongkir = 0;
    _estimateDays = "";
  }

  void setDistrict(ListDistrict? listDistrict) {
    _district = listDistrict;
    _courierService = null;
    _courier = null;
    _ongkir = 0;
    _estimateDays = "";
  }

  void setWarehouse(ListWarehouse listWarehouse) {
    _warehouse = listWarehouse;
    _courierService = null;
    _courier = null;
    _ongkir = 0;
    _estimateDays = "";
  }

  void setExpanded(String label) {
    if (_isExpanded == "" || _isExpanded != label) {
      _isExpanded = label;
    } else {
      _isExpanded = "";
    }
  }

  void setVDiscount(int value) {
    _vDiscount = value;
  }

  Future<int> setPaymentMethod(
    ListBankChild listBankChild,
    Map<String, dynamic> data,
  ) async {
    int discount = 0;
    var res = await _apiPost.calcBonus(data);
    if (res.code == 200) {
      discount = res.data["List"]["total_promo"];
    }
    _paymentMethod = listBankChild;

    return discount;
  }

  Future<Courier> getCourier() async {
    var res = await _apiGet.getCourier();
    return res;
  }

  Future<int> getHandlingCost() async {
    var res = await _apiGet.getHandlingCost();
    return res.data["price"];
  }

  Future<Warehouse> getWarehouse() async {
    var res = await _apiGet.getWarehouse();
    return res;
  }

  Future<Bank> getBank() async {
    var res = await _apiGet.getPaymentMethod();
    return res;
  }

  Future<CourierService> getCourierService(Map<String, dynamic> data) async {
    var res = await _apiPost.getCost(data);
    return res;
  }

  Future<InvoiceCallback> saveInvoice(Map<String, dynamic> data) async {
    var res = await _apiPost.saveInvoice(data);
    if (res.code == 200) {
      _listInvoiceCallback = res.data;
    }
    return res;
  }

  Future<KonfirmCallback> confirmInvoice(Map<String, dynamic> data) async {
    var res = await _apiPost.confirmInvoice(data);
    if (res.code == 200) {
      _konfirmCallbackData = res.data;
    }
    return res;
  }

  void setInvoice(ListInvoiceCallback data) {
    _listInvoiceCallback = data;
  }

  void clearAmt() {
    _vDiscount = 0;
    _isExpanded = "";
  }
}
