import 'package:binghan_mobile/_services/api_delete.dart';
import 'package:binghan_mobile/_services/api_get.dart';
import 'package:binghan_mobile/_services/api_post.dart';
import 'package:binghan_mobile/_services/api_put.dart';
import 'package:binghan_mobile/_services/cart_service.dart';
import 'package:binghan_mobile/_services/dashboard_service.dart';
import 'package:binghan_mobile/_services/invoice_service.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/notification_service.dart';
import 'package:binghan_mobile/_services/payment_services.dart';
import 'package:binghan_mobile/_services/product_service.dart';
import 'package:binghan_mobile/_services/splash_service.dart';
import 'package:binghan_mobile/_services/transferPv_service.dart';
import 'package:binghan_mobile/viewmodels/cart_viewmodel.dart';
import 'package:binghan_mobile/viewmodels/count_down_viewmodel.dart';
import 'package:binghan_mobile/viewmodels/member_viewmodel.dart';
import 'package:binghan_mobile/viewmodels/network_viewmodel.dart';
import 'package:binghan_mobile/viewmodels/notification_viewmodel.dart';
import 'package:binghan_mobile/viewmodels/order_viewmodel.dart';
import 'package:binghan_mobile/viewmodels/payment_viewmodel.dart';
import 'package:binghan_mobile/viewmodels/point_value_viewmodel.dart';
import 'package:binghan_mobile/viewmodels/product_viewmodel.dart';
import 'package:binghan_mobile/viewmodels/profile_viewmodal.dart';
import 'package:binghan_mobile/viewmodels/splash_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:binghan_mobile/_services/auth_service.dart';
import 'package:binghan_mobile/_services/dialog_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/viewmodels/dashboard_viewmodel.dart';
import 'package:binghan_mobile/viewmodels/auth_viewmodel.dart';

GetIt locator = GetIt.instance;
// NOTE : SETIAP ADA PENAMBAHAN SERVICE / VIEW MODEL HARUS DI TAMBAH DI FILE INI

void setupLocator() {
  // SERVICES LOCATOR
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => ApiGet());
  locator.registerLazySingleton(() => ApiPost());
  locator.registerLazySingleton(() => ApiDelete());
  locator.registerLazySingleton(() => ApiPut());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => MemberService());
  locator.registerLazySingleton(() => ProductService());
  locator.registerLazySingleton(() => CartServices());
  locator.registerLazySingleton(() => DashboardService());
  locator.registerLazySingleton(() => PaymentService());
  locator.registerLazySingleton(() => TransferPVService());
  locator.registerLazySingleton(() => InvoiceService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => SplashService());

  // VIEW MODEL LOCATOR
  locator.registerFactory(() => AuthViewModel());
  locator.registerFactory(() => DashboardViewModel());
  locator.registerFactory(() => MemberViewModel());
  locator.registerFactory(() => ProductViewModel());
  locator.registerFactory(() => ProfileViewModel());
  locator.registerFactory(() => OrderViewModel());
  locator.registerFactory(() => CartViewModal());
  locator.registerFactory(() => PaymentViewModel());
  locator.registerFactory(() => NetworkViewModel());
  locator.registerFactory(() => CountDownViewModal());
  locator.registerFactory(() => PointValueViewModel());
  locator.registerFactory(() => NotificationViewModel());
  locator.registerFactory(() => SplashViewModel());
}
