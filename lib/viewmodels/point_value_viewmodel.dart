import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/_services/transferPv_service.dart';
import 'package:binghan_mobile/models/bonus.dart';
import 'package:binghan_mobile/models/member_pv.dart';
import 'package:binghan_mobile/models/pv_history.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;

class PointValueViewModel extends BaseModel {
  final TransferPVService _transferPVService = locator<TransferPVService>();
  final MemberService _memberService = locator<MemberService>();
  final NavigationService _navigationService = locator<NavigationService>();

  DateTime get startDate => _transferPVService.startDate;
  DateTime get endDate => _transferPVService.endDate;
  int get availablePV => _transferPVService.availablePV;
  List<ListMemberPV> get listMemberPV => _transferPVService.listMemberPVs;
  List<ListPvHistory> listPVHistory = [];
  List<ListBonus> listBonus = [];
  int totalPV = 0;
  int totalBonus = 0;
  int transfer = 1;

  Future refreshInit() async {
    await getMemberPV();
  }

  void initBonus() async {
    await getBonusHistory();
  }

  Future<void> refreshInitBonus() async {
    await getBonusHistory();
  }

  Future getMemberPV() async {
    User userData = _memberService.userData;
    await _transferPVService.getMemberPV(userData.id);
    refresh();
  }

  Future getAvailPV() async {
    User userData = _memberService.userData;
    await _transferPVService.getAvailablePV(userData.id);
  }

  Future getPVHistory() async {
    User userData = _memberService.userData;
    listPVHistory.clear();
    setBusy(true);
    var res = await _memberService.getPVHistory(
      userData.id ?? 0,
      startDate,
      endDate,
      transfer,
    );
    totalPV = 0;
    if (res.code == 200) {
      if (res.data != null && (res.data!.list?.length ?? 0) > 0) {
        for (var i = 0; i < res.data!.list!.length; i++) {
          ListPvHistory suggest = res.data!.list![i];
          listPVHistory.add(suggest);
          totalPV += res.data!.list![i].amount ?? 0;
        }
      }
    }
    setBusy(false);
  }

  Future getBonusHistory() async {
    User userData = _memberService.userData;
    listBonus.clear();
    setBusy(true);
    var res = await _memberService.getBonusHistory(
      userData.binghanId ?? '',
      startDate,
      endDate,
    );
    totalBonus = 0;
    if (res.code == 200 && res.data != null) {
      for (var i = 0; i < (res.data!.list?.length ?? 0); i++) {
        ListBonus suggest = res.data!.list![i];
        listBonus.add(suggest);
        totalBonus += res.data!.list![i].jumlahDiTransfer ?? 0;
      }
    }
    setBusy(false);
  }

  void setStartDate(DateTime date) {
    _transferPVService.setStartDate(date);
    getPVHistory();
    refresh();
  }

  void setEndDate(DateTime date) {
    _transferPVService.setEndDate(date);
    getPVHistory();
    refresh();
  }

  void setStartDateBonus(DateTime date) {
    _transferPVService.setStartDate(date);
    getBonusHistory();
    refresh();
  }

  void setEndDateBonus(DateTime date) {
    _transferPVService.setEndDate(date);
    getBonusHistory();
    refresh();
  }

  void setTransfer(bool active) async {
    transfer = active ? 1 : 0;
    refresh();
    getPVHistory();
  }

  int getAvPV(int pv) {
    if (pv > availablePV) {
      pv = availablePV;
    }
    if (availablePV <= 0) {
      pv = 0;
    }
    return pv;
  }

  void goToTansferPV(ListMemberPV listDirect) {
    _transferPVService.setListDirect(listDirect);
    _navigationService.navigateTo(routes.TransferPVRoute);
  }
}
