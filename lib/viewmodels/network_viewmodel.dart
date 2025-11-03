import 'package:binghan_mobile/_services/dialog_service.dart';
import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/_services/transferPv_service.dart';
import 'package:binghan_mobile/models/group_sales.dart';
import 'package:binghan_mobile/models/member_pv.dart';
import 'package:binghan_mobile/models/res_api.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;

class NetworkViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final MemberService _memberService = locator<MemberService>();
  final TransferPVService _transferPVService = locator<TransferPVService>();
  final NavigationService _navigationService = locator<NavigationService>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime startDate = DateTime(2001, 01, 01);
  DateTime endDate = DateTime.now();

  List<ListGroupSales> listGroupSales = [];
  ListMemberPV? get listDirect => _transferPVService.listMemberPv;
  bool isMember = true;
  bool valid = true;
  int idUser = 0;
  bool allowZero = true;
  bool isSearch = false;
  int transfer = 1;
  int groupDm = 1;
  int curPage = 1;

  TextEditingController amount = TextEditingController();
  TextEditingController searchName = TextEditingController();
  DateTime? dateDebounce;

  bool reachTop = true;
  bool reachBot = false;
  ScrollController? scrollController;
  _scrollListener() {
    if (scrollController?.hasClients ?? false) {
      if (scrollController!.offset >= 50) {
        if (reachTop) {
          reachTop = false;
          refresh();
        }
      }

      if (scrollController!.position.pixels ==
              scrollController!.position.maxScrollExtent &&
          !screenLoading) {
        getMoreGroupSales();
      }
    }
  }

  void init() async {
    User userData = _memberService.userData;
    idUser = userData.id ?? 0;
    scrollController = ScrollController();
    scrollController?.addListener(_scrollListener);
    getGroupSales();
  }

  Future<void> refreshInit() async {
    searchName.clear();
    User userData = _memberService.userData;
    idUser = userData.id ?? 0;
    getGroupSales();
    refresh();
    // getProductItem(null);
  }

  Future selectUser(int id) async {
    idUser = id;
    searchName.clear();
    await getGroupSales();
  }

  void setAllowZero(bool active) async {
    allowZero = active;
    refresh();
    await getGroupSales();
  }

  void setTransfer(bool active) async {
    transfer = active ? 1 : 0;
    refresh();
    await getGroupSales();
  }

  void setGroupDM(bool active) async {
    groupDm = active ? 1 : 0;
    refresh();
    await getGroupSales();
  }

  Future getGroupSales() async {
    setBusy(true);
    reachTop = true;
    curPage = 1;
    await getDataGroupSales();
    setBusy(false);
  }

  Future getMoreGroupSales() async {
    curPage++;
    setScreenLoad(true);
    await Future.delayed(Duration(seconds: 1));
    var res = await getDataGroupSales(isMore: true);
    if (res.code == 200) {
      refresh();
    }
    setScreenLoad(false);
  }

  Future<GroupSales> getDataGroupSales({bool isMore = false}) async {
    var res = await _memberService.getGroupSales(
      idUser,
      searchName.text,
      startDate,
      endDate,
      allowZero,
      transfer,
      groupDm,
      curPage,
    );
    if (res.code == 200) {
      if (!isMore) listGroupSales.clear();
      if (res.data != null && (res.data!.list?.length ?? 0) > 0) {
        for (var i = 0; i < (res.data!.list?.length ?? 0); i++) {
          ListGroupSales suggest = res.data!.list![i];
          listGroupSales.add(suggest);
        }
      }
    }
    return res;
  }

  Future transferPV() async {
    User userData = _memberService.userData;

    if (listDirect == null) {
      isMember = false;
    }
    if (formKey.currentState!.validate() && listDirect != null) {
      Map<String, dynamic> data = {
        "amount_pv": int.parse(amount.text),
        "from_id": userData.id,
        "is_admin": false,
        "to_id": listDirect?.id ?? '',
        "type": "transfer",
      };

      var resDialog = await _dialogService.showDialog(
        title: "Perhatian !",
        descs: "Apakah anda yakin ?",
      );

      var valid = true;
      var errorMsg = "Jumlah PV tidak valid";

      if (int.parse(amount.text) > (listDirect?.availableTransfer ?? 0)) {
        valid = false;
        errorMsg =
            "Jumlah yang anda input lebih besar dari jumlah pv yang bisa ditransfer";
      }

      if (int.parse(amount.text) > _transferPVService.availablePV) {
        valid = false;
        errorMsg = "PV pribadi anda tidak cukup untuk melakukan transfer";
      }

      if (int.parse(amount.text) <= 0) {
        valid = false;
        errorMsg = "Jumlah PV tidak boleh nol atau kurang dari nol";
      }

      if (resDialog.confirmed) {
        if (valid) {
          setBusy(true);
          ResApi resApi = await _transferPVService.transferPV(data);
          if (resApi.code == 200) {
            await _transferPVService.getMemberPV(userData.id ?? 0);
            await _dialogService.showDialog(
              title: "Title",
              descs: "Permintaan anda sedang diverifikasi. Mohon tunggu",
            );
            _navigationService.goBack();
          } else {
            await _dialogService.showDialog(title: "Title", descs: resApi.msg);
          }
          setBusy(false);
        } else {
          await _dialogService.showDialog(title: "Perhatian", descs: errorMsg);
        }
      }
    }

    refresh();
  }

  void searchByName(String name) {
    setBusy(true);
    DateTime now = DateTime.now();
    if (dateDebounce == null ||
        (dateDebounce != null &&
            now.difference(dateDebounce!) > Duration(seconds: 2))) {
      dateDebounce = now;
      Future.delayed(Duration(seconds: 2), () {
        getGroupSales();
        setBusy(false);
      });
    }
  }

  void setStartDate(DateTime? date) {
    if (date != null) {
      startDate = date;
      getGroupSales();
      refresh();
    }
  }

  void setEndDate(DateTime? date) {
    if (date != null) {
      endDate = date;
      getGroupSales();
      refresh();
    }
  }

  void searchClick() {
    isSearch = !isSearch;
    refresh();
  }

  // void goToTansferPV(ListDirect listDirect) {
  //   _transferPVService.setListDirect(listDirect);
  //   _navigationService.navigateTo(routes.TransferPVRoute);
  // }

  void goToAddNewMember() {
    _navigationService.navigateTo(routes.NewMemberRoute);
  }
}
