import 'dart:async';
import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/api_post.dart';
import 'package:binghan_mobile/_services/api_put.dart';
import 'package:binghan_mobile/models/bank.dart';
import 'package:binghan_mobile/models/bonus.dart';
import 'package:binghan_mobile/models/city.dart';
import 'package:binghan_mobile/models/direct.dart';
import 'package:binghan_mobile/models/district.dart';
import 'package:binghan_mobile/models/downline.dart';
import 'package:binghan_mobile/models/group_sales.dart';
import 'package:binghan_mobile/models/invoice_callback.dart';
import 'package:binghan_mobile/models/member.dart';
import 'package:binghan_mobile/models/province.dart';
import 'package:binghan_mobile/models/pv_history.dart';
import 'package:binghan_mobile/models/res_api.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:date_format/date_format.dart';
import 'api_get.dart';

class MemberService {
  final ApiGet _apiGet = locator<ApiGet>();
  final ApiPost _apiPost = locator<ApiPost>();
  final ApiPut _apiPut = locator<ApiPut>();

  int _pointValue = 0;
  int get pointValue => _pointValue;

  int _renewalPV = 0;
  int get renewalPV => _renewalPV;

  late User _userData;
  User get userData => _userData;

  late ListInvoiceCallback _invoiceUrl;
  ListInvoiceCallback get invoiceUrl => _invoiceUrl;

  late ListBankChild _paymentMethod;
  ListBankChild get paymentMethod => _paymentMethod;

  Future<Province> getProvince(String filter) async {
    var res = await _apiGet.getProvince(filter);
    return res;
  }

  Future<City> getCity(int? id, String? filter) async {
    var res = await _apiGet.getCity(id, filter);
    return res;
  }

  Future<District> getDistrict(int? id, String? filter) async {
    var res = await _apiGet.getDistrict(id, filter);
    return res;
  }

  Future<ResApi> getUser(int? id) async {
    var res = await _apiGet.getUser(id);
    if (res.code == 200) {
      _userData = User.fromJson(res.data);
    }
    return res;
  }

  Future<Member> getMember() async {
    var res = await _apiGet.getMember();
    return res;
  }

  Future<Downline> getDownline(int idUser, String filter) async {
    var res = await _apiGet.getDownline(idUser, filter);
    return res;
  }

  // Future getPointValue(int idUser) async {
  //   var res = await _apiGet.getPointValue(idUser);
  //   if (res.code == 200) {
  //     _pointValue = res.data.pv.toString() + " PV";
  //   }
  // }

  Future getRenewalPV(int? idUser) async {
    var res = await _apiGet.getRenewalPV(idUser);
    if (res.code == 200) {
      _renewalPV = res.data?.list?.kekuranganPv ?? 0;
      if (_renewalPV < 0) {
        _renewalPV *= -1;
      }
    }
  }

  Future<Direct> getMemberDirect(int id) async {
    var res = await _apiGet.getMemberDirect(id);
    return res;
  }

  Future<int> getTotalPV(
    int id,
    DateTime start,
    DateTime end,
    int transfer,
  ) async {
    String startDate = "";
    String endDate = "";
    startDate = formatDate(start, [yyyy, "-", mm, "-", dd]);
    endDate = formatDate(end, [yyyy, "-", mm, "-", dd]);
    var res = await _apiGet.getPVHistory(id, startDate, endDate, transfer);
    if (res.code == 200) {
      return countPV(res.data?.list ?? []);
    }
    return 0;
  }

  Future<dynamic> getTotalBonusPV(String binghanId) async {
    var res = await _apiGet.getLastBonus(binghanId);
    if (res.code == 200 && res.data != null) {
      return res.data;
    }
    return false;
  }

  Future<PvHistory> getPVHistory(
    int id,
    DateTime start,
    DateTime end,
    int transfer,
  ) async {
    String startDate = "";
    String endDate = "";
    startDate = formatDate(start, [yyyy, "-", mm, "-", dd]);
    endDate = formatDate(end, [yyyy, "-", mm, "-", dd]);
    var res = await _apiGet.getPVHistory(id, startDate, endDate, transfer);
    if (res.code == 200) {
      _pointValue = await countPV(res.data?.list ?? []);
      return res;
    }
    return res;
  }

  Future<Bonus> getBonusHistory(
    String binghanId,
    DateTime start,
    DateTime end,
  ) async {
    String startDate = "";
    String endDate = "";
    startDate = formatDate(start, [yyyy, mm]);
    endDate = formatDate(end, [yyyy, mm]);
    var res = await _apiGet.getBonus(binghanId, startDate, endDate);

    return res;
  }

  Future<int> countPV(List<ListPvHistory> list) async {
    var res = 0;
    for (var i in list) {
      res += (i.amount ?? 0);
    }
    return res;
  }

  Future<int> countBonus(List<ListBonus> list) async {
    var res = 0;
    if (list.isNotEmpty) {
      res =
          list
              .lastWhere((lists) => lists.jumlahDiTransfer != null)
              .jumlahDiTransfer ??
          0;
    }
    return res;
  }

  Future<ResApi> saveMember(Map<String, dynamic> data) async {
    var res = await _apiPost.saveMember(data);
    if (res.code == 200) {
      setInvoiceUrl(ListInvoiceCallback.fromJson(res.data));
    }
    return res;
  }

  Future<GroupSales> getGroupSales(
    int id,
    String name,
    DateTime start,
    DateTime end,
    bool allowZero,
    int transfer,
    int groupDm,
    int page,
  ) async {
    String startDate = formatDate(start, [yyyy, "-", mm, "-", dd]);
    String endDate = formatDate(end, [yyyy, "-", mm, "-", dd]);
    startDate = formatDate(start, [yyyy, "-", mm, "-", dd]);
    endDate = formatDate(end, [yyyy, "-", mm, "-", dd]);
    var res = await _apiGet.getGroupSales(
      id,
      name,
      startDate,
      endDate,
      allowZero,
      transfer,
      groupDm,
      page,
    );
    return res;
  }

  Future<ResApi> editMember(int? id, Map<String, dynamic>? data) async {
    var res = await _apiPut.editMember(id, data);
    return res;
  }

  Future<ResApi> editPassword(int? id, Map<String, dynamic>? data) async {
    var res = await _apiPut.editPassword(id, data);
    return res;
  }

  Future<ResApi> uploadImage(Map<String, dynamic>? data) async {
    var res = await _apiPost.uploadImage(data);
    return res;
  }

  void setInvoiceUrl(ListInvoiceCallback url) {
    _invoiceUrl = url;
  }

  Future setPaymentMethod(ListBankChild listBankChild) async {
    _paymentMethod = listBankChild;
  }

  Future<ResApi> logout(int id) async {
    var res = await _apiGet.logout(id);
    return res;
  }
}
