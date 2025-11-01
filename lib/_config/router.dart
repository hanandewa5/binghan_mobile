import 'package:binghan_mobile/_constants/route_paths.dart' as routes;

import 'package:binghan_mobile/views/Auth/forgot_password.dart';
import 'package:binghan_mobile/views/Auth/reset_password.dart';
import 'package:binghan_mobile/views/Cart/cart_view.dart';
import 'package:binghan_mobile/views/Member/cara_bayar_view.dart';
import 'package:binghan_mobile/views/Member/group_sales_view.dart';
import 'package:binghan_mobile/views/Notification/notification_list_view.dart';
import 'package:binghan_mobile/views/Order/cara_bayar_view.dart';
import 'package:binghan_mobile/views/Order/invoice_detail_view.dart';
import 'package:binghan_mobile/views/Order/order_invoice_multi_view.dart';
import 'package:binghan_mobile/views/Order/order_invoice_view.dart';
import 'package:binghan_mobile/views/Order/order_track_view.dart';
import 'package:binghan_mobile/views/Payment/confirm_payment_view.dart';
import 'package:binghan_mobile/views/Payment/count_down_view.dart';
import 'package:binghan_mobile/views/Payment/courier_view.dart';
import 'package:binghan_mobile/views/Payment/delivery_view.dart';
import 'package:binghan_mobile/views/Payment/payment_detail.dart';
import 'package:binghan_mobile/views/Payment/payment_view.dart';
import 'package:binghan_mobile/views/Member/new_member_view.dart';
import 'package:binghan_mobile/views/Product/product_view.dart';
import 'package:binghan_mobile/views/Product/productDetail_view.dart';
import 'package:binghan_mobile/views/Profile/edit_profile._list_view.dart';
import 'package:binghan_mobile/views/Profile/edit_profile_akun_bank_view.dart';
import 'package:binghan_mobile/views/Profile/edit_profile_alamat_kantor_view.dart';
import 'package:binghan_mobile/views/Profile/edit_profile_alamat_rumah_view.dart';
import 'package:binghan_mobile/views/Profile/edit_profile_biodata_view.dart';
import 'package:binghan_mobile/views/Profile/edit_profile_document.dart';
import 'package:binghan_mobile/views/Profile/edit_profile_password.dart';
import 'package:binghan_mobile/views/Profile/profile_view.dart';
import 'package:binghan_mobile/views/Splash/splash_view.dart';
import 'package:binghan_mobile/views/TransferPV/available_trans_pv_view.dart';
import 'package:binghan_mobile/views/TransferPV/bonus_pv_list_view.dart';
import 'package:binghan_mobile/views/TransferPV/pv_list_view.dart';
import 'package:binghan_mobile/views/TransferPV/transverPV_view.dart';
import 'package:binghan_mobile/views/_widgets/Layout/web.dart';
import 'package:binghan_mobile/views/app.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/Dashboard/dashboard_view.dart';
import 'package:binghan_mobile/views/Auth/login_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // ? Splash
    case routes.SplashRoute:
      return SlideLeftRoute(page: SplashView());

    // ? AUTH
    case routes.LoginRoute:
      return SlideLeftRoute(page: LoginView());
    case routes.ForgotPassRoute:
      return SlideLeftRoute(page: ForgotPass());
    case routes.ResetPassRoute:
      return SlideLeftRoute(page: ResetPass());
    case routes.WebWelcome:
      return SlideLeftRoute(page: WebWelcome());

    // ? APP
    case routes.AppRoute:
      return SlideLeftRoute(page: App());

    // ? MEMBER
    case routes.NetworkRoute:
      return SlideLeftRoute(page: GroupSalesView());
    case routes.NewMemberRoute:
      return SlideLeftRoute(page: NewMember());
    case routes.CaraBayarMemberRoute:
      return SlideLeftRoute(page: CaraBayarMemberView());

    // ? HOME
    case routes.HomeRoute:
      return SlideLeftRoute(page: DashboardView());

    // ? PRODUCT
    case routes.ProductRoute:
      return SlideLeftRoute(page: Product());
    case routes.ProductDetailRoute:
      return SlideTopRoute(page: ProductDetail());

    // ? CART
    case routes.CartRoute:
      return SlideLeftRoute(page: Cart());

    // ? PAYMENT
    case routes.DeliveryRoute:
      return SlideLeftRoute(page: Delivery());
    case routes.CourierRoute:
      return SlideLeftRoute(page: CourierView());
    case routes.PaymentRoute:
      return SlideLeftRoute(page: Payment());
    case routes.PaymentDetailRoute:
      return SlideLeftRoute(page: PaymentDetailView());
    case routes.CountDownRoute:
      return SlideLeftRoute(page: CountDownView());
    case routes.ConfirmPaymentRoute:
      return SlideLeftRoute(page: ConfirmPaymentView());

    // ? PROFILE
    case routes.ProfileRoute:
      return SlideLeftRoute(page: Profile());
    case routes.EditProfileListRoute:
      return SlideLeftRoute(page: EditProfileList());
    case routes.EditProfileBioDataRoute:
      return SlideLeftRoute(page: EditProfileBiodataView());
    case routes.EditProfileAlamatRumahRoute:
      return SlideLeftRoute(page: EditProfileAlamatRumahView());
    case routes.EditProfileAlamatKantorRoute:
      return SlideLeftRoute(page: EditProfileAlamatKantorView());
    case routes.EditProfileAkunBankRoute:
      return SlideLeftRoute(page: EditProfileAkunBankView());
    case routes.EditPasswordRoute:
      return SlideLeftRoute(page: EditProfilePasswordView());
    case routes.EditDocumentRoute:
      return SlideLeftRoute(page: EditProfileDocumentView());

    // ? ORDER
    case routes.OrderInvoiceMultiTabRoute:
      return SlideLeftRoute(page: OrderInvoiceMultiView());
    case routes.OrderInvoiceHeaderTabRoute:
      return SlideLeftRoute(page: OrderInvoiceHeaderView());
    // case routes.OrderInvoiceHeaderTabRoute:
    //   return SlideLeftRoute(page: OrderHistoryTabView());
    case routes.InvoiceDetailRoute:
      return SlideLeftRoute(page: InvoiceDetailView());
    case routes.OrderTrackRoute:
      return SlideLeftRoute(page: OrderTrackView());
    case routes.OrderCaraBayar:
      return SlideLeftRoute(page: CaraBayarView());

    // ? Transfer PV
    case routes.AvailableTransferPVRoute:
      return SlideLeftRoute(page: AvailablePVTransView());
    case routes.TransferPVRoute:
      return SlideLeftRoute(page: TransferPVView());
    case routes.PVListRoute:
      return SlideLeftRoute(page: PVListView());
    case routes.BonusPVListRoute:
      return SlideLeftRoute(page: BonusPVListView());

    // ? Notification
    case routes.NotificationListRoute:
      return SlideLeftRoute(page: NotificationListView());

    default:
      return SlideLeftRoute(
        page: Scaffold(
          body: Center(child: Text('No path for ${settings.name}')),
        ),
      );
  }
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;
  SlideLeftRoute({required this.page})
    : super(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => page,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
      );
}

class SlideTopRoute extends PageRouteBuilder {
  final Widget page;
  SlideTopRoute({required this.page})
    : super(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => page,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
      );
}
