import 'dart:convert';
// import 'dart:io';
import 'package:binghan_mobile/models/bank.dart';
import 'package:binghan_mobile/models/bonus.dart';
import 'package:binghan_mobile/models/carousel.dart';
import 'package:binghan_mobile/models/cart.dart';
import 'package:binghan_mobile/models/city.dart';
import 'package:binghan_mobile/models/courier.dart';
import 'package:binghan_mobile/models/direct.dart';
import 'package:binghan_mobile/models/district.dart';
import 'package:binghan_mobile/models/downline.dart';
import 'package:binghan_mobile/models/group_sales.dart';
import 'package:binghan_mobile/models/invoice_detail.dart';
import 'package:binghan_mobile/models/invoice_header.dart';
import 'package:binghan_mobile/models/invoice_multi_header.dart';
import 'package:binghan_mobile/models/item.dart';
import 'package:binghan_mobile/models/item_detail.dart';
import 'package:binghan_mobile/models/member.dart';
import 'package:binghan_mobile/models/member_pv.dart';
import 'package:binghan_mobile/models/notifications.dart';
import 'package:binghan_mobile/models/order_track.dart';
import 'package:binghan_mobile/models/point_value.dart';
import 'package:binghan_mobile/models/province.dart';
import 'package:binghan_mobile/models/pv_history.dart';
import 'package:binghan_mobile/models/renewal.dart';
import 'package:binghan_mobile/models/res_api.dart';
import 'package:binghan_mobile/models/warehouse.dart';
import 'package:http/http.dart' as http;
import 'package:binghan_mobile/_constants/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiGet {
  var client = new http.Client();
  // HttpClient client = new HttpClient();
  static const endpoint = AppConfig.apiUrl;
  var header = new Map<String, String>.from(AppConfig.header);
  static const addressEndpoint = '$endpoint/v1/address';
  static const itemsEndpoint = '$endpoint/v1/items/mobile';
  static const memberEndpoint = '$endpoint/v1/members';
  static const carouselEndpoint = '$endpoint/v1/carousels';
  static const cartEndpoint = '$endpoint/v1/order-details';
  static const paymentMethodEndpoint = '$endpoint/v1/payment-method/mobile';
  static const courierEndpoint = '$endpoint/v1/couriers?active=1';
  static const warehouseEndpoint = '$endpoint/v1/warehouses';
  static const invoiceEndpoint = '$endpoint/v1/invoices';
  static const pvEndpoint = '$endpoint/v1/point-values';
  static const renewalEndpoint = '$endpoint/v1/renewal';
  static const groupSalesEndpoint = '$endpoint/v1/group-sales';
  static const costEndpoint = '$endpoint/v1/get-cost';
  static const trackEndpoint = '$endpoint/v1/way-bill';
  static const bonusEndpoint = '$endpoint/v1/bonus';
  static const notificationEndpoint = '$endpoint/v1/notification';
  static const paramEndpoint = '$endpoint/parameters';

  Future requestGetWithToken(String endpointUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header["Authorization"] = prefs.getString("token") ?? '';
    try {
      var response = await client
          .get(Uri.parse(endpointUrl), headers: header)
          .timeout(Duration(seconds: AppConfig.timeoutRequest));
      return json.decode(response.body);
    } catch (e) {
      print(e.toString());
      Map<String, dynamic> data = {
        "code": 500,
        "msg": "No Internet Access",
        "data": null,
      };
      return data;
    }
  }

  Future requestGetWithoutToken(String endpointUrl) async {
    try {
      var response = await client
          .get(Uri.parse(endpointUrl), headers: header)
          .timeout(Duration(seconds: AppConfig.timeoutRequest));
      return json.decode(response.body);
    } catch (e) {
      print(e.toString());
      Map<String, dynamic> data = {
        "code": 500,
        "msg": "No Internet Access",
        "data": null,
      };
      return data;
    }
  }

  Future<Province> getProvince(String filter) async {
    var result = await requestGetWithToken(
      '$addressEndpoint/provinces?province=$filter&perpage=5',
    );
    return Province.fromJson(result);
  }

  Future<City> getCity(int? id, String? filter) async {
    var result = await requestGetWithToken(
      '$addressEndpoint/cities?province=$id&city=$filter&perpage=5',
    );
    return City.fromJson(result);
  }

  Future<District> getDistrict(int? id, String? filter) async {
    var result = await requestGetWithToken(
      '$addressEndpoint/subdistricts?city=$id&subdistrict=$filter&perpage=5',
    );
    return District.fromJson(result);
  }

  Future<Item> getItem(int? id) async {
    var result = await requestGetWithToken("$itemsEndpoint?pr=1");
    return Item.fromJson(result);
  }

  Future<ItemDetail> getItemDetail(int? id) async {
    var dynApi = '$itemsEndpoint?id=$id';
    var result = await requestGetWithToken(dynApi);
    return ItemDetail.fromJson(result);
  }

  Future<ResApi> getUser(int? id) async {
    var result = await requestGetWithToken('$memberEndpoint/$id');
    return ResApi.fromJson(result);
  }

  Future<Member> getMember() async {
    var result = await requestGetWithToken('$memberEndpoint');
    return Member.fromJson(result);
  }

  Future<Downline> getDownline(int id, String filter) async {
    var result = await requestGetWithToken(
      '$memberEndpoint/$id/downlines?filter=$filter',
    );
    return Downline.fromJson(result);
  }

  Future<PointValue> getPointValue(int id) async {
    var result = await requestGetWithToken('$memberEndpoint/$id/pv');
    return PointValue.fromJson(result);
  }

  Future<Renewal> getRenewalPV(int? id) async {
    var result = await requestGetWithToken('$renewalEndpoint?id=$id');
    return Renewal.fromJson(result);
  }

  Future<Direct> getMemberDirect(int id) async {
    var result = await requestGetWithToken('$memberEndpoint/$id/direct');
    return Direct.fromJson(result);
  }

  Future<Carousel> getCarousel() async {
    var result = await requestGetWithToken('$carouselEndpoint');
    return Carousel.fromJson(result);
  }

  Future<Cart> getCartList(int id) async {
    var result = await requestGetWithToken('$cartEndpoint?id=$id');
    return Cart.fromJson(result);
  }

  Future<Courier> getCourier() async {
    var result = await requestGetWithToken('$courierEndpoint');
    return Courier.fromJson(result);
  }

  Future<Bank> getPaymentMethod() async {
    var result = await requestGetWithToken('$paymentMethodEndpoint');
    return Bank.fromJson(result);
  }

  Future<Warehouse> getWarehouse() async {
    var result = await requestGetWithToken('$warehouseEndpoint');
    return Warehouse.fromJson(result);
  }

  Future<InvoiceHeader> getInvoiceHeader(String filterBy, int id) async {
    var result = await requestGetWithToken(
      '$invoiceEndpoint/header?$filterBy=$id',
    );
    return InvoiceHeader.fromJson(result);
  }

  Future<InvoiceDetail> getInvoiceDetail(int id) async {
    var result = await requestGetWithToken('$invoiceEndpoint/detail/$id');
    return InvoiceDetail.fromJson(result);
  }

  Future<InvoiceMultiHeader> getInvoiceMultiHeaderByID(int? id) async {
    var result = await requestGetWithToken(
      '$invoiceEndpoint/list-multi?id=$id',
    );
    return InvoiceMultiHeader.fromJson(result);
  }

  Future<InvoiceMultiHeader> getInvoiceMultiHeader(int id) async {
    var result = await requestGetWithToken(
      '$invoiceEndpoint/list-multi?member_id=$id',
    );
    print(result);
    return InvoiceMultiHeader.fromJson(result);
  }

  Future<InvoiceDetail> getInvoiceMultiDetail(int id) async {
    var result = await requestGetWithToken('$invoiceEndpoint/detail-multi/$id');
    print(result);
    return InvoiceDetail.fromJson(result);
  }

  Future<ResApi> getAvailablePV(int? id) async {
    var result = await requestGetWithToken('$pvEndpoint/getavailablepv/$id');
    return ResApi.fromJson(result);
  }

  Future<MemberPv> getMemberPV(int? id) async {
    var result = await requestGetWithToken('$pvEndpoint/gettransfermember/$id');
    return MemberPv.fromJson(result);
  }

  Future<PvHistory> getPVHistory(
    int id,
    String start,
    String end,
    int transfer,
  ) async {
    var result = await requestGetWithToken(
      '$memberEndpoint/$id/pvhistory?startdate=$start&enddate=$end&transfer=$transfer',
    );
    return PvHistory.fromJson(result);
  }

  Future<GroupSales> getGroupSales(
    int id,
    String name,
    String start,
    String end,
    bool allowZero,
    int transfer,
    int groupDm,
    page,
  ) async {
    int allowZeroInt = allowZero ? 1 : 0;
    var result = await requestGetWithToken(
      '$groupSalesEndpoint?id=$id&nama=$name&startdate=$start&enddate=$end&allowzero=$allowZeroInt&transfer=$transfer&group_dm=$groupDm&page=$page&perpage=30',
    );
    return GroupSales.fromJson(result);
  }

  Future<ResApi> getHandlingCost() async {
    var result = await requestGetWithToken('$costEndpoint/packing');
    return ResApi.fromJson(result);
  }

  Future<OrderTrack> getOrderTrack(String resi, String kurir) async {
    var result = await requestGetWithToken(
      '$trackEndpoint?waybill=$resi&courier=$kurir',
    );
    return OrderTrack.fromJson(result);
  }

  Future<ResApi> getLastBonus(String binghanId) async {
    var result = await requestGetWithToken('$bonusEndpoint/last/$binghanId');
    return ResApi.fromJson(result);
  }

  Future<Bonus> getBonus(String binghanId, String start, String end) async {
    var result = await requestGetWithToken(
      '$bonusEndpoint/get-bonus?binghan_id=$binghanId&start_bulan=$start&end_bulan=$end',
    );
    return Bonus.fromJson(result);
  }

  Future<Notifications> getNotification(String binghanId) async {
    var result = await requestGetWithToken(
      '$notificationEndpoint/member/$binghanId',
    );
    return Notifications.fromJson(result);
  }

  Future<ResApi> readNotif(int id) async {
    var result = await requestGetWithToken('$notificationEndpoint/read/$id');
    return ResApi.fromJson(result);
  }

  Future<ResApi> logout(int id) async {
    var result = await requestGetWithToken('$memberEndpoint/$id/logout');
    return ResApi.fromJson(result);
  }

  Future<ResApi> chcekVersion(String version) async {
    var result = await requestGetWithoutToken(
      '$paramEndpoint?version=$version',
    );
    return ResApi.fromJson(result);
  }
}
