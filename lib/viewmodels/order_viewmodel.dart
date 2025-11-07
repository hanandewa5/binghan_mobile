import 'dart:async';

import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/dialog_service.dart';
import 'package:binghan_mobile/_services/invoice_service.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/models/invoice_detail.dart';
import 'package:binghan_mobile/models/invoice_header.dart';
import 'package:binghan_mobile/models/invoice_multi_header.dart';
import 'package:binghan_mobile/models/order_track.dart';
import 'package:binghan_mobile/models/user.dart';
// import 'package:binghan_mobile/_services/dialog_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final InvoiceService _invoiceService = locator<InvoiceService>();
  final DialogService _dialogService = locator<DialogService>();
  MemberService _memberService = locator<MemberService>();

  List<ListInvoiceHeader> get listInvoiceHeader =>
      _invoiceService.listInvoiceHeader;
  List<ListInvoiceMultiHeader> listInvoiceMulti = [];
  ListInvoiceDetail get invoiceDetail => _invoiceService.invoiceDetail;
  ListInvoiceMultiHeader get invoiceMultiHeader =>
      _invoiceService.listInvoiceMultiHeader;

  TabController get tabController => _invoiceService.tabController;

  ListInvoiceMultiHeader get invoiceUrl => _invoiceService.invoiceUrl;
  double get subPrice => _invoiceService.subPrice;
  int get subPopDisc => _invoiceService.subPopDisc;
  int get vDisc => _invoiceService.vDisc;
  int get handlingCost => _invoiceService.handlingCost;
  double get grandPrice => _invoiceService.grandPrice;

  void setTabController(TabController tabs, VoidCallback listen) {
    _invoiceService.setTabController(tabs, listen);
  }

  List<Manifest> listManifest = [];

  int hour = 0;
  int minute = 0;
  Timer? timer;
  int second = 0;

  void init() {
    refresh();
    // getInvoiceHeader();
  }

  void initMulti() async {
    User userData = _memberService.userData;

    await getInvoiceMulti();
    await getInvoiceHeader("memberid", userData.id ?? 0);
  }

  void initInvoiceDetail() {
    // getInvoiceDetail();
  }

  void initTrack() async {
    getOrderTrack();
  }

  void initTime() {
    if (invoiceUrl.methodType != "BCA") return;

    format(Duration d) =>
        d.toString().split('.').first.padLeft(8, "0").toString();
    Duration dur = invoiceUrl.sisaWaktu ?? Duration();
    if (!dur.isNegative) {
      hour = int.parse(format(dur).substring(0, 2));
      minute = int.parse(format(dur).substring(3, 5));
      second = int.parse(format(dur).substring(6, 8));
      startTimer();
    }
  }

  Future<void> refreshInit() async {
    init();
    refresh();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);

    timer = Timer.periodic(oneSec, (Timer _timer) {
      if (second == 0) {
        if (hour == 0 && minute == 0) {
          timer?.cancel();
        } else {
          if (minute == 0) {
            minute = 59;
            hour--;
          } else {
            minute--;
            second = 59;
          }
        }
      } else {
        second--;
      }

      refresh();
    });
  }

  Future getInvoiceHeader(String filter, int id) async {
    await _invoiceService.getInvoiceHeader(filter, id);
  }

  Future getInvoiceMulti() async {
    User userData = _memberService.userData;
    var res = await _invoiceService.getInvoiceMultiHeader(userData.id ?? 0);
    listInvoiceMulti.clear();
    if (res.code == 200 && res.data != null) {
      for (var i = 0; i < (res.data!.list?.length ?? 0); i++) {
        ListInvoiceMultiHeader suggest = res.data!.list![i];
        listInvoiceMulti.add(suggest);
      }
    }
    refresh();
  }

  Future getOrderTrack() async {
    var res = await _invoiceService.getOrderTrack(
      invoiceMultiHeader.nomorResi ?? '',
      invoiceMultiHeader.shippingMethod ?? '',
    );
    listManifest.clear();
    if (res.code == 200 && res.data != null) {
      for (var i = 0; i < (res.data!.manifest?.length ?? 0); i++) {
        Manifest suggest = res.data!.manifest![i];
        listManifest.add(suggest);
      }
    }
    refresh();
  }

  Future goToInvoiceMultiDetail(ListInvoiceMultiHeader orderHistory) async {
    await getInvoiceHeader("id", orderHistory.id ?? 0);
    _invoiceService.setTabControllerIndex(1);
  }

  Future goToInvoiceDetail(ListInvoiceHeader orderHistory) async {
    await _invoiceService.getInvoiceMultiDetail(orderHistory.id ?? 0);
    _navigationService.navigateTo(routes.InvoiceDetailRoute);
  }

  void goToTrack(ListInvoiceMultiHeader invoiceMultiHeader) async {
    await _invoiceService.setInvoiceMultiHeader(invoiceMultiHeader);
    _navigationService.navigateTo(routes.OrderTrackRoute);
  }

  void goToCaraBayar(ListInvoiceMultiHeader data) async {
    // await _invoiceService.getInvoiceMultiDetail(id);
    setBusy(true);
    var res = await _invoiceService.setInvoiceUrl(data);
    setBusy(false);
    if (res.code == 200) {
      _navigationService.navigateTo(routes.OrderCaraBayar);
    }
  }

  void setComplete(int id) async {
    var res = await _dialogService.showDialog(
      title: "Apakah anda yakin untuk menyelesaikan order ini ?",
      descs: "Jika anda setuju maka order akan dianggap selesai",
      btnTittle: "Setuju",
      secondBtnTittle: "Tidak",
    );

    if (res.confirmed) {
      var result = await _invoiceService.setCompleteInvoice(id);
      if (result.code == 200) {
        await _dialogService.showDialog(title: "Pesan", descs: result.msg);
      }
    }
  }

  int getSubTotal() {
    double res = subPrice - (subPopDisc + vDisc);
    res += invoiceDetail.shippingMethod == "ambil ditempat" ? 0 : handlingCost;
    return res.toInt();
  }

  void clickToCopy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    final snackBar = SnackBar(
      content: Text('Copied to Clipboard'),
      action: SnackBarAction(label: 'OK', onPressed: () {}),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Clipboard.setData(ClipboardData(text: text));
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
}
