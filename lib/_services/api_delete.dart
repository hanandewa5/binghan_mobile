import 'dart:convert';
import 'package:binghan_mobile/models/res_api.dart';
import 'package:http/http.dart' as http;
import 'package:binghan_mobile/_constants/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiDelete {
  var client = http.Client();
  static const endpoint = AppConfig.apiUrl;
  var header = Map<String, String>.from(AppConfig.header);
  static const cartEndpoint = '$endpoint/v1/order-details';

  Future requestDeleteWithToken(String endpointUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header["Authorization"] = prefs.getString("token") ?? '';
    try {
      var response = await client
          .delete(Uri.parse(endpointUrl), headers: header)
          .timeout(Duration(seconds: AppConfig.timeoutRequest));
      return json.decode(response.body);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<ResApi> deleteCartItem(int id) async {
    var result = await requestDeleteWithToken('$cartEndpoint/$id');
    return ResApi.fromJson(result);
  }
}
