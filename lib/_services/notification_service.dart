import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/api_get.dart';
import 'package:binghan_mobile/models/notifications.dart';
import 'package:binghan_mobile/models/res_api.dart';

class NotificationService {
  final ApiGet _apiGet = locator<ApiGet>();

  int _notifBadgeCounter = 0;
  int get notifBadgeCounter => _notifBadgeCounter;

  final List<ListNotification> _listNotification = [];
  List<ListNotification> get listNotification => _listNotification;

  Future<Notifications> getNotification(String binghanId) async {
    listNotification.clear();
    var res = await _apiGet.getNotification(binghanId);
    if (res.code == 200 && res.data != null) {
      _notifBadgeCounter = res.data!.list!.length;
      listNotification.addAll(res.data!.list!);
    }
    return res;
  }

  Future<ResApi> readNotif(int id) async {
    var res = await _apiGet.readNotif(id);
    if (res.code == 200) {
      _listNotification.firstWhere((list) => list.id == id).isRead = 1;
    }

    return res;
  }
}
