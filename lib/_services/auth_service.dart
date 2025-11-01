import 'dart:async';
import 'package:binghan_mobile/_services/api_post.dart';
import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/models/auth.dart';

class AuthService {
  final ApiPost _apiPost = locator<ApiPost>();

  StreamController<Auth> authController = StreamController<Auth>();
  Stream<Auth> get auth => authController.stream;

  Future<Auth> login(Map<String, dynamic> data) async {
    var fetchedUser = await _apiPost.login(data);
    authController.add(fetchedUser);
    return fetchedUser;
  }

  Future<Auth> forgotPass(String email) async {
    var fetchedUser = await _apiPost
        .forgotPass(email)
        .timeout(Duration(seconds: 10));
    authController.add(fetchedUser);
    return fetchedUser;
  }
}
