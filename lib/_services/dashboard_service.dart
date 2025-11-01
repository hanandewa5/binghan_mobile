import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/api_get.dart';
import 'package:binghan_mobile/models/carousel.dart';

class DashboardService {
  ApiGet _apiGet = locator<ApiGet>();

  Future<Carousel> getCarousel() async {
    var res = await _apiGet.getCarousel();
    return res;
  }
}