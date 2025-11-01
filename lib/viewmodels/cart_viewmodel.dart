import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_constants/route_paths.dart';
import 'package:binghan_mobile/_services/cart_service.dart';
import 'package:binghan_mobile/_services/dialog_service.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/_services/payment_services.dart';
import 'package:binghan_mobile/models/cart.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';

class CartViewModal extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final CartServices _cartServices = locator<CartServices>();
  final PaymentService _paymentService = locator<PaymentService>();
  final DialogService _dialogService = locator<DialogService>();
  final MemberService _memberService = locator<MemberService>();

  List<ListCart> get listCart => _cartServices.cartList;
  int get totalCart => _cartServices.cartBadgeCounter;
  bool checked(int id) =>
      listCart.firstWhere((cart) => cart.id == id).checked == true;
  bool get checkedAll => _cartServices.checkAll;
  int get subTotal => _cartServices.subTotal;
  bool get isNull => _cartServices.isNull;

  void init() {
    getCartList();
    print(listCart.length);
  }

  Future<void> refreshCart() async {
    await getCartList();
  }

  Future getCartList() async {
    User? userData = _memberService.userData;

    await _cartServices.getCartList(userData.id);
    refresh();
  }

  void checkOnce(int id) {
    _cartServices.checkOnceCart(id);
    refresh();
  }

  void checkAll() {
    _cartServices.checkAllCart();
    refresh();
  }

  void deleteOnce(int id) async {
    var resDialog = await _dialogService.showDialog(
      title: "Perhatian !",
      descs: "Apakah anda ingin mengapus item\n$id",
    );
    if (resDialog.confirmed) {
      var res = await _cartServices.deleteOnceCart(id);
      if (res.code != 200) {
        _dialogService.showDialog(title: "Perhatian !", descs: res.msg);
      }
      refresh();
    }
  }

  void increaseOnce(int id, int op) async {
    await _cartServices.editOnceCart(id, op);
    refresh();
  }

  void goToInvoice() {
    _cartServices.clearAmt();
    _paymentService.clearAmt();
    _navigationService.navigateTo(DeliveryRoute);
  }
}
