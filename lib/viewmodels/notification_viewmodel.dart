import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/notification_service.dart';
import 'package:binghan_mobile/models/notifications.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';

class NotificationViewModel extends BaseModel {
  final NotificationService _notificationService =
      locator<NotificationService>();
  final MemberService _memberService = locator<MemberService>();
  List<ListNotification> get listNotification =>
      _notificationService.listNotification;

  Future init() async {
    await getNotification();
  }

  Future<void> refreshInit() async {
    await getNotification();
  }

  Future getNotification() async {
    User userData = _memberService.userData;
    await _notificationService.getNotification(userData.binghanId ?? '');
    refresh();
  }

  Future readNotif(int id) async {
    await _notificationService.readNotif(id);
    refresh();
  }
}
