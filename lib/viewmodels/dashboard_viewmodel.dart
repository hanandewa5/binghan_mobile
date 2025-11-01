import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/cart_service.dart';
import 'package:binghan_mobile/_services/dashboard_service.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/_services/notification_service.dart';
import 'package:binghan_mobile/_services/transferPv_service.dart';
import 'package:binghan_mobile/models/bonus.dart';
import 'package:binghan_mobile/models/carousel.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;

class DashboardViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DashboardService _dashboardService = locator<DashboardService>();
  final CartServices _cartServices = locator<CartServices>();
  final NotificationService _notificationService =
      locator<NotificationService>();
  final MemberService _memberService = locator<MemberService>();
  final TransferPVService _transferPVService = locator<TransferPVService>();

  int get cartBadgeCounter => _cartServices.cartBadgeCounter;
  int get notifiBadgeCounter => _notificationService.listNotification
      .where((list) => list.isRead == 0)
      .length;
  List<ListCarousel> listCarousel = [];
  // String pointValue = "0 PV";
  String totalDirDownline = "0 Member";
  String totalDownline = "0 Member";
  // int get pointValue => _memberService.pointValue;
  int get availablePV => _transferPVService.availablePV;
  int totalPVMonth = 0;
  int pointValue = 0;
  String lastDateBonus = "";
  int bonusPV = 0;

  void init() {
    getCarousel();
    getCartList();
    getUser();
    // getTotalPVBulanIni();
  }

  Future<void> refreshInit() async {
    getCartList();
    getUser();
    // getTotalPVBulanIni();
    // getProductItem(null);
  }

  Future getUser() async {
    User? userData = _memberService.userData;
    DateTime startDate = DateTime(2017, 1, 1);
    DateTime endDate = DateTime.now();
    DateTime thisStartDate = DateTime(endDate.year, endDate.month, 1);

    pointValue = await _memberService.getTotalPV(
      userData.id ?? 0,
      startDate,
      endDate,
      1,
    );
    totalPVMonth = await _memberService.getTotalPV(
      userData.id ?? 0,
      thisStartDate,
      endDate,
      0,
    );
    var res = await _memberService.getTotalBonusPV(userData.binghanId ?? '');
    if (res != false) {
      ListBonus listBonus = ListBonus.fromJson(res);
      bonusPV = listBonus.bonus;
      lastDateBonus = listBonus.bulanFormated;
    }
    await _transferPVService.getAvailablePV(userData.id ?? 0);
    await getNotification();
    // var res = await _memberService.getDownline(userData.id);
    // var resMember = await _memberService.getMember();
    // if (res.code == 200) {
    //   totalDirDownline = (res.data.list.length - 1).toString() + " Member";
    //   totalDownline = (resMember.data.total).toString() + " Member";
    // }
    refresh();
  }

  Future getNotification() async {
    User userData = _memberService.userData;
    await _notificationService.getNotification(userData.binghanId ?? '');
  }

  Future getCartList() async {
    User userData = _memberService.userData;
    await _cartServices.getCartList(userData.id ?? 0);
    refresh();
  }

  // Future getTotalPVBulanIni() async {
  //   User userData = _memberService.userData;
  //   DateTime endDate = new DateTime.now();
  //   DateTime startDate = DateTime(endDate.year, endDate.month, 1);
  // var res =
  //     await _memberService.getPVHistory(userData.id, startDate, endDate);
  // totalPVMonth = 0;
  // if (res.code == 200) {
  //   if (res.data != null && res.data.list.length > 0) {
  //     for (var i = 0; i < res.data.list.length; i++) {
  //       totalPVMonth += res.data.list[i].amount;
  //     }
  //   }
  // }
  // refresh();
  // }

  Future getCarousel() async {
    listCarousel = [];
    var res = await _dashboardService.getCarousel();
    if (res.code == 200 && res.data != null) {
      for (var i = 0; i < (res.data!.list?.length ?? 0); i++) {
        ListCarousel suggest = res.data!.list![i];
        listCarousel.add(suggest);
      }
    }
    refresh();
  }

  void goToCart() {
    _navigationService.navigateTo("Cart");
  }

  void goToPvList() {
    _transferPVService.initPV();
    _navigationService.navigateTo(routes.PVListRoute);
  }

  void goToPvListBulanIni() {
    _transferPVService.initPVBulanIni();
    _navigationService.navigateTo(routes.PVListRoute);
  }

  void goToAvailablePVTrans() {
    _navigationService.navigateTo(routes.AvailableTransferPVRoute);
  }

  void goToBonusPVList() {
    _transferPVService.initBonusPV();
    _navigationService.navigateTo(routes.BonusPVListRoute);
  }

  void goToAddNewMember() {
    _navigationService.navigateTo(routes.NewMemberRoute);
  }

  void goToWebsite() {
    _navigationService.navigateTo(routes.WebWelcome);
  }

  void goToNotif() {
    _navigationService.navigateTo(routes.NotificationListRoute);
  }
}
