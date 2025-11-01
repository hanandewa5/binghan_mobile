import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/api_get.dart';
import 'package:binghan_mobile/_services/api_post.dart';
import 'package:binghan_mobile/models/member_pv.dart';
import 'package:binghan_mobile/models/res_api.dart';

class TransferPVService {
  final ApiPost _apiPost = locator<ApiPost>();
  final ApiGet _apiGet = locator<ApiGet>();

  ListMemberPV? _listMemberPv;
  final List<ListMemberPV> _listMemberPVs = [];

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  int _availablePV = 0;

  List<ListMemberPV> get listMemberPVs => _listMemberPVs;
  ListMemberPV? get listMemberPv => _listMemberPv;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  int get availablePV => _availablePV;

  void setListDirect(ListMemberPV listDirect) {
    _listMemberPv = listDirect;
  }

  Future<ResApi> transferPV(Map<String, dynamic> data) async {
    var res = await _apiPost.transferPV(data);
    return res;
  }

  Future getAvailablePV(int? id) async {
    var res = await _apiGet.getAvailablePV(id);
    if (res.code == 200) {
      _availablePV = res.data["Pv Amount"];
    }
  }

  Future getMemberPV(int? id) async {
    _listMemberPVs.clear();
    var res = await _apiGet.getMemberPV(id);
    _listMemberPVs.addAll(res.data?.list ?? []);
  }

  void initPV() {
    _startDate = DateTime(2017, 1, 1);
    _endDate = DateTime.now();
  }

  void initPVBulanIni() {
    DateTime date = new DateTime.now();
    _startDate = DateTime(date.year, date.month, 1);
    _endDate = DateTime.now();
  }

  void initBonusPV() {
    DateTime date = new DateTime.now();
    _startDate = DateTime(date.year, 1, 1);
    _endDate = DateTime.now();
  }

  void setStartDate(DateTime date) {
    _startDate = DateTime(date.year, date.month, date.day);
  }

  void setEndDate(DateTime date) {
    _endDate = DateTime(date.year, date.month, date.day);
    print(_endDate);
  }
}
