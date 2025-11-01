import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/api_get.dart';
import 'package:binghan_mobile/_services/api_put.dart';
import 'package:binghan_mobile/models/invoice_detail.dart';
import 'package:binghan_mobile/models/invoice_header.dart';
import 'package:binghan_mobile/models/invoice_multi_header.dart';
import 'package:binghan_mobile/models/order_track.dart';
import 'package:binghan_mobile/models/res_api.dart';
import 'package:flutter/material.dart';

class InvoiceService {
  final ApiGet _apiGet = locator<ApiGet>();
  final ApiPut _apiPut = locator<ApiPut>();

  late ListInvoiceHeader _invoiceHeader;
  ListInvoiceHeader get invoiceHeader => _invoiceHeader;

  late ListInvoiceDetail _invoiceDetail;
  ListInvoiceDetail get invoiceDetail => _invoiceDetail;

  late ListInvoiceMultiHeader _listInvoiceMultiHeader;
  ListInvoiceMultiHeader get listInvoiceMultiHeader => _listInvoiceMultiHeader;

  final List<ListInvoiceHeader> _listInvoiceHeader = [];
  List<ListInvoiceHeader> get listInvoiceHeader => _listInvoiceHeader;

  late TabController _tabController;
  TabController get tabController => _tabController;

  late ListInvoiceMultiHeader _invoiceUrl;
  ListInvoiceMultiHeader get invoiceUrl => _invoiceUrl;

  double _subPrice = 0;
  double get subPrice => _subPrice;
  int _subPopDisc = 0;
  int get subPopDisc => _subPopDisc;
  int _vDisc = 0;
  int get vDisc => _vDisc;
  int _handlingCost = 0;
  int get handlingCost => _handlingCost;
  double _grandPrice = 0;
  double get grandPrice => _grandPrice;

  void setTabController(TabController tabs, VoidCallback listen) {
    _tabController = tabs;
    _tabController.addListener(listen);
  }

  void setTabControllerIndex(int index) {
    _tabController.index = index;
  }

  void setOrderHistory(ListInvoiceHeader listOrderHistory) {
    _invoiceHeader = listOrderHistory;
  }

  Future setInvoiceMultiHeader(
    ListInvoiceMultiHeader listInvoiceMultiHeader,
  ) async {
    _listInvoiceMultiHeader = listInvoiceMultiHeader;
  }

  Future<InvoiceMultiHeader> setInvoiceUrl(ListInvoiceMultiHeader data) async {
    var res = await _apiGet.getInvoiceMultiHeaderByID(data.id);
    if (res.code == 200 && res.data != null) {
      _invoiceUrl = res.data!.list![0];
    }
    return res;
  }

  Future getInvoiceHeader(String filterBy, int id) async {
    var res = await _apiGet.getInvoiceHeader(filterBy, id);
    _listInvoiceHeader.clear();
    if (res.code == 200 && res.data != null) {
      for (var i = 0; i < res.data!.list!.detail!.length; i++) {
        ListInvoiceHeader suggest = res.data!.list!.detail![i];
        _listInvoiceHeader.add(suggest);
      }
    }
  }

  Future getInvoiceMultiDetail(int id) async {
    var res = await _apiGet.getInvoiceMultiDetail(id);
    _subPrice = 0;
    _vDisc = 0;
    _grandPrice = 0;
    if (res.code == 200 && res.data != null) {
      _invoiceDetail = res.data!;
      _subPopDisc = _invoiceDetail.discount!;
      _subPrice +=
          _invoiceDetail.detail![0].item!.price! *
          _invoiceDetail.detail![0].qty!;
      _handlingCost = await getHandlingCost(invoiceDetail.shippingMethod!);
      _grandPrice +=
          _invoiceDetail.subTotal! +
          _invoiceDetail.ppn! -
          _invoiceDetail.discount! +
          (_handlingCost * 0.11);
      if (_invoiceDetail.detail!.length > 1) {
        _vDisc +=
            _invoiceDetail.detail![1].item!.price! *
            _invoiceDetail.detail![0].qty! *
            -1;
      }
    }
  }

  Future<InvoiceMultiHeader> getInvoiceMultiHeader(int id) async {
    var res = await _apiGet.getInvoiceMultiHeader(id);
    return res;
  }

  Future<OrderTrack> getOrderTrack(String resi, String kurir) async {
    var res = await _apiGet.getOrderTrack(resi, kurir);
    return res;
  }

  Future<ResApi> setCompleteInvoice(int id) async {
    var res = await _apiPut.setCompleteInvoice(id);
    return res;
  }

  Future<int> getHandlingCost(String method) async {
    print(method);
    if (method.toUpperCase() == "AMBIL DITEMPAT") {
      return 0;
    } else {
      var res = await _apiGet.getHandlingCost();
      return res.data["price"];
    }
  }
}
