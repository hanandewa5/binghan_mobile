import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/cart_service.dart';
import 'package:binghan_mobile/_services/dialog_service.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/_services/product_service.dart';
import 'package:binghan_mobile/models/downline.dart';
import 'package:binghan_mobile/models/item.dart';
import 'package:binghan_mobile/models/item_detail.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';

class ProductViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ProductService _productService = locator<ProductService>();
  final MemberService _memberService = locator<MemberService>();
  final CartServices _cartServices = locator<CartServices>();
  final DialogService _dialogService = locator<DialogService>();

  int? get selectedId => _productService.id;
  int jumlah = 1;
  int total = 0;
  int price = 0;
  int popDisc = 0;

  bool complete = false;
  List<ListProductItem> listProductItem = [];

  ListDownline? downline;
  ListProductItemDetail? itemDetail;
  bool isDownline = true;
  bool isItemDetail = false;

  int get cartBadgeCounter => _cartServices.cartBadgeCounter;

  void setDownline(ListDownline listDownline) {
    print(listDownline.status);
    downline = listDownline;
  }

  void init() {
    getProductItem(null);
  }

  Future<void> refreshProduct() async {
    getProductItem(null);
  }

  Future<List<ListDownline>> getDownline(String filter) async {
    User userData = _memberService.userData;
    Map<String, dynamic> initDownline = {
      "binghan_id": userData.binghanId,
      "id": userData.id,
      "last_name": userData.lastName,
      "first_name": userData.firstName,
      "nama_sponsor": userData.namaSponsor,
      "status": userData.status,
    };
    List<ListDownline> listDownline = [];
    listDownline.add(ListDownline.fromJson(initDownline));

    var res = await _memberService.getDownline(userData.id ?? 0, filter);
    if (res.data != null) {
      for (var i = 0; i < (res.data!.list?.length ?? 0); i++) {
        ListDownline suggest = res.data!.list![i];
        listDownline.add(suggest);
      }
    }

    return listDownline;
  }

  Future getProductItem(int? id) async {
    var res = await _productService.getProductItem(id);
    listProductItem = [];
    if (res.code == 200 && res.data != null) {
      for (var i = 0; i < (res.data!.list?.length ?? 0); i++) {
        ListProductItem suggest = res.data!.list![i];
        listProductItem.add(suggest);
      }
    }
    refresh();
  }

  Future getProductItemDetail(int? id) async {
    setBusy(true);
    var res = await _productService.getProductItemDetail(id);
    if (res.code == 200 && res.data != null) {
      itemDetail = res.data!.itemDetail;
      isItemDetail = true;
      price = res.data!.itemDetail?.price ?? 0;
      total = res.data!.itemDetail?.price ?? 0;
      popDisc = res.data!.itemDetail?.popDiscount ?? 0;
    }
    setBusy(false);
  }

  Future addCart() async {
    User userData = _memberService.userData;

    if (downline == null) {
      _dialogService.showDialog(
        title: "Perhatian !",
        descs: "Harap pilih untuk siapa anda memesan !",
      );
      return false;
    }

    if (downline?.status == "Inactive") {
      _dialogService.showDialog(
        title: "Perhatian !",
        descs: "Maaf member yang anda pilih dalam status Inactive !",
      );
      return false;
    }

    Map<String, dynamic> data = {
      "item_id": selectedId,
      "member_order": userData.id,
      "order_for": downline?.id,
      "order_qty": jumlah,
    };
    if (userData.status?.toLowerCase() == "active") {
      var res = await _cartServices.addToCart(data);

      if (res.code == 200) {
        _cartServices.incrementCartBadgeCounter();
        var resDialog = await _dialogService.showDialog(
          title: "Pemesanan berhasil",
          descs: "Silahkan lanjut ke proses berikutnya",
          btnTittle: "Go To Cart",
        );

        if (resDialog.confirmed) {
          _navigationService.goBack();
          _navigationService.navigateTo("Cart");
        }
      } else {
        _dialogService.showDialog(title: "Perhatian !", descs: res.msg);
      }
    } else {
      await _dialogService.showDialog(
        title: "Perhatian !",
        descs:
            "Maaf akun anda dalam status tidak aktif, mohon hubungi pihak administrator",
      );
    }

    refresh();
  }

  void plusJumlah() {
    if (jumlah < (itemDetail?.stockAvailable ?? 0)) {
      jumlah++;
      total = (price * jumlah);
    }
    refresh();
  }

  void minJumlah() {
    if (jumlah > 1) {
      jumlah--;
      total = price * jumlah;
      refresh();
    }
  }

  goToProductDetail(int id) {
    _productService.setId(id);
    _navigationService.navigateTo("ProductDetail");
  }

  void goToCart() {
    _navigationService.navigateTo("Cart");
  }

  void goBack() {
    _navigationService.goBack();
  }
}
